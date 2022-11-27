import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkService {
  static final NetworkService _networkService = NetworkService._internal();

  factory NetworkService() => _networkService;

  var _isConnected = false;

  bool get isConnected => _isConnected;

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  NetworkService._internal() : super() {}

  void subscribe() {
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      _updateConnectionStatus,
    );
  }

  Future<bool> getConnectivity() async {
    ConnectivityResult connectivityResult =
        await _connectivity.checkConnectivity();
    return connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi;
  }

  _updateConnectionStatus(ConnectivityResult result) {
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      _isConnected = true;
    } else {
      _isConnected = false;
    }
  }

  void cancel() {
    _connectivitySubscription.cancel();
  }
}
