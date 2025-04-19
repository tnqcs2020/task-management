import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:intl/intl.dart';
import 'package:task_management/extensions/space_exs.dart';
import 'package:task_management/models/task_model.dart';
import 'package:task_management/utils/app_colors.dart';
import 'package:task_management/utils/app_string.dart';

class TaskView extends StatefulWidget {
  const TaskView({super.key, this.task});
  final TaskModel? task;
  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleCtrl = TextEditingController();
  final TextEditingController _descriptionCtrl = TextEditingController();
  final List<TextEditingController> _titleWorkCtrls = [];
  final List<TextEditingController> _descriptionWorkCtrls = [];
  final List<bool> _isCheckedList = [];

  // DateTime? date;
  DateTime? deadline;

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _titleCtrl.text = widget.task!.title!;
      _descriptionCtrl.text = widget.task!.description!;
      deadline = DateTime.parse(widget.task!.deadline!);
      // date = DateTime.parse(widget.task!.createdAt!);
    }
  }

  /// Show Selected Time As String Format
  // String showTime(DateTime? time) {
  //   if (widget.task?.createdAt == null) {
  //     if (time == null) {
  //       return DateFormat('hh:mm a').format(DateTime.now()).toString();
  //     } else {
  //       return DateFormat('hh:mm a').format(time).toString();
  //     }
  //   } else {
  //     return widget.task!.createdAt!;
  //   }
  // }

  /// Show Selected Time As DateTime Format
  // DateTime showTimeAsDateTime(DateTime? time) {
  //   if (widget.task?.createdAt == null) {
  //     if (time == null) {
  //       return DateTime.now();
  //     } else {
  //       return time;
  //     }
  //   } else {
  //     return DateTime.parse(widget.task!.createdAt!);
  //   }
  // }

  /// Show Selected Date As String Format
  String showDate(DateTime? deadline) {
    if (widget.task?.deadline == null) {
      if (deadline == null) {
        return DateFormat.yMMMEd().format(DateTime.now()).toString();
      } else {
        return DateFormat.yMMMEd().format(deadline).toString();
      }
    } else {
      return widget.task!.deadline!;
    }
  }

  // Show Selected Date As DateTime Format
  DateTime showDateAsDateTime(DateTime? deadline) {
    if (widget.task?.deadline == null) {
      if (deadline == null) {
        return DateTime.now();
      } else {
        return deadline;
      }
    } else {
      return DateTime.parse(widget.task!.deadline!);
    }
  }

  void addItem() {
    setState(() {
      _titleWorkCtrls.add(TextEditingController());
      _descriptionWorkCtrls.add(TextEditingController());
      _isCheckedList.add(false);
    });
  }

  void removeItem(int index) {
    setState(() {
      _titleWorkCtrls.removeAt(index);
      _descriptionWorkCtrls.removeAt(index);
      _isCheckedList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(CupertinoIcons.back),
        ),
        title: Text(
          widget.task == null ? "Tạo công việc" : "Chỉnh sửa",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tiêu đề",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    10.h,
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.grey.withValues(alpha: 0.5),
                        ),
                      ),
                      child: TextFormField(
                        controller: _titleCtrl,
                        decoration: InputDecoration(
                          hintText: "Nhập tên công việc...",
                          hintStyle: TextStyle(color: Colors.grey.shade700),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 10,
                          ),
                        ),
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    15.h,
                    Text(
                      "Mô tả",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    10.h,
                    Container(
                      padding: EdgeInsets.all(10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.grey.withValues(alpha: 0.5),
                        ),
                      ),
                      child: TextFormField(
                        controller: _descriptionCtrl,
                        maxLines: 2,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Nhập mô tả công việc",
                          hintStyle: TextStyle(color: Colors.grey.shade700),
                        ),
                        style: TextStyle(fontSize: 16),
                      ),
                    ),

                    15.h,
                    Text(
                      "Việc cần thực hiện",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    _titleWorkCtrls.isEmpty
                        ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () => addItem(),
                                child: Text(
                                  "+ Thêm công việc",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.green,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                        : ListView.builder(
                          shrinkWrap: true,
                          itemCount: _titleWorkCtrls.length,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.only(top: 10),
                          itemBuilder: (context, workIndex) {
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Row(
                                    children: [
                                      Checkbox(
                                        value: _isCheckedList[workIndex],
                                        onChanged: (value) {
                                          setState(() {
                                            _isCheckedList[workIndex] = value!;
                                          });
                                        },
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(10),
                                              height: 50,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: Colors.grey.withValues(
                                                  alpha: 0.2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                  color: Colors.grey.withValues(
                                                    alpha: 0.5,
                                                  ),
                                                ),
                                              ),
                                              child: TextFormField(
                                                controller:
                                                    _titleWorkCtrls[workIndex],
                                                maxLines: 1,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: "Nhập nội dung",
                                                  hintStyle: TextStyle(
                                                    color: Colors.grey.shade700,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                        ),
                                        child: Column(
                                          children: [
                                            GestureDetector(
                                              child: const Icon(
                                                Icons.remove_circle,
                                                color: Colors.red,
                                              ),
                                              onTap:
                                                  () => removeItem(workIndex),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                workIndex == _titleWorkCtrls.length - 1
                                    ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 10,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            onTap: () => addItem(),
                                            child: Text(
                                              "+ Thêm công việc",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.green,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                    : SizedBox(),
                              ],
                            );
                          },
                        ),
                    Text(
                      "Hạn hoàn thành",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    10.h,
                    GestureDetector(
                      onTap: () {
                        DatePicker.showDatePicker(
                          context,
                          showTitleActions: true,
                          minTime: DateTime.now(),
                          maxTime: DateTime(2030, 3, 5),
                          onChanged: (_) {},
                          onConfirm: (selectedDate) {
                            setState(() {
                              deadline = selectedDate;
                            });
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          currentTime: showDateAsDateTime(deadline),
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: SizedBox(
                                width: 100,
                                child: Text(
                                  "Ngày",
                                  style: TextStyle(fontSize: 23),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey.shade100,
                                ),
                                child: Center(
                                  child: Text(
                                    showDate(deadline),
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(builder: (context) => HomeView()),
                      //   );
                    }
                  },
                  child: Container(
                    width: 170,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      gradient: LinearGradient(
                        colors: AppColors.primaryGradientColor,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        widget.task == null ? "Thêm công việc" : "Cập nhật",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                widget.task != null
                    ? GestureDetector(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          //   Navigator.push(
                          //     context,
                          //     MaterialPageRoute(builder: (context) => HomeView()),
                          //   );
                        }
                      },
                      child: Container(
                        width: 170,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          gradient: LinearGradient(
                            colors: AppColors.primaryGradientColor,
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Đã hoàn thành",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                    : SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
