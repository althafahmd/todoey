import 'package:hive_ce/hive.dart';

import '../hive_model/task_model.dart';

class TaskService {
  final Box<TaskModel> taskBox = Hive.box<TaskModel>('tasks');

  List<TaskModel> getTask() {
    return taskBox.values.toList();
  }

  void addTask(String taskName) {
    final task = TaskModel(name: taskName);
    taskBox.add(task);
  }

  void deleteTask(int index) {
    final key = taskBox.keyAt(index);
    taskBox.delete(key);
  }
}
