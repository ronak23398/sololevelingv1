import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:solo_leveling_v1/app/controllers/auth_controllers.dart';
import 'package:solo_leveling_v1/app/widgets/level_up_dialogue.dart';

class XPController extends GetxController {
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final AuthController _authController = Get.find<AuthController>();

  RxInt currentXP = 0.obs;
  RxInt currentLevel = 1.obs;
  RxDouble xpProgress = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    currentXP.value = _authController.userModel.value.xp;
    currentLevel.value = _authController.userModel.value.level;
    _calculateXPProgress();
  }

  int requiredXP(int level) {
    // XP required for next level increases with level
    return level * 50;
  }

  void _calculateXPProgress() {
    int requiredXPForNextLevel = requiredXP(currentLevel.value);
    xpProgress.value = currentXP.value / requiredXPForNextLevel;
  }

  Future<void> addXP(int amount) async {
    if (_authController.firebaseUser.value == null) return;

    currentXP.value += amount;
    int requiredXPForNextLevel = requiredXP(currentLevel.value);

    // Check if user levels up
    if (currentXP.value >= requiredXPForNextLevel) {
      // Level up!
      currentLevel.value++;
      currentXP.value -= requiredXPForNextLevel;

      // Show level up dialog
      Get.dialog(LevelUpDialog(
        level: currentLevel.value,
      ));
    }

    _calculateXPProgress();

    // Update in Firebase Realtime Database
    await _database
        .ref()
        .child('users')
        .child(_authController.firebaseUser.value!.uid)
        .update({
      'xp': currentXP.value,
      'level': currentLevel.value,
    });

    // Update local user model
    _authController.userModel.value.xp = currentXP.value;
    _authController.userModel.value.level = currentLevel.value;
  }
}
