import 'package:flutter/material.dart';
import 'package:todoey/core/hive_model/task_model.dart';

import '../../utilities/app_colors.dart';
import '../../utilities/app_typography.dart';

class TaskTile extends StatefulWidget {
  final TaskModel task;
  final VoidCallback onDelete;

  const TaskTile({super.key, required this.task, required this.onDelete});

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    isChecked = widget.task.isDone;
  }

  void _toggleCheckbox(bool? value) {
    setState(() {
      isChecked = value!;
      widget.task.isDone = isChecked;
      widget.task.save();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        activeColor: AppColors.primaryBlue,
        shape: CircleBorder(),
        checkColor: AppColors.pureWhite,
        side: BorderSide(
          width: 2.0,
          style: BorderStyle.solid,
          color: AppColors.pureWhite,
        ),
        value: isChecked,
        onChanged: _toggleCheckbox,
      ),
      title: Text(
        widget.task.name,
        style: AppTypography.taskTextStyle.copyWith(
          color: isChecked ? AppColors.textColor : AppColors.pureWhite,
          decoration: isChecked
              ? TextDecoration.lineThrough
              : TextDecoration.none,
        ),
      ),
      trailing: IconButton(
        onPressed: widget.onDelete,
        icon: Icon(Icons.close_rounded),
      ),
    );
  }
}
