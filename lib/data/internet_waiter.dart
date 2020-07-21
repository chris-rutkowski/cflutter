import 'package:data_connection_checker/data_connection_checker.dart';

abstract class InternetWaiter {
  Future wait();
}

class InternetWaiterImpl implements InternetWaiter {
  @override
  Future wait() async {
    if (await DataConnectionChecker().hasConnection) {
      return true;
    }
    await Future.delayed(Duration(milliseconds: 1000));
    return await wait();
  }
}
