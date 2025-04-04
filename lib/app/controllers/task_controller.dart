import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:solo_leveling_v1/app/controllers/auth_controllers.dart';
import 'package:solo_leveling_v1/app/controllers/xp_controller.dart';
import 'package:solo_leveling_v1/app/models/task_model.dart';

class TaskController extends GetxController {
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final AuthController _authController = Get.find<AuthController>();
  late XPController _xpController;

  RxList<TaskModel> tasks = <TaskModel>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _xpController = Get.find<XPController>();
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    if (_authController.firebaseUser.value == null) return;

    isLoading.value = true;
    try {
      // Get tasks from Firebase Realtime Database
      DatabaseEvent taskEvent =
          await _database.ref().child('tasks').limitToFirst(5).once();

      // Get user's completed tasks
      DatabaseEvent userEvent = await _database
          .ref()
          .child('users')
          .child(_authController.firebaseUser.value!.uid)
          .child('completed_tasks')
          .once();

      List<String> completedTaskIds = [];
      if (userEvent.snapshot.exists && userEvent.snapshot.value != null) {
        if (userEvent.snapshot.value is List) {
          completedTaskIds =
              List<String>.from(userEvent.snapshot.value as List);
        }
      }

      tasks.clear();
      if (taskEvent.snapshot.exists && taskEvent.snapshot.value != null) {
        Map<dynamic, dynamic> tasksMap = taskEvent.snapshot.value as Map;

        tasksMap.forEach((key, value) {
          // Map the Firebase fields to your TaskModel fields
          Map<String, dynamic> taskData = Map<String, dynamic>.from(value);

          TaskModel task = TaskModel(
              id: key.toString(),
              name: taskData['title'] ?? '', // Map 'title' to 'name'
              xp: taskData['xp_reward'] ?? 0, // Map 'xp_reward' to 'xp'
              isCompleted: completedTaskIds.contains(key.toString()));

          tasks.add(task);
        });
      }

      // For debugging, print what we found
      print('Fetched ${tasks.length} tasks');
      for (var task in tasks) {
        print(
            'Task ID: ${task.id}, Name: ${task.name}, XP: ${task.xp}, Completed: ${task.isCompleted}');
      }
    } catch (e) {
      print('Error fetching tasks: $e');
      Get.snackbar(
        "Error",
        "Failed to load tasks",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> completeTask(TaskModel task) async {
    if (_authController.firebaseUser.value == null) return;

    try {
      // Mark task as completed
      task.isCompleted = true;
      tasks.refresh();

      // Get current completed tasks
      DatabaseReference userTasksRef = _database
          .ref()
          .child('users')
          .child(_authController.firebaseUser.value!.uid)
          .child('completed_tasks');

      DatabaseEvent event = await userTasksRef.once();
      List<String> completedTasks = [];

      if (event.snapshot.exists && event.snapshot.value != null) {
        if (event.snapshot.value is List) {
          completedTasks = List<String>.from(event.snapshot.value as List);
        }
      }

      // Add new task if not already in the list
      if (!completedTasks.contains(task.id)) {
        completedTasks.add(task.id!);
      }

      // Update the user's completed tasks
      await userTasksRef.set(completedTasks);

      // Add XP to user
      await _xpController.addXP(task.xp);

      Get.snackbar(
        "Task Completed!",
        "You earned ${task.xp} XP",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      print('Error completing task: $e');
      Get.snackbar(
        "Error",
        "Failed to complete task",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
