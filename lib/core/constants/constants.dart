import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;
import 'package:task_manager/core/widgets/reusable_style.dart';

class AppConst {
  AppConst._();

  static const Color dark = Color(0xff2a2b2e);
  static const Color light = Color(0xffffffff);
  static const Color red = Color(0xffd80000);
  static const Color blueLight = Color(0xff027eb5);
  static const Color greyDark = Color(0xff707070);
  static const Color greyLight = Color(0xff667781);
  static const Color green = Color(0xff20a31e);
  static const Color yellow = Color(0xfff9f900);
  static const Color lightBk = Color(0x58797777);
  static const Color greyBk = Color(0xff202c33);

  static double appWidth = 392.w;
  static double appHeight = 802.h;
  static double radius = 12.h;

  static const String bell = "assets/images/bell.png";
  static const String notification = "assets/images/notification.png";
  static const String todo = "assets/images/todo.png";

  static var datePickerTheme = picker.DatePickerTheme(
    itemStyle: reusableStyle(16, AppConst.green, FontWeight.w500),
    doneStyle: reusableStyle(16, AppConst.green, FontWeight.w700),
    cancelStyle: reusableStyle(16, AppConst.blueLight, FontWeight.w700),
  );
}

const List<dynamic> colors = [
  Color(0xffd80000),
  Color(0xff027eb5),
  Color(0xff20a31e),
  Color(0xfff9f900),
  Color(0xFF770271),
  Color(0xFFFFA008),
  Color(0xFF00FFBF),
];
