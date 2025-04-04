import 'package:get/get.dart';
import 'package:solo_leveling_v1/app/controllers/task_controller.dart';
import 'package:solo_leveling_v1/app/controllers/xp_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TaskController>(() => TaskController());
    Get.lazyPut<XPController>(() => XPController());
  }
}
