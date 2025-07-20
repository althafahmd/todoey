import 'package:flutter/cupertino.dart';

import '../../utilities/app_typography.dart';
import 'primary_button.dart';
import 'primary_form_field.dart';
import '../../utilities/app_colors.dart';
import '../../utilities/app_constants.dart';

class AddTaskModal extends StatefulWidget {
  final Function(String) onTaskAdded;

  const AddTaskModal({super.key, required this.onTaskAdded});

  @override
  State<AddTaskModal> createState() => _AddTaskModalState();
}

class _AddTaskModalState extends State<AddTaskModal> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30.0),
          topLeft: Radius.circular(30.0),
        ),
      ),
      child: Column(
        spacing: 5.0,
        children: [
          Text(
            'Add Task',
            style: AppTypography.titleMedium.copyWith(fontSize: 30.0),
          ),
          PrimaryFormField(
            controller: _controller,
            autofocus: true,
            hintText: 'Task',
            onChanged: (value) {},
          ),
          PrimaryButton(
            onTap: () {
              final taskName = _controller.text.trim();
              if (taskName.isNotEmpty) {
                widget.onTaskAdded(taskName);
                Navigator.pop(context);
              }
            },
            shape: AppConstants.primaryButtonShape,
            child: Text('Add', style: AppTypography.buttonTextStyle),
          ),
        ],
      ),
    );
  }
}
