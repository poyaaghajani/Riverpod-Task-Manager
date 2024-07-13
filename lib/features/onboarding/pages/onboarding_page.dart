import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:task_manager/core/constants/constants.dart';
import 'package:task_manager/features/onboarding/widgets/onboarding_one.dart';
import 'package:task_manager/features/onboarding/widgets/onboarding_two.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final PageController _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            children: const [
              OnBoardingOne(),
              OnBoardingTwo(),
            ],
          ),
          Positioned(
            bottom: 30.h,
            right: 20.w,
            child: GestureDetector(
              onTap: () {},
              child: SmoothPageIndicator(
                controller: _controller,
                count: 2,
                effect: const WormEffect(
                  dotHeight: 12,
                  dotWidth: 16,
                  spacing: 6,
                  activeDotColor: AppConst.yellow,
                  dotColor: AppConst.light,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
