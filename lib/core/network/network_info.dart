import 'dart:io';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  @override
  Future<bool> get isConnected async {
    try {
      final response = await InternetAddress.lookup('www.kindacode.com');
      return response.isNotEmpty ? Future.value(true) : Future.value(false);
    } on SocketException {
      return Future.value(false);
    }
  }
}
