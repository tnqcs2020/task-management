import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:intl/intl.dart';
import 'package:task_management/extensions/space_exs.dart';
import 'package:task_management/models/task_model.dart';
import 'package:task_management/utils/app_colors.dart';
import 'package:task_management/utils/custom_btn.dart';
import 'package:task_management/views/home/components/custom_app_bar.dart';

class TaskView extends StatefulWidget {
  const TaskView({super.key, this.task, required this.isModified});
  final TaskModel? task;
  final bool isModified;
  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleCtrl = TextEditingController();
  final TextEditingController _descriptionCtrl = TextEditingController();
  final List<TextEditingController> _titleWorkCtrls = [];
  final List<bool> _isCheckedList = [];
  DateTime? deadline;

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _titleCtrl.text = widget.task!.title!;
      _descriptionCtrl.text = widget.task!.description!;
      deadline = DateTime.parse(widget.task!.deadline!);
      widget.task!.listWork!.forEach((element) {
        _titleWorkCtrls.add(TextEditingController(text: element.title!));
        _isCheckedList.add(intToBool(element.isFinished!));
      });
    }
  }

  int boolToInt(bool check) {
    return check ? 1 : 0;
  }

  bool intToBool(int check) {
    return check == 1 ? true : false;
  }

  String showDate(DateTime? deadline) {
    if (deadline == null) {
      return "Chọn ngày cần hoàn thành!";
    } else {
      return DateFormat("dd-MM-yyy").format(deadline).toString();
    }
  }

  DateTime showDateAsDateTime(DateTime? deadline) {
    if (deadline == null) {
      return DateTime.now();
    } else {
      return deadline;
    }
  }

  void addItem() {
    setState(() {
      _titleWorkCtrls.add(TextEditingController());
      _isCheckedList.add(false);
    });
  }

  void removeItem(int index) {
    setState(() {
      _titleWorkCtrls.removeAt(index);
      _isCheckedList.removeAt(index);
    });
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descriptionCtrl.dispose();
    _titleWorkCtrls.forEach((element) => element.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title:
            widget.task == null
                ? "Tạo công việc"
                : widget.isModified
                ? "Chỉnh sửa"
                : "Chi tiết",
        isModified: !widget.isModified,
        task: widget.isModified == false ? widget.task : null,
      ),
      body: Form(
        key: _formKey,
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(top: 15, bottom: 30),
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
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey.withValues(alpha: 0.5),
                            ),
                          ),
                          child: TextFormField(
                            controller: _titleCtrl,
                            enabled: widget.isModified,
                            decoration: InputDecoration(
                              hintText: "Nhập tên công việc...",
                              hintStyle: TextStyle(color: Colors.grey.shade700),
                              border: InputBorder.none,
                            ),
                            style: TextStyle(fontSize: 16, color: Colors.black),
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
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey.withValues(alpha: 0.5),
                            ),
                          ),
                          child: TextFormField(
                            controller: _descriptionCtrl,
                            minLines: 3,
                            maxLines: 5,
                            enabled: widget.isModified,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Nhập mô tả công việc",
                              hintStyle: TextStyle(color: Colors.grey.shade700),
                            ),
                            style: TextStyle(fontSize: 16, color: Colors.black),
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
                                    onTap: () {
                                      if (widget.isModified) {
                                        addItem();
                                      }
                                    },
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
                                      padding: const EdgeInsets.only(
                                        bottom: 10,
                                      ),
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            value: _isCheckedList[workIndex],
                                            onChanged: (value) {
                                              if (widget.isModified) {
                                                setState(() {
                                                  _isCheckedList[workIndex] =
                                                      value!;
                                                });
                                              }
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
                                                    color: Colors.grey
                                                        .withValues(
                                                          alpha: 0.05,
                                                        ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          10,
                                                        ),
                                                    border: Border.all(
                                                      color: Colors.grey
                                                          .withValues(
                                                            alpha: 0.5,
                                                          ),
                                                    ),
                                                  ),
                                                  child: TextFormField(
                                                    controller:
                                                        _titleWorkCtrls[workIndex],
                                                    maxLines: 1,
                                                    enabled: widget.isModified,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                    ),
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      hintText: "Nhập nội dung",
                                                      hintStyle: TextStyle(
                                                        color:
                                                            Colors
                                                                .grey
                                                                .shade700,
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
                                                  onTap: () {
                                                    if (widget.isModified) {
                                                      removeItem(workIndex);
                                                    }
                                                  },
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
                                                onTap: () {
                                                  if (widget.isModified) {
                                                    addItem();
                                                  }
                                                },
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
                            if (widget.isModified) {
                              DatePicker.showDatePicker(
                                context,
                                showTitleActions: true,
                                minTime: DateTime.now(),
                                maxTime: DateTime(2030, 3, 5),
                                onConfirm: (selectedDate) {
                                  setState(() {
                                    deadline = selectedDate;
                                  });
                                  FocusManager.instance.primaryFocus?.unfocus();
                                },
                                currentTime: showDateAsDateTime(deadline),
                                locale: LocaleType.vi,
                              );
                            }
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
                                SizedBox(
                                  width: 130,
                                  child: Center(
                                    child: Text(
                                      "Ngày",
                                      style: TextStyle(fontSize: 20),
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
                                        style: TextStyle(
                                          fontSize: deadline == null ? 16 : 20,
                                          color: Colors.red,
                                        ),
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
              Container(height: 1, color: Colors.grey[200]),
              if (widget.isModified)
                Container(
                  color: Colors.blue.withValues(alpha: 0.05),
                  height: 100,
                  child: Row(
                    mainAxisAlignment:
                        widget.task == null || widget.task!.isFinished! == 2
                            ? MainAxisAlignment.center
                            : MainAxisAlignment.spaceEvenly,
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
                              widget.task == null ? "Thêm mới" : "Lưu",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      widget.task != null && widget.task!.isFinished! == 0
                          ? CustomBtn(onTap: () {}, title: "Hoàn thành")
                          : widget.task != null && widget.task!.isFinished! == 1
                          ? CustomBtn(onTap: () {}, title: "Bỏ hoàn thành")
                          : SizedBox(),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
