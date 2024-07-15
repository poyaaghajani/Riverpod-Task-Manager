import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_manager/core/constants/constants.dart';
import 'package:task_manager/core/utils/show_dialog.dart';
import 'package:task_manager/core/widgets/custom_outlined_btn.dart';
import 'package:task_manager/core/widgets/custom_text_filed.dart';
import 'package:task_manager/core/widgets/reusable_style.dart';
import 'package:task_manager/core/widgets/reusable_text.dart';
import 'package:task_manager/features/auth/controllers/auth_controller.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LiginPageState();
}

class _LiginPageState extends ConsumerState<LoginPage> {
  final TextEditingController _phone = TextEditingController();
  Country _country = Country(
    phoneCode: '1',
    countryCode: 'US',
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: 'USA',
    example: 'USA',
    displayName: 'United States',
    displayNameNoCountryCode: 'US',
    e164Key: '',
  );

  sendCodeToUser() {
    if (_phone.text.isEmpty) {
      return showAlretDialog(
          context: context, msg: 'Please enter your phone number');
    } else if (_phone.text.length < 8) {
      return showAlretDialog(
          context: context, msg: 'Please enter a valid phone number');
    } else {
      ref.read(authProvider).sendSms(
            context: context,
            phone: '+${_country.phoneCode}${_phone.text}',
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Image.asset(AppConst.todo),
              ),
              SizedBox(height: 20.h),
              Align(
                alignment: Alignment.center,
                child: ReusableText(
                  text: "please enter your phone number",
                  style: reusableStyle(17, AppConst.light, FontWeight.w500),
                ),
              ),
              SizedBox(height: 20.h),
              CustomTextFiled(
                keyboardType: TextInputType.phone,
                prefixIcon: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  child: GestureDetector(
                    onTap: () {
                      showCountryPicker(
                        context: context,
                        countryListTheme: CountryListThemeData(
                          backgroundColor: AppConst.light,
                          textStyle:
                              reusableStyle(15, AppConst.dark, FontWeight.w600),
                          searchTextStyle:
                              reusableStyle(15, AppConst.dark, FontWeight.w600),
                          bottomSheetHeight: AppConst.appHeight * 0.6,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(AppConst.radius),
                            topRight: Radius.circular(AppConst.radius),
                          ),
                        ),
                        onSelect: (value) {
                          setState(() {
                            _country = value;
                          });
                        },
                      );
                    },
                    child: ReusableText(
                      text: "${_country.flagEmoji} + ${_country.phoneCode}",
                      style: reusableStyle(
                        18,
                        AppConst.dark,
                        FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                hintText: "Please enter  phone number",
                hintStyle: reusableStyle(15, AppConst.dark, FontWeight.w500),
                controller: _phone,
              ),
              SizedBox(height: 20.h),
              CustomOutlinedBtn(
                onTap: () {
                  sendCodeToUser();
                },
                height: AppConst.appHeight * 0.07,
                width: AppConst.appWidth * 0.9,
                color: AppConst.dark,
                bgColor: AppConst.light,
                text: "Send Code",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
