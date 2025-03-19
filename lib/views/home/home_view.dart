import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:lottie/lottie.dart';
import 'package:task_management/extensions/space_exs.dart';
import 'package:task_management/utils/app_colors.dart';
import 'package:task_management/utils/app_string.dart';
import 'package:task_management/utils/constants.dart';
import 'package:task_management/views/home/components/float_btn.dart';
import 'package:task_management/views/home/components/custom_drawer.dart';
import 'package:task_management/views/home/widgets/task_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<int> testing = [];

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    GlobalKey<SliderDrawerState> sliderDrawerKey =
        GlobalKey<SliderDrawerState>();
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatBtn(),
      body: SliderDrawer(
        key: sliderDrawerKey,
        isDraggable: false,
        animationDuration: 700,
        appBar: SliderAppBar(
          config: SliderAppBarConfig(
            padding: EdgeInsets.only(top: 20, left: 15, right: 15),
            title: Text(""),
            drawerIconColor: Colors.black,
            drawerIconSize: 30,
            trailing: IconButton(
              onPressed: () {
                //remove task
              },
              icon: Icon(
                CupertinoIcons.trash_fill,
                size: 30,
                color: Colors.black,
              ),
            ),
          ),
        ),
        sliderOpenSize: 300,
        slider: CustomDrawer(),
        sliderBoxShadow: SliderBoxShadow(),
        child: _buildHomeBody(textTheme),
      ),
    );
  }

  Widget _buildHomeBody(TextTheme textTheme) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 60),
            width: double.infinity,
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 25,
                  height: 25,
                  child: CircularProgressIndicator(
                    value: 1 / 3,
                    backgroundColor: Colors.grey,
                    valueColor: AlwaysStoppedAnimation(AppColors.primaryColor),
                  ),
                ),
                25.w,
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppString.mainTitle, style: textTheme.displayLarge),
                    3.h,
                    Text("1 of 3 tasks", style: textTheme.titleMedium),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Divider(thickness: 2, indent: 100),
          ),
          Expanded(
            child:
                testing.isNotEmpty
                    // task is not empty
                    ? ListView.builder(
                      itemCount: testing.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, taskIndex) {
                        return Dismissible(
                          direction: DismissDirection.horizontal,
                          onDismissed: (_) {
                            // remove current task
                          },
                          background: Padding(
                            padding: const EdgeInsets.only(left: 35),
                            child: Row(
                              children: [
                                Icon(Icons.delete_outline, color: Colors.grey),
                                8.w,
                                Text(
                                  AppString.deleteTask,
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          key: Key(taskIndex.toString()),
                          child: TaskWidget(),
                        );
                      },
                    )
                    // task is empty
                    : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // lottie animate
                        FadeInUp(
                          child: SizedBox(
                            width: 200,
                            height: 200,
                            child: Lottie.asset(
                              lottieURL,
                              animate: testing.isNotEmpty ? false : true,
                            ),
                          ),
                        ),
                        // sub text
                        FadeInUp(from: 30, child: Text(AppString.doneAllTask)),
                      ],
                    ),
          ),
          100.h,
        ],
      ),
    );
  }
}
