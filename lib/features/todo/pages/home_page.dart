import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_manager/core/constants/constants.dart';
import 'package:task_manager/core/widgets/custom_text_filed.dart';
import 'package:task_manager/core/widgets/gap.dart';
import 'package:task_manager/core/widgets/reusable_style.dart';
import 'package:task_manager/core/widgets/reusable_text.dart';
import 'package:task_manager/core/widgets/xpansion_tile.dart';
import 'package:task_manager/features/todo/widgets/todo_tile.dart';

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConst.dark,
        automaticallyImplyLeading: false,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(85),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusableText(
                      text: 'Dashboard',
                      style: reusableStyle(18, AppConst.light, FontWeight.bold),
                    ),
                    Container(
                      width: 25.w,
                      height: 25.h,
                      decoration: BoxDecoration(
                        color: AppConst.light,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: GestureDetector(
                        onTap: () {},
                        child: const Icon(
                          Icons.add,
                          color: AppConst.dark,
                        ),
                      ),
                    ),
                  ],
                ),
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
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: ListView(
            children: [
              const Gap(height: 20),
              Row(
                children: [
                  const Icon(
                    FontAwesome.tasks,
                    size: 20,
                    color: AppConst.light,
                  ),
                  const Gap(width: 10),
                  ReusableText(
                    text: 'Todays Tasks',
                    style: reusableStyle(18, AppConst.light, FontWeight.bold),
                  ),
                ],
              ),
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
                  tabs: [
                    Tab(
                      child: SizedBox(
                        width: AppConst.appWidth * 0.5,
                        child: Center(
                          child: ReusableText(
                            text: 'Pending',
                            style: reusableStyle(
                              16,
                              AppConst.dark,
                              FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: SizedBox(
                        width: AppConst.appWidth * 0.5,
                        child: Center(
                          child: ReusableText(
                            text: 'Completed',
                            style: reusableStyle(
                              16,
                              AppConst.dark,
                              FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
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
                        child: ListView(
                          children: [
                            TodoTile(
                              start: '03:00',
                              end: '04:00',
                              switcher: CupertinoSwitch(
                                value: true,
                                onChanged: (value) {},
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: AppConst.appHeight * 0.3,
                        color: AppConst.lightBk,
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(height: 20),
              XpansionTile(
                text: "Tomorrow's Tasks",
                text2: "Tomorrow's tasks are shown here",
                children: [],
              ),
              const Gap(height: 20),
              XpansionTile(
                text: DateTime.now()
                    .add(const Duration(days: 2))
                    .toString()
                    .substring(5, 10),
                text2: "Day after tomorrow tasks",
                children: [],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
