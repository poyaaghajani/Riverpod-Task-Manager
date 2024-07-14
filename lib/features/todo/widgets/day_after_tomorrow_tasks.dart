import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_manager/config/routes/app_route.dart';
import 'package:task_manager/core/constants/constants.dart';
import 'package:task_manager/core/widgets/xpansion_tile.dart';
import 'package:task_manager/features/todo/controllers/todo_provider.dart';
import 'package:task_manager/features/todo/controllers/xpansion_provider.dart';
import 'package:task_manager/features/todo/pages/update_page.dart';
import 'package:task_manager/features/todo/widgets/todo_tile.dart';

class DayAfterTomorrowTasks extends ConsumerWidget {
  const DayAfterTomorrowTasks({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(toDoStateProvider);
    final daysAfter =
        ref.read(toDoStateProvider.notifier).getDayAfterTomorrow();
    dynamic color = ref.read(toDoStateProvider.notifier).getRandomColor();

    var dayAfterTaks =
        todos.where((element) => element.date!.contains(daysAfter)).toList();

    return XpansionTile(
      text: DateTime.now()
          .add(const Duration(days: 2))
          .toString()
          .substring(5, 10),
      text2: "Day after tomorrow tasks",
      onExpansionChanged: (isExpanded) {
        ref.read(xpansionState0Provider.notifier).setStart(!isExpanded);
      },
      trailing: Padding(
        padding: EdgeInsets.only(right: 12.w),
        child: ref.watch(xpansionState0Provider)
            ? const Icon(
                AntDesign.closecircleo,
                color: AppConst.light,
              )
            : const Icon(
                AntDesign.circledown,
                color: AppConst.blueLight,
              ),
      ),
      children: [
        for (final todo in dayAfterTaks)
          TodoTile(
            title: todo.title,
            description: todo.desc,
            color: color,
            start: todo.startTime,
            end: todo.endTime,
            delete: () {
              ref.read(toDoStateProvider.notifier).deleteItem(todo.id!);
            },
            editWidget: GestureDetector(
              onTap: () {
                context.push(UpdateTaskPage(task: todo));
              },
              child: const Icon(MaterialCommunityIcons.circle_edit_outline),
            ),
            switcher: const SizedBox.shrink(),
          ),
      ],
    );
  }
}
