import 'package:flutter/cupertino.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_manager/core/constants/constants.dart';
import 'package:task_manager/core/models/task_model.dart';
import 'package:task_manager/features/todo/controllers/todo_provider.dart';
import 'package:task_manager/features/todo/widgets/todo_tile.dart';

class CompletedTasks extends ConsumerWidget {
  const CompletedTasks({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<TaskModel> listData = ref.watch(toDoStateProvider);
    List<String> lastMonth = ref.read(toDoStateProvider.notifier).last30Days();

    var completedTasks = listData
        .where((element) =>
            element.isCompleted == 1 ||
            lastMonth.contains(element.date!.substring(0, 10)))
        .toList();

    return ListView.builder(
      itemCount: completedTasks.length,
      itemBuilder: (context, index) {
        final data = completedTasks[index];
        dynamic color = ref.read(toDoStateProvider.notifier).getRandomColor();

        return TodoTile(
          delete: () {
            ref.read(toDoStateProvider.notifier).deleteItem(data.id!);
          },
          editWidget: const SizedBox.shrink(),
          color: color,
          title: data.title,
          description: data.desc,
          start: data.startTime,
          end: data.endTime,
          switcher: const Icon(
            AntDesign.checkcircle,
            color: AppConst.green,
          ),
        );
      },
    );
  }
}
