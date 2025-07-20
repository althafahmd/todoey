import '../models/task_model.dart';

class TaskService {
  List<TaskModel> tasks = [];

  List<TaskModel> getTask() {
    return tasks;
  }

  void addTask(String taskName) {
    tasks.add(TaskModel(name: taskName));
  }

  void deleteTask(int index) {
    if ((index >= 0) && (index < tasks.length)) {
      tasks.removeAt(index);
    } else {
      return;
    }
  }
}
