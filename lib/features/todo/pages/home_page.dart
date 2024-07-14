import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_manager/core/constants/constants.dart';
import 'package:task_manager/core/widgets/custom_text_filed.dart';
import 'package:task_manager/core/widgets/gap.dart';
import 'package:task_manager/core/widgets/reusable_style.dart';
import 'package:task_manager/core/widgets/reusable_text.dart';
import 'package:task_manager/features/todo/controllers/todo_provider.dart';
import 'package:task_manager/features/todo/widgets/completed_tasks.dart';
import 'package:task_manager/features/todo/widgets/day_after_tomorrow_tasks.dart';
import 'package:task_manager/features/todo/widgets/pending_tasks.dart';
import 'package:task_manager/features/todo/widgets/todo_header.dart';
import 'package:task_manager/features/todo/widgets/todo_tab.dart';
import 'package:task_manager/features/todo/widgets/tomorrow_tasks.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 2, vsync: this);
  final TextEditingController _searchKey = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ref.watch(toDoStateProvider.notifier).refresh();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConst.dark,
        automaticallyImplyLeading: false,
        elevation: 0,
        bottom: _appBarBottom(context),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: ListView(
            children: [
              const Gap(height: 20),
              const ToDoHeader(),
              const Gap(height: 25),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppConst.radius),
                  color: AppConst.light,
                ),
                child: TabBar(
                  controller: _tabController,
                  indicatorSize: TabBarIndicatorSize.label,
                  labelPadding: EdgeInsets.zero,
                  isScrollable: false,
                  splashBorderRadius: BorderRadius.circular(AppConst.radius),
                  indicator: BoxDecoration(
                    color: AppConst.greyLight,
                    borderRadius: BorderRadius.circular(AppConst.radius),
                  ),
                  tabs: const [
                    ToDoTab(text: 'Pending'),
                    ToDoTab(text: 'Completed'),
                  ],
                ),
              ),
              const Gap(height: 20),
              SizedBox(
                height: AppConst.appHeight * 0.3,
                width: AppConst.appWidth,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppConst.radius),
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      Container(
                        height: AppConst.appHeight * 0.3,
                        color: AppConst.lightBk,
                        child: const PendingTasks(),
                      ),
                      Container(
                        height: AppConst.appHeight * 0.3,
                        color: AppConst.lightBk,
                        child: const CompletedTasks(),
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(height: 20),
              const TomorrowTasks(),
              const Gap(height: 20),
              const DayAfterTomorrowTasks(),
              const Gap(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSize _appBarBottom(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(85.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ReusableText(
            text: 'Dashboard',
            style: reusableStyle(18, AppConst.light, FontWeight.bold),
          ),
          const Gap(height: 20),
          CustomTextFiled(
            hintText: 'Search',
            hintStyle: reusableStyle(16, AppConst.dark, FontWeight.bold),
            controller: _searchKey,
            prefixIcon: Padding(
              padding: EdgeInsets.all(14.h),
              child: const Icon(
                AntDesign.search1,
                color: AppConst.greyLight,
              ),
            ),
            suffixIcon: const Icon(
              FontAwesome.sliders,
              color: AppConst.greyLight,
            ),
          ),
          const Gap(height: 20),
        ],
      ),
    );
  }
}
