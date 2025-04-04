import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solo_leveling_v1/app/controllers/auth_controllers.dart';
import 'package:solo_leveling_v1/app/controllers/task_controller.dart';
import 'package:solo_leveling_v1/app/controllers/xp_controller.dart';
import 'package:solo_leveling_v1/app/routes/app_pages.dart';
import 'package:solo_leveling_v1/app/widgets/app_progress_bar.dart';

class HomeScreen extends StatelessWidget {
  final AuthController _authController = Get.find<AuthController>();
  final XPController _xpController = Get.find<XPController>();
  final TaskController taskController = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "SOLO LEVELING FITNESS",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => _authController.signOut(),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          // Hunter Info Card
          Obx(() => Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFF212121),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.blue[700],
                          child: Text(
                            "LV${_xpController.currentLevel.value}",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _authController.userModel.value.name ?? "Hunter",
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                            Text(
                              "E-Rank Hunter",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    XPProgressBar(
                      progress: _xpController.xpProgress.value,
                      currentXP: _xpController.currentXP.value,
                      requiredXP: _xpController
                          .requiredXP(_xpController.currentLevel.value),
                    ),
                  ],
                ),
              )),
          SizedBox(height: 30),
          // Menu Options
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: EdgeInsets.all(16),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                _buildMenuItem(
                  context,
                  "Daily Quests",
                  Icons.fitness_center,
                  Colors.deepPurple,
                  () => Get.toNamed(Routes.TASKS),
                ),
                _buildMenuItem(
                  context,
                  "Profile",
                  Icons.person,
                  Colors.blue,
                  () => Get.toNamed(Routes.PROFILE),
                ),
                _buildMenuItem(
                  context,
                  "Statistics",
                  Icons.bar_chart,
                  Colors.green,
                  () {},
                ),
                _buildMenuItem(
                  context,
                  "Achievements",
                  Icons.emoji_events,
                  Colors.amber,
                  () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF212121),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 32,
                color: color,
              ),
            ),
            SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
