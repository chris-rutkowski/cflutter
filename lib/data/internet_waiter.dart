import 'dart:io';

import 'package:data_connection_checker/data_connection_checker.dart';

abstract class InternetWaiter {
  bool get seemsOnline;
  Future<bool> get isOnline;
  Future<void> wait();
  void dispose();
}

class InternetWaiterImpl implements InternetWaiter {
  @override
  bool seemsOnline;

  final Duration seemsOnlineRefreshDuration;

  bool _disposed = false;

  InternetWaiterImpl._([Duration seemsOnlineRefreshDuration])
      : seemsOnlineRefreshDuration =
            seemsOnlineRefreshDuration ?? Duration(seconds: 10);

  factory InternetWaiterImpl([Duration seemsOnlineRefreshDuration]) =>
      InternetWaiterImpl._(seemsOnlineRefreshDuration)
        .._addIPV6()
        .._checkSeemsOnline();

  void _checkSeemsOnline() async {
    if (_disposed) return;
    seemsOnline = await DataConnectionChecker().hasConnection;
    await Future.delayed(seemsOnlineRefreshDuration);
    if (_disposed) return;
    _checkSeemsOnline();
  }

  @override
  void dispose() => _disposed = true;

  @override
  Future<bool> get isOnline => DataConnectionChecker().hasConnection;

  @override
  Future<void> wait() async {
    if (await isOnline) return true;

    await Future.delayed(Duration(milliseconds: 1000));
    return await wait();
  }

  void _addIPV6() {
    final addresses = <AddressCheckOptions>[];

    List<AddressCheckOptions>.from(
      DataConnectionChecker.DEFAULT_ADDRESSES,
    );

    addresses.addAll([
      AddressCheckOptions(
        // Google
        InternetAddress('2001:4860:4860::8888', type: InternetAddressType.IPv6),
        port: DataConnectionChecker.DEFAULT_PORT,
        timeout: DataConnectionChecker.DEFAULT_TIMEOUT,
      ),
      AddressCheckOptions(
        // Google
        InternetAddress('2001:4860:4860::8844', type: InternetAddressType.IPv6),
        port: DataConnectionChecker.DEFAULT_PORT,
        timeout: DataConnectionChecker.DEFAULT_TIMEOUT,
      ),
      AddressCheckOptions(
        // CloudFlare
        InternetAddress('2606:4700:4700::64', type: InternetAddressType.IPv6),
        port: DataConnectionChecker.DEFAULT_PORT,
        timeout: DataConnectionChecker.DEFAULT_TIMEOUT,
      ),
      AddressCheckOptions(
        // CloudFlare
        InternetAddress('2606:4700:4700::6400', type: InternetAddressType.IPv6),
        port: DataConnectionChecker.DEFAULT_PORT,
        timeout: DataConnectionChecker.DEFAULT_TIMEOUT,
      ),
      AddressCheckOptions(
        // OpenDNS
        InternetAddress('2620:119:35::35', type: InternetAddressType.IPv6),
        port: DataConnectionChecker.DEFAULT_PORT,
        timeout: DataConnectionChecker.DEFAULT_TIMEOUT,
      ),
      AddressCheckOptions(
        // OpenDNS
        InternetAddress('2620:119:53::53', type: InternetAddressType.IPv6),
        port: DataConnectionChecker.DEFAULT_PORT,
        timeout: DataConnectionChecker.DEFAULT_TIMEOUT,
      ),
    ]);
    DataConnectionChecker().addresses = addresses;
  }
}
