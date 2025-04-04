import 'package:firebase_database/firebase_database.dart';

void uploadTasks() {
  final DatabaseReference ref = FirebaseDatabase.instance.ref("tasks");

  final Map<String, dynamic> tasks = {
    "task1": {
      "title": "Do 20 Push-ups",
      "description": "Complete 20 push-ups to build upper body strength.",
      "xp_reward": 10,
      "difficulty": "Easy"
    },
    "task2": {
      "title": "Run for 10 Minutes",
      "description": "Jog or run continuously for 10 minutes.",
      "xp_reward": 15,
      "difficulty": "Medium"
    },
    "task3": {
      "title": "Plank for 1 Minute",
      "description": "Hold the plank position for at least 60 seconds.",
      "xp_reward": 10,
      "difficulty": "Easy"
    },
    "task4": {
      "title": "Jump Rope for 5 Minutes",
      "description": "Use a skipping rope for 5 minutes without stopping.",
      "xp_reward": 20,
      "difficulty": "Medium"
    },
    "task5": {
      "title": "Squats - 30 Reps",
      "description": "Perform 30 bodyweight squats.",
      "xp_reward": 12,
      "difficulty": "Easy"
    },
    "task6": {
      "title": "Burpees - 15 Reps",
      "description": "Do 15 full burpees to boost endurance.",
      "xp_reward": 20,
      "difficulty": "Hard"
    },
    "task7": {
      "title": "Meditate for 5 Minutes",
      "description": "Sit quietly and focus on your breathing for 5 minutes.",
      "xp_reward": 5,
      "difficulty": "Easy"
    },
    "task8": {
      "title": "Drink 2 Liters of Water",
      "description":
          "Stay hydrated by drinking at least 2 liters of water today.",
      "xp_reward": 5,
      "difficulty": "Easy"
    }
  };

  ref.set(tasks).then((_) {
    print("Tasks uploaded successfully!");
  }).catchError((error) {
    print("Failed to upload tasks: $error");
  });
}
