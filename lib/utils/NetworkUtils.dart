import 'package:connectivity/connectivity.dart';
import 'package:wan_android_demo/utils/Log.dart';

class NetworkUtils {

  factory NetworkUtils() {
    return _singleton;
  }

  static NetworkUtils _singleton = NetworkUtils._internal();

  NetworkUtils._internal();

  String TAG = "NetworkUtils";

  ///
  /// 网络状态
  /// WiFi: Device connected via Wi-Fi
  ///Mobile: Device connected to cellular network
  ///None: Device not connected to any network
  Future<int> _getNetWorkState() async {
    var connectivityResult = await (new Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile)
      return 1;
    else if (connectivityResult == ConnectivityResult.wifi)
      return 2;
    else if (connectivityResult == ConnectivityResult.none) return 0;
  }

  Future<bool> isConnect() async {
    var netWorkState = await _getNetWorkState();
    bool isConnectB = false;
    if (netWorkState == 0) {
      isConnectB = false;
    } else {
      isConnectB = true;
    }
    Log.logT(TAG, "isConnect::::$isConnectB state::::$netWorkState");
    return isConnectB;
  }
}
