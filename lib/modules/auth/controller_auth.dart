part of "./auth.dart";

class AuthController extends GetxController {
  var email = TextEditingController(text: "examinationIDE@mail.com").obs;
  var password = TextEditingController().obs;

  RxBool showPassword = false.obs;
  RxBool showPasswordConfirm = false.obs;

  Future<void> validasiLogin() async {
    UtilsAlert.loadingSimpanData(
        context: Get.context!, text: "Sedang Proses", dismiss: false);
    dynamic responseValidasiLogin = await AuthService.validasiLoginService(
        email.value.text, password.value.text);
    if (responseValidasiLogin != null) {
      dynamic dataBody = responseValidasiLogin["responseData"];
      AuthModel dataAuth = AuthModel.fromJson(dataBody);
      AppData.authInformasi = dataAuth.toStringJson();
      AppData.passwordUser = password.value.text;
      password.value.clear();
      Get.back();
      Routes.routeOff(type: "dashboard");
    } else {
      Get.back();
      UtilsAlert.showToast("Kombinasi Email dan password salah");
    }
  }
}
