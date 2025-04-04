import 'package:get/get.dart';
import 'package:solo_leveling_v1/app/controllers/auth_controllers.dart';
import 'package:solo_leveling_v1/app/controllers/task_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController(), permanent: true);

    Get.lazyPut<TaskController>(() => TaskController());
  }
}
