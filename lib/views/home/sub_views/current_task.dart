import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:task_management/data/data_testing.dart';
import 'package:task_management/extensions/space_exs.dart';
import 'package:task_management/models/task_model.dart';
import 'package:task_management/utils/app_colors.dart';
import 'package:task_management/utils/constants.dart';
import 'package:task_management/views/home/widgets/task_widget.dart';
import 'package:task_management/views/tasks/task_views.dart';

class CurrentTask extends StatefulWidget {
  const CurrentTask({super.key});

  @override
  State<CurrentTask> createState() => _CurrentTaskState();
}

class _CurrentTaskState extends State<CurrentTask> {
  final List<int> testing = [];
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  _onDaySelected(selectedDay, focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
    });
  }

  bool isDateBetween(DateTime selectedDate, String startDate, String endDate) {
    DateTime start = DateTime.parse(startDate);
    DateTime temp = DateTime.parse(endDate);
    DateTime end = DateTime(temp.year, temp.month, temp.day, 23, 59);
    return (selectedDate.isAfter(start) ||
            selectedDate.isAtSameMomentAs(start)) &&
        (selectedDate.isBefore(end) || selectedDate.isAtSameMomentAs(end));
  }

  bool isHaveTask(DateTime day, List<TaskModel> tasks) {
    bool isHave = false;
    tasks.forEach((element) {
      if (isDateBetween(day, element.createdAt!, element.deadline!) &&
          element.isFinished == 0) {
        isHave = true;
      }
    });
    return isHave;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          locale: 'vi',
          firstDay: DateTime.now(),
          lastDay: DateTime.utc(2030, 1, 1),
          currentDay: DateTime.now(),
          focusedDay: _focusedDay,
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          startingDayOfWeek: StartingDayOfWeek.monday,
          calendarFormat: CalendarFormat.week,
          onDaySelected: _onDaySelected,
          // onPageChanged: _onPageChanged,
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
            formatButtonShowsNext: false,
            titleCentered: true,
            titleTextFormatter:
                (date, locale) => DateFormat.yMMMM(locale).format(date),
          ),
        ),
        10.h,
        Text(
          "Bạn đang chọn ngày ${DateFormat.yMMMMd("vi").format(_selectedDay)}",
        ),
        Expanded(
          child:
              isHaveTask(_selectedDay, sampleTasks)
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
                      if (task.isFinished != 0) return SizedBox();
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      TaskView(task: task, isModified: false),
                            ),
                          );
                        },
                        child: TaskWidget(task: task),
                      );
                    },
                  )
                  : Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Column(
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
                          child: Text(
                            "Tuyệt vời! Hôm nay không có công việc.",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
        ),
      ],
    );
  }
}
