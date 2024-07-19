import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_manager/core/constants/constants.dart';
import 'package:task_manager/core/helpers/notification_helper.dart';
import 'package:task_manager/core/models/task_model.dart';
import 'package:task_manager/core/utils/show_dialog.dart';
import 'package:task_manager/core/widgets/custom_outlined_btn.dart';
import 'package:task_manager/core/widgets/custom_text_filed.dart';
import 'package:task_manager/core/widgets/gap.dart';
import 'package:task_manager/core/widgets/reusable_style.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;
import 'package:task_manager/features/todo/controllers/date_provider.dart';
import 'package:task_manager/features/todo/controllers/todo_provider.dart';

class AddTaskPage extends ConsumerStatefulWidget {
  const AddTaskPage({super.key});

  @override
  ConsumerState<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends ConsumerState<AddTaskPage> {
  final NotificationHelper notificationHelper = NotificationHelper();
  final TextEditingController _title = TextEditingController();
  final TextEditingController _desc = TextEditingController();

  @override
  void dispose() {
    _title.dispose();
    _desc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var scheduleDate = ref.watch(dateStateProvider);
    var startTime = ref.watch(startTimeStateProvider);
    var endTime = ref.watch(endTimeStateProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 40.h),
        child: Column(
          children: [
            const Gap(height: 20),
            CustomTextFiled(
              textInputAction: TextInputAction.next,
              hintText: 'Add title',
              hintStyle: reusableStyle(16, AppConst.greyLight, FontWeight.w600),
              controller: _title,
            ),
            const Gap(height: 20),
            CustomTextFiled(
              hintText: 'Add descripotion',
              hintStyle: reusableStyle(16, AppConst.greyLight, FontWeight.w600),
              controller: _desc,
            ),
            const Gap(height: 20),
            CustomOutlinedBtn(
              onTap: () {
                picker.DatePicker.showDatePicker(
                  context,
                  showTitleActions: true,
                  minTime: DateTime(2024, 1, 1),
                  maxTime: DateTime(2050, 1, 1),
                  theme: AppConst.datePickerTheme,
                  onConfirm: (date) {
                    ref
                        .read(dateStateProvider.notifier)
                        .setDate(date.toString().substring(0, 10));
                  },
                  currentTime: DateTime.now(),
                  locale: picker.LocaleType.en,
                );
              },
              height: 52.h,
              width: AppConst.appWidth,
              color: AppConst.light,
              bgColor: AppConst.blueLight,
              text: scheduleDate == '' ? 'Set Date' : scheduleDate,
            ),
            const Gap(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomOutlinedBtn(
                  onTap: () {
                    picker.DatePicker.showDateTimePicker(
                      context,
                      showTitleActions: true,
                      minTime: DateTime(2024, 5, 5, 20, 50),
                      maxTime: DateTime(2050, 6, 7, 05, 09),
                      theme: AppConst.datePickerTheme,
                      onConfirm: (date) {
                        ref
                            .read(startTimeStateProvider.notifier)
                            .setStart(date.toString().substring(11, 16));
                      },
                      currentTime: DateTime.now(),
                      locale: picker.LocaleType.en,
                    );
                  },
                  height: 52.h,
                  width: AppConst.appWidth * 0.4,
                  color: AppConst.light,
                  bgColor: AppConst.blueLight,
                  text: startTime == '' ? 'Start Time' : startTime,
                ),
                CustomOutlinedBtn(
                  onTap: () {
                    picker.DatePicker.showDateTimePicker(
                      context,
                      showTitleActions: true,
                      minTime: DateTime(2024, 5, 5, 20, 50),
                      maxTime: DateTime(2050, 6, 7, 05, 09),
                      theme: AppConst.datePickerTheme,
                      onConfirm: (date) {
                        ref
                            .read(endTimeStateProvider.notifier)
                            .setEnd(date.toString().substring(11, 16));
                      },
                      currentTime: DateTime.now(),
                      locale: picker.LocaleType.en,
                    );
                  },
                  height: 52.h,
                  width: AppConst.appWidth * 0.4,
                  color: AppConst.light,
                  bgColor: AppConst.blueLight,
                  text: endTime == '' ? 'End Time' : endTime,
                ),
              ],
            ),
            const Spacer(),
            CustomOutlinedBtn(
              onTap: () async {
                if (_title.text.isNotEmpty &&
                    _desc.text.isNotEmpty &&
                    scheduleDate.isNotEmpty &&
                    startTime.isNotEmpty &&
                    endTime.isNotEmpty) {
                  TaskModel task = TaskModel(
                    title: _title.text,
                    desc: _desc.text,
                    date: scheduleDate,
                    startTime: startTime,
                    endTime: endTime,
                    isCompleted: 0,
                    remind: 0,
                    repeat: 'yes',
                  );

                  int newTaskId =
                      await ref.read(toDoStateProvider.notifier).addItem(task);

                  String notificationTime = '$scheduleDate $startTime';

                  NotificationHelper.showScheduleNotification(
                    DateTime.parse(notificationTime),
                    task,
                    newTaskId,
                  );
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                } else {
                  showAlretDialog(
                    context: context,
                    msg: 'Please fill all fields',
                  );
                }
              },
              height: 52.h,
              width: AppConst.appWidth,
              color: AppConst.light,
              bgColor: AppConst.green,
              text: 'Submit',
            ),
          ],
        ),
      ),
    );
  }
}
