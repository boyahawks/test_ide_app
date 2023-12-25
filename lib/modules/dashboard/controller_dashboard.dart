part of "./dashboard.dart";

class DashboardController extends GetxController {
  RxString email = "".obs;
  RxString name = "".obs;
  RxString tokenUser = "".obs;
  RxString base64BannerSelected = "".obs;

  var nameBanner = TextEditingController().obs;

  RxList<BannerModel> listBanner = <BannerModel>[].obs;

  Rx<File?> gambarBannerSelected = Rx<File?>(null);

  void init() {
    getInformasiLogin();
  }

  Future<void> getInformasiLogin() async {
    AuthModel dataAuth = AuthModel.fromJson(jsonDecode(AppData.authInformasi));
    email.value = dataAuth.email;
    email.refresh();
    name.value = dataAuth.name;
    name.refresh();
    String loadNewToken = await AuthService.refreshToken(dataAuth.clientId,
        dataAuth.clientSecret, dataAuth.email, AppData.passwordUser);
    tokenUser.value = loadNewToken;
    tokenUser.refresh();
    AppData.tokenUser = loadNewToken;
    dataAuth.staticToken = loadNewToken;
    String newInformasiAuthUser = dataAuth.toStringJson();
    AppData.authInformasi = newInformasiAuthUser;
    loadListBanner(dataAuth.clientId, dataAuth.clientSecret);
  }

  Future<void> loadListBanner(String clientId, String keySecret) async {
    DateTime now = DateTime.now();
    DateTime newDate = now.add(const Duration(minutes: 2));
    String dateNow = DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').format(newDate);
    String timeStime = dateNow + "Z";
    String dataToSign =
        "path=/list-banner&verb=GET&token=Bearer ${tokenUser.value}&timestamp=$timeStime&body=";
    String secretKey = keySecret;
    String signatureUser = Utility.generateSHA256HMAC(dataToSign, secretKey);
    // String signature =
    dynamic loadBanner = await DasboardService.loadListDashboard(
        tokenUser.value, timeStime, signatureUser, clientId);
    if (loadBanner != null) {
      List<dynamic> listDataResponse = loadBanner["responseData"];
      if (listDataResponse.isNotEmpty) {
        listBanner.value =
            listDataResponse.map((e) => BannerModel.fromJson(e)).toList();
        listBanner.refresh();
      }
    } else {
      UtilsAlert.showToast("Gagal load banner");
    }
  }

  Future<void> takePicture() async {
    final getFoto = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        preferredCameraDevice: CameraDevice.front,
        imageQuality: 100,
        maxHeight: 500,
        maxWidth: 500);
    if (getFoto == null) {
      UtilsAlert.showToast("Gagal mengambil gambar");
    } else {
      var file = File(getFoto.path);
      gambarBannerSelected.value = File(getFoto.path);
      gambarBannerSelected.refresh();
      var base64Banner = base64Encode(file.readAsBytesSync());
      base64BannerSelected.value = base64Banner;
      base64BannerSelected.refresh();
    }
  }

  Future<void> addBanner() async {
    AuthModel dataAuth = AuthModel.fromJson(jsonDecode(AppData.authInformasi));
    DateTime now = DateTime.now();
    DateTime newDate = now.add(const Duration(minutes: 2));
    String dateNow = DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').format(newDate);
    String timeStamp = dateNow + "Z";

    final formData = dio.FormData.fromMap({
      'banner_name': nameBanner.value.text,
      'banner_image':
          await dio.MultipartFile.fromFile(gambarBannerSelected.value!.path),
    });

    String path = '/add-banner';
    String verb = 'POST';
    String token = 'Bearer ${tokenUser.value}';
    String timestamp = timeStamp;

    String dataToSign =
        "path=$path&verb=$verb&token=$token&timestamp=$timestamp&body=$formData";

    String secretKey = dataAuth.clientSecret;

    String signatureUser = Utility.generateSHA256HMAC(dataToSign, secretKey);

    dynamic sendAddBanner = await DasboardService.addBanner(
        formData, tokenUser.value, timestamp, signatureUser, dataAuth.clientId);
    if (sendAddBanner != null) {
      loadListBanner(dataAuth.clientId, dataAuth.clientSecret);
    }
  }

  Future<void> logoutAccount() async {
    AppData.authInformasi = "";
    AppData.passwordUser = "";
    AppData.tokenUser = "";
    Routes.routeOff(type: "splash");
  }
}
