import 'package:data_connection_checker/data_connection_checker.dart';

abstract class NetworkInfoContract {
  Future<bool> hasNetworkConnection();
}

class NetworkInfo implements NetworkInfoContract {
  final DataConnectionChecker dataConnectionChecker;

  NetworkInfo(this.dataConnectionChecker);

  @override
  Future<bool> hasNetworkConnection() async =>
      await dataConnectionChecker.hasConnection;
}
