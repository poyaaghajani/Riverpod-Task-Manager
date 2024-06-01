import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle reusableStyle(double size, Color color, FontWeight fw) {
  return GoogleFonts.poppins(
    color: color,
    fontSize: size.sp,
    fontWeight: fw,
  );
}
