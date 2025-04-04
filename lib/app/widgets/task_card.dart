import 'package:flutter/material.dart';
import 'package:solo_leveling_v1/app/models/task_model.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task;
  final VoidCallback onCompleted;

  const TaskCard({
    Key? key,
    required this.task,
    required this.onCompleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: task.isCompleted
            ? Colors.green.withOpacity(0.1)
            : Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(10),
        border: task.isCompleted
            ? Border.all(color: Colors.green.withOpacity(0.5), width: 1)
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: task.isCompleted ? null : onCompleted,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                // Task completion indicator
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: task.isCompleted ? Colors.green : Colors.blue[700],
                  ),
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    task.isCompleted ? Icons.check : Icons.fitness_center,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                SizedBox(width: 16),
                // Task details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color:
                              task.isCompleted ? Colors.white60 : Colors.white,
                          decoration: task.isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        task.isCompleted ? "Completed" : "Tap to complete",
                        style: TextStyle(
                          fontSize: 12,
                          color:
                              task.isCompleted ? Colors.green : Colors.white60,
                        ),
                      ),
                    ],
                  ),
                ),
                // XP reward
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: task.isCompleted
                        ? Colors.green.withOpacity(0.2)
                        : Colors.amber.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: task.isCompleted
                          ? Colors.green.withOpacity(0.5)
                          : Colors.amber.withOpacity(0.5),
                    ),
                  ),
                  child: Text(
                    "+${task.xp} XP",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: task.isCompleted ? Colors.green : Colors.amber,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
