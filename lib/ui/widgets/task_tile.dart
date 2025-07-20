import 'package:flutter/material.dart';

import '../../utilities/app_colors.dart';
import '../../utilities/app_typography.dart';

class TaskTile extends StatefulWidget {
  final String taskName;
  final VoidCallback onDelete;

  const TaskTile({super.key, required this.taskName, required this.onDelete});

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  bool isChecked = false;
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
        onChanged: (value) {
          setState(() {
            isChecked = !isChecked;
          });
        },
      ),
      title: Text(
        widget.taskName,
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
