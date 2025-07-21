import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hive_ce_flutter/adapters.dart';

import '../widgets/smooth_typewriter_text.dart';
import '../../core/services/task_service.dart';
import '../widgets/add_task_modal.dart';
import '../widgets/task_tile.dart';
import '../../core/hive_model/task_model.dart';
import '../../utilities/screen_size_config.dart';
import '../../utilities/app_typography.dart';
import '../../utilities/app_colors.dart';

class TaskScreen extends StatefulWidget {
  static String id = 'task-screen';
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  List<TaskModel> taskList = [];
  bool _isExtended = true;
  TaskService taskService = TaskService();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    taskList = taskService.getTask();

    _scrollController.addListener(() {
      final isAtTop = _scrollController.offset <= 50;
      final isScrollingDown =
          _scrollController.position.userScrollDirection ==
          ScrollDirection.reverse;

      if (isScrollingDown && _isExtended) {
        setState(() => _isExtended = false);
      } else if (!isScrollingDown && !_isExtended && isAtTop) {
        setState(() => _isExtended = true);
      }
    });
  }

  void _showAddTaskModal() {
    showModalBottomSheet(
      context: context,
      builder: (context) => AddTaskModal(
        onTaskAdded: (String taskName) {
          taskService.addTask(taskName);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<TaskModel>('tasks');
    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: box.listenable(),
          builder: (context, Box<TaskModel> updatedBox, _) {
            return Column(
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
                      Container(
                        width: ScreenSizeConfig.screenWidth * 0.2,
                        height: ScreenSizeConfig.screenWidth * 0.2,
                        decoration: BoxDecoration(
                          color: AppColors.primaryBlue,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.primaryBlue,
                            width: 5.0,
                          ),
                        ),
                        child: CircleAvatar(
                          backgroundColor: AppColors.pureWhite,
                          maxRadius: ScreenSizeConfig.screenWidth * 0.1,
                          child: Image.asset(
                            'assets/gifs/to-do-list.gif',
                            height: ScreenSizeConfig.screenWidth * 0.1,
                            colorBlendMode: BlendMode.multiply,
                          ),
                        ),
                      ),
                      SmoothTypewriterText(
                        text: 'Todoey',
                        textStyle: AppTypography.titleLarge,
                      ),
                      Text(
                        '${updatedBox.length} Tasks',
                        style: AppTypography.labelTextStyle.copyWith(
                          color: AppColors.primaryBlue,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 20.0,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryBG,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50.0),
                        topRight: Radius.circular(50.0),
                      ),
                    ),
                    child: updatedBox.isEmpty
                        ? Center(
                            child: Text(
                              'Add Tasks',
                              style: AppTypography.labelTextStyle.copyWith(
                                color: AppColors.textColor,
                              ),
                            ),
                          )
                        : ListView.builder(
                            controller: _scrollController,
                            itemCount: updatedBox.length,
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              final task = updatedBox.getAt(index)!;
                              return TaskTile(
                                key: ValueKey(task.key),
                                task: task,
                                onDelete: () => task.delete(),
                              );
                            },
                          ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: _isExtended
          ? AnimatedContainer(
              width: ScreenSizeConfig.screenWidth * 0.25,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: FloatingActionButton.extended(
                isExtended: _isExtended,
                backgroundColor: AppColors.primaryBlue,
                elevation: 10.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0),
                ),
                label: Text('Add', style: AppTypography.buttonTextStyle),
                icon: Icon(Icons.add),
                onPressed: _showAddTaskModal,
              ),
            )
          : AnimatedContainer(
              width: ScreenSizeConfig.screenWidth * 0.13,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: FloatingActionButton.extended(
                backgroundColor: AppColors.primaryBlue,
                elevation: 10.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0),
                ),
                icon: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Icon(Icons.add),
                ),
                label: SizedBox(),
                onPressed: _showAddTaskModal,
              ),
            ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
