import 'package:data_connection_checker/data_connection_checker.dart';

abstract class InternetWaiter {
  Future<bool> get online;
  Future wait();
}

class InternetWaiterImpl implements InternetWaiter {
  @override
  Future<bool> get online => DataConnectionChecker().hasConnection;

  @override
  Future wait() async {
    if (await online) return true;

    await Future.delayed(Duration(milliseconds: 1000));
    return await wait();
  }
}
