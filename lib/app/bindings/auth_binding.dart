import 'package:get/get.dart';
import 'package:solo_leveling_v1/app/controllers/auth_controllers.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
  }
}
