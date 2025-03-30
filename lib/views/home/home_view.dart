import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:task_management/data/data_testing.dart';
import 'package:task_management/extensions/space_exs.dart';
import 'package:task_management/models/task_model.dart';
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
  final List<int> testing = [1];
  var scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  _onDaySelected(selectedDay, focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
    });
  }

  _onPageChanged(focusedDay) {
    _focusedDay = focusedDay;
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.white,
          floatingActionButton: FloatBtn(),
          appBar: AppBar(
            title: Text(
              AppString.mainTitle.toUpperCase(),
              style: textTheme.titleLarge,
            ),
            centerTitle: true,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: AppColors.primaryGradientColor,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            toolbarHeight: 70,
            leading: GestureDetector(
              onTap: () => scaffoldKey.currentState?.openDrawer(),
              child: Icon(Icons.menu, color: Colors.black, size: 30),
            ),
            // actions: [
            //   GestureDetector(
            //     onTap: () {},
            //     child: Icon(Icons.sort, color: Colors.black, size: 30),
            //   ),
            // ],
            // actionsPadding: EdgeInsets.only(right: 15),
            // bottom: TabBar(
            //   indicatorColor: Colors.white,
            //   unselectedLabelColor: Colors.white.withValues(alpha: 0.5),
            //   labelColor: Colors.white,
            //   labelPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            //   indicatorSize: TabBarIndicatorSize.label,
            //   tabs: [
            //     Text(
            //       "Hôm nay",
            //       style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            //     ),
            //     Text(
            //       "Tháng này",
            //       style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            //     ),
            //   ],
            // ),
          ),
          drawer: CustomDrawer(),
          body: Column(
            children: [
              TableCalendar(
                locale: Localizations.localeOf(context).languageCode,
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                currentDay: DateTime.now(),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                startingDayOfWeek: StartingDayOfWeek.monday,
                calendarFormat: CalendarFormat.week,
                onDaySelected: _onDaySelected,
                onPageChanged: _onPageChanged,
                daysOfWeekStyle: const DaysOfWeekStyle(
                  weekdayStyle: TextStyle(color: Colors.green),
                  weekendStyle: TextStyle(color: Colors.red),
                ),
                calendarStyle: CalendarStyle(
                  selectedDecoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: AppColors.primaryGradientColor,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                  ),
                  todayDecoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.blue),
                    shape: BoxShape.circle,
                  ),
                  todayTextStyle: TextStyle(color: Colors.black),
                ),
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextFormatter:
                      (date, locale) => DateFormat.yMMMMd(locale).format(date),
                ),
              ),
              10.h,
              Expanded(
                child:
                    sampleTasks.isNotEmpty
                        ? ListView.builder(
                          itemCount: sampleTasks.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, taskIndex) {
                            TaskModel task = sampleTasks[taskIndex];
                            return Dismissible(
                              direction: DismissDirection.horizontal,
                              onDismissed: (_) {
                                // remove current task
                              },
                              background: Padding(
                                padding: const EdgeInsets.only(left: 35),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.delete_outline,
                                      color: Colors.grey,
                                    ),
                                    8.w,
                                    Text(
                                      AppString.deleteTask,
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                              key: Key(taskIndex.toString()),
                              child: TaskWidget(task: task),
                            );
                          },
                        )
                        : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
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
                            FadeInUp(
                              from: 30,
                              child: Text(AppString.doneAllTask),
                            ),
                          ],
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHomeBody(TextTheme textTheme) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          // Padding(
          //   padding: const EdgeInsets.only(top: 20),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       SizedBox(
          //         width: 25,
          //         height: 25,
          //         child: CircularProgressIndicator(
          //           value: 1 / 3,
          //           backgroundColor: Colors.grey,
          //           valueColor: AlwaysStoppedAnimation(AppColors.primaryColor),
          //         ),
          //       ),
          //       25.w,
          //       Text(
          //         "Bạn đã hoàn thành 1 trong 3 công việc",
          //         style: textTheme.displayMedium,
          //       ),
          //     ],
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(top: 10),
          //   child: Divider(thickness: 2, indent: 100),
          // ),
          // Expanded(
          //   child:
          //       testing.isNotEmpty
          //           // task is not empty
          //           ? ListView.builder(
          //             itemCount: 10,
          //             scrollDirection: Axis.vertical,
          //             itemBuilder: (context, taskIndex) {
          //               return Dismissible(
          //                 direction: DismissDirection.horizontal,
          //                 onDismissed: (_) {
          //                   // remove current task
          //                 },
          //                 background: Padding(
          //                   padding: const EdgeInsets.only(left: 35),
          //                   child: Row(
          //                     children: [
          //                       Icon(Icons.delete_outline, color: Colors.grey),
          //                       8.w,
          //                       Text(
          //                         AppString.deleteTask,
          //                         style: TextStyle(color: Colors.grey),
          //                       ),
          //                     ],
          //                   ),
          //                 ),
          //                 key: Key(taskIndex.toString()),
          //                 child: TaskWidget(
          //                   isFinished: false,
          //                   title: "Take your medicines",
          //                   time: "9:00 AM",
          //                 ),
          //               );
          //             },
          //           )
          //           // task is empty
          //           : Column(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               // lottie animate
          //               FadeInUp(
          //                 child: SizedBox(
          //                   width: 200,
          //                   height: 200,
          //                   child: Lottie.asset(
          //                     lottieURL,
          //                     animate: testing.isNotEmpty ? false : true,
          //                   ),
          //                 ),
          //               ),
          //               // sub text
          //               FadeInUp(from: 30, child: Text(AppString.doneAllTask)),
          //             ],
          //           ),
          // ),
        ],
      ),
    );
  }
}
