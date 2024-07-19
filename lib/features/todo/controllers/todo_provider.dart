import 'dart:math';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:task_manager/core/constants/constants.dart';
import 'package:task_manager/core/helpers/db_helper.dart';
import 'package:task_manager/core/models/task_model.dart';
part 'todo_provider.g.dart';

@riverpod
class ToDoState extends _$ToDoState {
  @override
  List<TaskModel> build() {
    return [];
  }

  Future<void> refresh() async {
    final data = await DbHelper.getItems();

    state = data.map((e) => TaskModel.fromJson(e)).toList();
  }

  Future<int> addItem(TaskModel task) async {
    final newTaskId = await DbHelper.createItem(task);
    refresh();
    return newTaskId;
  }

  dynamic getRandomColor() {
    Random random = Random();
    int randomIndex = random.nextInt(colors.length);

    return colors[randomIndex];
  }

  Future<void> updateItem({
    required int id,
    required String title,
    required String desc,
    required int isCompleted,
    required String date,
    required String startTime,
    required String endTime,
  }) async {
    await DbHelper.updateItem(
      id: id,
      title: title,
      desc: desc,
      isCompleted: isCompleted,
      date: date,
      startTime: startTime,
      endTime: endTime,
    );
    refresh();
  }

  Future<void> deleteItem(int id) async {
    await DbHelper.deleteItem(id);
    refresh();
  }

  Future<void> markAsCompleted({
    required int id,
    required String title,
    required String desc,
    required String date,
    required String startTime,
    required String endTime,
  }) async {
    await DbHelper.updateItem(
      id: id,
      title: title,
      desc: desc,
      isCompleted: 1,
      date: date,
      startTime: startTime,
      endTime: endTime,
    );
    refresh();
  }

  String getToday() {
    DateTime today = DateTime.now();

    return today.toString().substring(0, 10);
  }

  String getTomorrow() {
    DateTime tomorrow = DateTime.now().add(const Duration(days: 1));

    return tomorrow.toString().substring(0, 10);
  }

  String getDayAfterTomorrow() {
    DateTime tomorrow = DateTime.now().add(const Duration(days: 2));

    return tomorrow.toString().substring(0, 10);
  }

  List<String> last30Days() {
    DateTime today = DateTime.now();
    DateTime oneMonthAgo = today.subtract(const Duration(days: 30));

    List<String> dates = [];

    for (int i = 0; i < 30; i++) {
      DateTime date = oneMonthAgo.add(Duration(days: i));
      dates.add(date.toString().substring(0, 10));
    }

    return dates;
  }

  bool getStatus(TaskModel task) {
    bool? isCompleted;

    if (task.isCompleted == 0) {
      isCompleted = false;
    } else {
      isCompleted = true;
    }

    return isCompleted;
  }
}
