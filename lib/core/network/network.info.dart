import 'package:data_connection_checker/data_connection_checker.dart';

abstract class AbstractNetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfo implements AbstractNetworkInfo {
  final DataConnectionChecker connectionChecker;

  NetworkInfo(this.connectionChecker);

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}
