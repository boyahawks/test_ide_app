part of "./auth.dart";

class AuthService {
  static Future<dynamic> validasiLoginService(
      String email, String password) async {
    dynamic resultData;
    try {
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
      Map<String, String> body = {"email": email, "password": password};
      var prosesApi = Api.connectionApi("post", body, "api/login", headers);
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

  static Future<dynamic> refreshToken(String clientId, String clientSecret,
      String email, String password) async {
    dynamic resultData;
    try {
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
      Map<String, String> body = {
        "grant_type": "password",
        "client_id": clientId,
        "client_secret": clientSecret,
        "username": email,
        "password": password,
        "scope": "*",
      };
      var prosesApi = Api.connectionApi("post", body, "oauth/token", headers);
      var getValue = await prosesApi;
      var response = jsonDecode(getValue.body);

      if (response["access_token"] != "") {
        resultData = response["access_token"];
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
}
