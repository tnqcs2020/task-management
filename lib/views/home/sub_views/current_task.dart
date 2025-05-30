import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:lottie/lottie.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:task_management/extensions/space_exs.dart';
import 'package:task_management/models/task_model.dart';
import 'package:task_management/utils/app_colors.dart';
import 'package:task_management/utils/auth_services.dart';
import 'package:task_management/utils/constants.dart';
import 'package:task_management/views/home/widgets/task_widget.dart';
import 'package:task_management/views/tasks/task_views.dart';

class CurrentTask extends StatefulWidget {
  const CurrentTask({super.key});

  @override
  State<CurrentTask> createState() => _CurrentTaskState();
}

class _CurrentTaskState extends State<CurrentTask> {
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
    DateTime end = DateTime(temp.year, temp.month, temp.day, 23, 59, 59);
    return (selectedDate.isAfter(start) ||
            selectedDate.isAtSameMomentAs(start)) &&
        (selectedDate.isBefore(end) || selectedDate.isAtSameMomentAs(end));
  }

  bool isHaveTask(DateTime day, List<TaskModel> tasks) {
    bool isHave = false;
    if (tasks.isNotEmpty) {
      tasks.forEach((element) {
        if (isDateBetween(day, element.createdAt!, element.deadline!) &&
            element.isFinished == 0) {
          isHave = true;
        }
      });
    }
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
        10.h,
        Obx(
          () => Expanded(
            child:
                AuthServices.userCtrl.isLoading.value == false ||
                        AuthServices.userCtrl.tasks.isNotEmpty
                    ? isHaveTask(_selectedDay, AuthServices.userCtrl.tasks)
                        ? ListView.builder(
                          itemCount: AuthServices.userCtrl.tasks.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, taskIndex) {
                            TaskModel task =
                                AuthServices.userCtrl.tasks[taskIndex];
                            if (!isDateBetween(
                              _selectedDay,
                              task.createdAt!,
                              task.deadline!,
                            )) {
                              return SizedBox();
                            }
                            if (task.isFinished != 0) return SizedBox();
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => TaskView(
                                            task: task,
                                            isModified: false,
                                          ),
                                    ),
                                  );
                                },
                                child: TaskWidget(task: task),
                              ),
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
                                  child: Lottie.asset(lottieURL, animate: true),
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
                        )
                    : Padding(
                      padding: const EdgeInsets.only(bottom: 150),
                      child: Center(
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: LoadingIndicator(
                            indicatorType: Indicator.ballSpinFadeLoader,
                            colors: const [Colors.indigo],
                          ),
                        ),
                      ),
                    ),
          ),
        ),
      ],
    );
  }
}
