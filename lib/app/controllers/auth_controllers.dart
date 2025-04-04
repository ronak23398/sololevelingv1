import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:solo_leveling_v1/app/models/user_model.dart';
import 'package:solo_leveling_v1/app/routes/app_pages.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  Rx<User?> firebaseUser = Rx<User?>(null);
  Rx<UserModel> userModel = UserModel().obs;

  @override
  void onInit() {
    super.onInit();
    firebaseUser.bindStream(_auth.authStateChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) async {
    if (user != null) {
      // User is logged in
      await _getUserData(user.uid);
      Get.offAllNamed(Routes.HOME);
    } else {
      // User is not logged in
      Get.offAllNamed(Routes.LOGIN);
    }
  }

  Future<void> _getUserData(String userId) async {
    try {
      DatabaseEvent event =
          await _database.ref().child('users').child(userId).once();

      if (event.snapshot.exists) {
        Map<String, dynamic> userData =
            Map<String, dynamic>.from(event.snapshot.value as Map);
        userModel.value = UserModel.fromJson(userData);
      }
    } catch (e) {
      print('Error getting user data: $e');
    }
  }

  Future<void> signUp(String email, String password, String name) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Create user in Realtime Database
      UserModel newUser = UserModel(
        id: userCredential.user!.uid,
        name: name,
        email: email,
        level: 1,
        xp: 0,
        completedTasks: [],
      );

      await _database
          .ref()
          .child('users')
          .child(userCredential.user!.uid)
          .set(newUser.toJson());

      userModel.value = newUser;
    } catch (e) {
      Get.snackbar(
        "Error creating account",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      Get.snackbar(
        "Error signing in",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      Get.snackbar(
        "Error signing out",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
