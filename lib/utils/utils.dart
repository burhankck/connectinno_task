import 'dart:io';

class Utils { 
  static List<String> normalizationSystemError(Object? error) {
    String errorText = error.toString();
    List<String> splittedList = List.filled(2, '');
    splittedList = errorText.split(':');
    splittedList.last = errorText;

    return splittedList;
  }


   static Future<bool> checkInternetConnection() async {
    try {
     
      final result = await InternetAddress.lookup('google.com')
          .timeout(const Duration(seconds: 3));

      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true; 
      } else {
        return false; 
      }
    } on SocketException catch (_) {
      return false; 
    } on Exception {
      return false;
    }
  }

}