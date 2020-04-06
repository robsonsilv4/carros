import 'package:connectivity/connectivity.dart';

Future<bool> isNetworkon() async {
  final connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    return false;
  }
  return true;
}
