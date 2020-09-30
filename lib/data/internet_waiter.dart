import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;

abstract class InternetWaiter {
  bool get seemsOnline;
  Future<bool> get isOnline;
  Future<void> wait();
  void dispose();
}

class InternetWaiterImpl implements InternetWaiter {
  final String _fallbackUrl;
  final Duration _seemsOnlineRefreshDuration;
  bool _disposed = false;

  @override
  bool seemsOnline;

  InternetWaiterImpl._([
    this._seemsOnlineRefreshDuration,
    this._fallbackUrl,
  ]);

  factory InternetWaiterImpl({
    Duration seemsOnlineRefreshDuration = const Duration(seconds: 10),
    String fallbackUrl,
  }) =>
      InternetWaiterImpl._(seemsOnlineRefreshDuration, fallbackUrl)
        .._checkSeemsOnline();

  void _checkSeemsOnline() async {
    if (_disposed) return;
    final seemsOnline = await _checkInternetAccess();
    this.seemsOnline = seemsOnline;
    await Future.delayed(_seemsOnlineRefreshDuration);
    if (_disposed) return;
    _checkSeemsOnline();
  }

  @override
  void dispose() => _disposed = true;

  @override
  Future<bool> get isOnline => _checkInternetAccess();

  @override
  Future<void> wait() async {
    if (await isOnline) return true;

    await Future.delayed(Duration(milliseconds: 1000));
    return await wait();
  }

  Future<bool> _checkInternetAccess() async {
    var result = await _checkDNSes();

    if (result == false && _fallbackUrl != null) {
      try {
        await http.get(_fallbackUrl);
        result = true;
      } catch (_) {}
    }

    return result;
  }

  Future<bool> _checkDNSes() {
    /// We use a mix of IPV4 and IPV6 here in case some networks only accept one of the types.
    /// Only tested with an IPV4 only network so far (I don't have access to an IPV6 network).
    final dnss = <InternetAddress>[
      InternetAddress('8.8.8.8', type: InternetAddressType.IPv4), // Google
      InternetAddress('2001:4860:4860::8888',
          type: InternetAddressType.IPv6), // Google
      InternetAddress('1.1.1.1', type: InternetAddressType.IPv4), // CloudFlare
      InternetAddress('2606:4700:4700::1111',
          type: InternetAddressType.IPv6), // CloudFlare
      InternetAddress('208.67.222.222',
          type: InternetAddressType.IPv4), // OpenDNS
      InternetAddress('2620:0:ccc::2',
          type: InternetAddressType.IPv6), // OpenDNS
      InternetAddress('180.76.76.76', type: InternetAddressType.IPv4), // Baidu
      InternetAddress('2400:da00::6666',
          type: InternetAddressType.IPv6), // Baidu
    ];

    final completer = Completer<bool>();

    var callsReturned = 0;
    void onCallReturned(bool isAlive) {
      if (completer.isCompleted) return;

      if (isAlive) {
        completer.complete(true);
      } else {
        callsReturned++;
        if (callsReturned >= dnss.length) {
          completer.complete(false);
        }
      }
    }

    dnss.forEach((dns) => _pingDns(dns).then(onCallReturned));

    return completer.future;
  }

  Future<bool> _pingDns(InternetAddress dnsAddress) async {
    const dnsPort = 53;
    const timeout = Duration(seconds: 3);

    Socket socket;
    try {
      socket = await Socket.connect(dnsAddress, dnsPort, timeout: timeout);
      socket?.destroy();
      return true;
    } on SocketException {
      socket?.destroy();
    }
    return false;
  }
}
