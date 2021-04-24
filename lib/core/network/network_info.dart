import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:simple_parking/core/entities/network_info.dart';

abstract class NetworkInfoContract {
  Future<bool> hasNetworkConnection();
}

class NetworkInfo implements NetworkInfoContract {
  @override
  Future<bool> hasNetworkConnection() async {
    return await DataConnectionChecker().hasConnection;
  }
}
