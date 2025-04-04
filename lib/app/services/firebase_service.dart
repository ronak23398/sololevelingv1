import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:solo_leveling_v1/app/models/task_model.dart';
import 'package:solo_leveling_v1/app/models/user_model.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  // Authentication Methods
  Future<UserCredential> signUpWithEmail(String email, String password) async {
    return await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> signInWithEmail(String email, String password) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    return await _auth.signOut();
  }

  // User Methods
  Future<void> createUser(UserModel user) async {
    await _database.ref().child('users').child(user.id!).set(user.toJson());
  }

  Future<UserModel?> getUser(String userId) async {
    DatabaseEvent event =
        await _database.ref().child('users').child(userId).once();

    if (event.snapshot.exists) {
      Map<String, dynamic> userData =
          Map<String, dynamic>.from(event.snapshot.value as Map);
      return UserModel.fromJson(userData);
    }
    return null;
  }

  Future<void> updateUser(String userId, Map<String, dynamic> data) async {
    await _database.ref().child('users').child(userId).update(data);
  }

  // Task Methods
  Future<List<TaskModel>> getTasks() async {
    DatabaseEvent event = await _database.ref().child('tasks').once();

    if (event.snapshot.exists) {
      Map<dynamic, dynamic> tasksMap = event.snapshot.value as Map;
      List<TaskModel> tasks = [];

      tasksMap.forEach((key, value) {
        TaskModel task = TaskModel.fromJson(Map<String, dynamic>.from(value));
        task.id = key.toString();
        tasks.add(task);
      });

      return tasks;
    }
    return [];
  }

  Future<void> addTaskToUser(String userId, String taskId) async {
    DatabaseReference userTasksRef =
        _database.ref().child('users').child(userId).child('completed_tasks');

    // Get current completed tasks
    DatabaseEvent event = await userTasksRef.once();
    List<String> completedTasks = [];

    if (event.snapshot.exists && event.snapshot.value != null) {
      if (event.snapshot.value is List) {
        completedTasks = List<String>.from(event.snapshot.value as List);
      }
    }

    // Add new task if not already in the list
    if (!completedTasks.contains(taskId)) {
      completedTasks.add(taskId);
    }

    // Update the user's completed tasks
    await userTasksRef.set(completedTasks);
  }

  // Sample tasks initialization (you would call this only once)
  Future<void> initializeSampleTasks() async {
    // Check if tasks exist
    DatabaseEvent event = await _database.ref().child('tasks').once();

    if (!event.snapshot.exists) {
      // Add sample tasks
      List<Map<String, dynamic>> sampleTasks = [
        {'name': 'Do 20 push-ups', 'xp': 10},
        {'name': 'Run 1 km', 'xp': 15},
        {'name': 'Do 30 squats', 'xp': 12},
        {'name': 'Do 15 burpees', 'xp': 20},
        {'name': 'Plank for 1 minute', 'xp': 15},
        {'name': 'Do 50 jumping jacks', 'xp': 8},
        {'name': 'Do 20 lunges', 'xp': 10},
        {'name': 'Go for a 20-minute walk', 'xp': 10},
        {'name': 'Do 15 mountain climbers', 'xp': 12},
        {'name': 'Do 10 pull-ups', 'xp': 25},
      ];

      DatabaseReference tasksRef = _database.ref().child('tasks');
      for (var task in sampleTasks) {
        tasksRef.push().set(task);
      }
    }
  }
}
