import 'package:hive_ce/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  bool isDone;

  TaskModel({required this.name, this.isDone = false});
}
