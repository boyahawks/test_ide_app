part of "./dashboard.dart";

class DasboardService {
  static Future<dynamic> loadListDashboard(
      String token, String dateNow, String signature, String clientId) async {
    dynamic resultData;
    try {
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'IDE-Timestamp': dateNow,
        'IDE-Signature': signature,
        'Client-ID': clientId
      };
      var prosesApi = Api.connectionApi("get", "", "api/list-banner", headers);
      var getValue = await prosesApi;
      var response = jsonDecode(getValue.body);

      if (response["responseCode"] == true) {
        resultData = response;
      } else {
        UtilsAlert.showToast(response["responseMessage"]);
        resultData = null;
      }
    } catch (e) {
      UtilsAlert.showToast("Error : $e");
      resultData = null;
    }
    return resultData;
  }

  static Future<dynamic> pingData(
      String token, String timeStamp, String signature, String clientId) async {
    dynamic resultData;
    try {
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'IDE-Timestamp': timeStamp,
        'IDE-Signature': signature,
        'Client-ID': clientId
      };
      var prosesApi = Api.connectionApi("get", "", "api/ping", headers);
      var getValue = await prosesApi;
      var response = jsonDecode(getValue.body);

      if (response["responseCode"] == true) {
        resultData = response;
      } else {
        UtilsAlert.showToast(response["responseMessage"]);
        resultData = null;
      }
    } catch (e) {
      UtilsAlert.showToast("Error : $e");
      resultData = null;
    }
    return resultData;
  }

  static Future<dynamic> addBanner(dynamic formData, String token, String time,
      String signature, String clientId) async {
    dynamic resultData;
    Dio dioSend = Dio();
    try {
      Options options = Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': '*/*',
          'Content-Type': 'multipart/form-data',
          'IDE-Timestamp': time,
          'IDE-Signature': signature,
          'Client-ID': clientId,
        },
      );
      final response = await dioSend.post(
          'https://api-entrance-test.infraedukasi.com/api/add-banner',
          data: formData,
          options: options);

      print(response);
      resultData = response;
    } catch (error) {
      resultData = null;
      // Handle DioError
      if (error is DioError) {
        print('DioError: ${error.message}');
        if (error.response != null) {
          print('error1 ${error.requestOptions.data}');
          print('error2 ${error.requestOptions.method}');
          print('Response data: ${error.response?.data}');
          print('Response status: ${error.response?.statusCode}');
          UtilsAlert.showToast("Signature BE tidak sesuai");
        }
      } else {
        // Handle other types of errors
        print('Error: $error');
      }
    }

    return resultData;
  }
}
