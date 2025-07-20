import 'package:flutter/material.dart';

import '../../core/services/task_service.dart';
import '../widgets/add_task_modal.dart';
import '../widgets/task_tile.dart';
import '../../core/models/task_model.dart';
import '../../utilities/screen_size_config.dart';
import '../../utilities/app_typography.dart';
import '../../utilities/app_colors.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  List<TaskModel> taskList = [];
  TaskService taskService = TaskService();

  @override
  void initState() {
    super.initState();
    taskList = taskService.getTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(
                top: 60.0,
                right: 30.0,
                bottom: 30.0,
                left: 30.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    maxRadius: ScreenSizeConfig.screenWidth * 0.085,
                    backgroundColor: AppColors.pureWhite,
                    child: Icon(
                      Icons.list,
                      color: AppColors.cardColor,
                      size: ScreenSizeConfig.screenWidth * 0.1,
                    ),
                  ),
                  Text('Todoey', style: AppTypography.titleLarge),
                  Text(
                    '${taskList.length} Tasks',
                    style: AppTypography.labelTextStyle.copyWith(
                      color: AppColors.primaryBlue,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                decoration: BoxDecoration(
                  color: AppColors.primaryBG,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.0),
                    topRight: Radius.circular(50.0),
                  ),
                ),
                child: taskList.isEmpty
                    ? Center(
                        child: Text(
                          'Add Tasks',
                          style: AppTypography.labelTextStyle.copyWith(
                            color: AppColors.textColor,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: taskList.length,
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) => TaskTile(
                          taskName: taskList[index].name,
                          onDelete: () {
                            setState(() {
                              taskService.deleteTask(index);
                              taskService.getTask();
                            });
                          },
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryBlue,
        shape: CircleBorder(),
        elevation: 10.0,
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => AddTaskModal(
              onTaskAdded: (String taskName) {
                setState(() {
                  taskService.addTask(taskName);
                  taskList = taskService.getTask(); // Update local state
                });
              },
            ),
          );
        },
      ),
    );
  }
}
