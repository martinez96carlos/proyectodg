import 'dart:io';

Future<bool> checkInternet() async {
  try {
    final res = await InternetAddress.lookup('google.com');
    if (res.isNotEmpty && res[0].rawAddress.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  } on SocketException catch(_) {
    return false;
  }
}