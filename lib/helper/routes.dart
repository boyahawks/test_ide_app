import 'package:get/get.dart';
import 'package:test_ide/main.dart';
import 'package:test_ide/modules/auth/auth.dart';
import 'package:test_ide/modules/dashboard/dashboard.dart';
// import 'package:test_ide/modules/weather/weather.dart';

class Routes {
  static routeTo({required String type, dynamic data}) {
    if (type == "regis") {}
    // else if (type == "read_antologi") {
    //   Get.to(
    //     ReadAntologi(
    //       controller: data[0],
    //       kategori: data[1],
    //       chapter: data[2],
    //       dataAntologi: data[3],
    //       pencarian: data[4],
    //     ),
    //     duration: const Duration(milliseconds: 300),
    //     transition: Transition.leftToRight,
    //   );
    // }
  }

  static routeOff({required String type, dynamic data}) {
    if (type == "login") {
      Get.offAll(
        AuthLogin(),
        duration: const Duration(milliseconds: 300),
        transition: Transition.leftToRightWithFade,
      );
    } else if (type == "dashboard") {
      Get.offAll(
        const Dashboard(),
        duration: const Duration(milliseconds: 300),
        transition: Transition.leftToRightWithFade,
      );
    } else if (type == "splash") {
      Get.offAll(
        const SplashScreen(),
        duration: const Duration(milliseconds: 300),
        transition: Transition.leftToRightWithFade,
      );
    }
  }
}
