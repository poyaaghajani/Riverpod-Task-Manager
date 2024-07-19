import 'package:flutter/cupertino.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_manager/config/routes/app_route.dart';
import 'package:task_manager/core/constants/constants.dart';
import 'package:task_manager/core/helpers/notification_helper.dart';
import 'package:task_manager/core/models/task_model.dart';
import 'package:task_manager/features/todo/controllers/todo_provider.dart';
import 'package:task_manager/features/todo/pages/update_page.dart';
import 'package:task_manager/features/todo/widgets/todo_tile.dart';

class PendingTasks extends ConsumerWidget {
  const PendingTasks({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<TaskModel> listData = ref.watch(toDoStateProvider);
    String today = ref.read(toDoStateProvider.notifier).getToday();

    var todayList = listData
        .where((element) =>
            element.isCompleted == 0 && element.date!.contains(today))
        .toList();

    return ListView.builder(
      itemCount: todayList.length,
      itemBuilder: (context, index) {
        final data = todayList[index];
        bool isCompleted = ref.read(toDoStateProvider.notifier).getStatus(data);
        dynamic color = ref.read(toDoStateProvider.notifier).getRandomColor();

        return TodoTile(
          delete: () {
            NotificationHelper.cancel(data.id!);
            ref.read(toDoStateProvider.notifier).deleteItem(data.id!);
          },
          editWidget: GestureDetector(
            onTap: () {
              context.push(UpdateTaskPage(task: data));
            },
            child: const Icon(MaterialCommunityIcons.circle_edit_outline),
          ),
          color: color,
          title: data.title,
          description: data.desc,
          start: data.startTime,
          end: data.endTime,
          switcher: CupertinoSwitch(
            trackColor: AppConst.greyBk,
            value: isCompleted,
            onChanged: (value) {
              ref.read(toDoStateProvider.notifier).markAsCompleted(
                    id: data.id!,
                    title: data.title!,
                    desc: data.desc!,
                    date: data.date!,
                    startTime: data.startTime!,
                    endTime: data.endTime!,
                  );
            },
          ),
        );
      },
    );
  }
}
