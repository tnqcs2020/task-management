import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:task_management/views/home/components/custom_app_bar.dart';
import 'package:task_management/data/data_testing.dart';
import 'package:task_management/extensions/space_exs.dart';
import 'package:task_management/models/task_model.dart';
import 'package:task_management/utils/app_colors.dart';
import 'package:task_management/utils/app_string.dart';
import 'package:task_management/utils/constants.dart';
import 'package:task_management/views/home/components/float_btn.dart';
import 'package:task_management/views/home/components/custom_drawer.dart';
import 'package:task_management/views/home/widgets/task_widget.dart';
import 'package:task_management/views/tasks/task_views.dart';

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

  bool isDateBetween(DateTime selectedDate, String startDate, String endDate) {
    DateTime start = DateTime.parse(startDate);
    DateTime end = DateTime.parse(endDate);
    return (selectedDate.isAfter(start) ||
            selectedDate.isAtSameMomentAs(start)) &&
        (selectedDate.isBefore(end) || selectedDate.isAtSameMomentAs(end));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        initialIndex: 0,
        length: 3,
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.white,
          floatingActionButton: FloatBtn(),
          appBar: CustomAppBar(scaffoldKey: scaffoldKey),
          drawer: CustomDrawer(),
          body: TabBarView(
            children: [
              Center(
                child: Column(
                  children: [
                    TableCalendar(
                      locale: Localizations.localeOf(context).languageCode,
                      firstDay: DateTime.utc(2010, 10, 16),
                      lastDay: DateTime.utc(2030, 3, 14),
                      currentDay: DateTime.now(),
                      focusedDay: _focusedDay,
                      selectedDayPredicate:
                          (day) => isSameDay(_selectedDay, day),
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
                            (date, locale) =>
                                DateFormat.yMMMMd(locale).format(date),
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
                                  if (!isDateBetween(
                                    _selectedDay,
                                    task.createdAt!,
                                    task.deadline!,
                                  )) {
                                    return SizedBox();
                                  }
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
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    key: Key(taskIndex.toString()),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (context) =>
                                                    TaskView(task: task),
                                          ),
                                        );
                                      },
                                      child: TaskWidget(task: task),
                                    ),
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
                                        animate:
                                            testing.isNotEmpty ? false : true,
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
              Center(child: Column()),
              Center(child: Column()),
            ],
          ),
        ),
      ),
    );
  }
}
