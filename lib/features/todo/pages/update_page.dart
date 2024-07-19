import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_manager/core/constants/constants.dart';
import 'package:task_manager/core/helpers/notification_helper.dart';
import 'package:task_manager/core/models/task_model.dart';
import 'package:task_manager/core/widgets/custom_outlined_btn.dart';
import 'package:task_manager/core/widgets/custom_text_filed.dart';
import 'package:task_manager/core/widgets/gap.dart';
import 'package:task_manager/core/widgets/reusable_style.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;
import 'package:task_manager/features/todo/controllers/date_provider.dart';
import 'package:task_manager/features/todo/controllers/todo_provider.dart';

class UpdateTaskPage extends ConsumerStatefulWidget {
  const UpdateTaskPage({super.key, required this.task});

  final TaskModel task;

  @override
  ConsumerState<UpdateTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends ConsumerState<UpdateTaskPage> {
  late TextEditingController _title;
  late TextEditingController _desc;

  @override
  void initState() {
    _title = TextEditingController(text: widget.task.title);
    _desc = TextEditingController(text: widget.task.desc);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(dateStateProvider.notifier).setDate(widget.task.date!);
      ref
          .read(startTimeStateProvider.notifier)
          .setStart(widget.task.startTime!);
      ref.read(endTimeStateProvider.notifier).setEnd(widget.task.endTime!);
    });

    super.initState();
  }

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
              hintText: 'Add title',
              textInputAction: TextInputAction.next,
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
              onTap: () {
                if (_title.text.isNotEmpty &&
                    _desc.text.isNotEmpty &&
                    scheduleDate.isNotEmpty &&
                    startTime.isNotEmpty &&
                    endTime.isNotEmpty) {
                  NotificationHelper.cancel(widget.task.id!);

                  ref.read(toDoStateProvider.notifier).updateItem(
                        id: widget.task.id!,
                        title: _title.text,
                        desc: _desc.text,
                        date: scheduleDate,
                        isCompleted: 0,
                        startTime: startTime,
                        endTime: endTime,
                      );

                  String notificationTime = '$scheduleDate $startTime';

                  NotificationHelper.showScheduleNotification(
                    DateTime.parse(notificationTime),
                    widget.task,
                    widget.task.id!,
                  );

                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please fill all fields'),
                    ),
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
