import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solo_leveling_v1/app/controllers/task_controller.dart';
import 'package:solo_leveling_v1/app/widgets/task_card.dart';

class TaskScreen extends StatelessWidget {
  final TaskController _taskController = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "DAILY QUESTS",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Complete your tasks to gain XP and level up!",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 24),
            Expanded(
              child: Obx(() {
                if (_taskController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }

                if (_taskController.tasks.isEmpty) {
                  return Center(child: Text("No tasks available"));
                }

                return ListView.builder(
                  itemCount: _taskController.tasks.length,
                  itemBuilder: (context, index) {
                    final task = _taskController.tasks[index];
                    return TaskCard(
                      task: task,
                      onCompleted: () => _taskController.completeTask(task),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
