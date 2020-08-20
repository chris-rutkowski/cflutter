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
      InternetWaiterImpl._(seemsOnlineRefreshDuration).._checkSeemsOnline();

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
}
