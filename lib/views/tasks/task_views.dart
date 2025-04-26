// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_management/extensions/space_exs.dart';
import 'package:task_management/models/task_model.dart';
import 'package:task_management/utils/app_colors.dart';
import 'package:task_management/utils/auth_services.dart';
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
  int _isFinished = 0;
  DateTime? deadline;
  String? _doneAt;

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
      _isFinished = widget.task!.isFinished!;
      _doneAt = widget.task!.doneAt;
    }
    AuthServices.userCtrl.isModified.value = widget.isModified;
  }

  int boolToInt(bool check) {
    return check ? 1 : 0;
  }

  bool intToBool(int check) {
    return check == 1 ? true : false;
  }

  String showDate(DateTime? deadline) {
    if (deadline == null) {
      return "Hãy chọn ngày!";
    } else {
      return DateFormat("dd-MM-yyyy").format(deadline).toString();
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

  addAndUpdate(bool isUpdate) async {
    List<WorkModel> _listWork = [];
    if (_titleWorkCtrls.isNotEmpty &&
        _titleWorkCtrls.length == _isCheckedList.length) {
      for (int i = 0; i < _titleWorkCtrls.length; i++) {
        if (_titleWorkCtrls[i].text.trim().isNotEmpty) {
          _listWork.add(
            WorkModel(
              title: _titleWorkCtrls[i].text,
              isFinished: _isCheckedList[i] ? 1 : 0,
            ),
          );
        }
      }
    }
    TaskModel newTask = TaskModel(
      createdBy: AuthServices.userCtrl.username.value,
      createdAt: AuthServices.todayFormat,
      deadline: DateFormat("yyyy-MM-dd").format(deadline!).toString(),
      title: _titleCtrl.text,
      description: _descriptionCtrl.text,
      listWork: _listWork,
      isFinished: _isFinished,
      doneAt: isUpdate ? _doneAt! : "",
      taskID: isUpdate ? widget.task!.taskID! : "",
    );
    if (isUpdate) {
      await AuthServices.updateTask(newTask);
    } else {
      await AuthServices.addTask(newTask);
    }
  }

  reDeadlineAndUpdate() async {
    List<WorkModel> _listWork = [];
    if (_titleWorkCtrls.isNotEmpty &&
        _titleWorkCtrls.length == _isCheckedList.length) {
      for (int i = 0; i < _titleWorkCtrls.length; i++) {
        if (_titleWorkCtrls[i].text.trim().isNotEmpty) {
          _listWork.add(
            WorkModel(
              title: _titleWorkCtrls[i].text,
              isFinished: _isCheckedList[i] ? 1 : 0,
            ),
          );
        }
      }
    }
    TaskModel newTask = TaskModel(
      createdBy: AuthServices.userCtrl.username.value,
      createdAt: AuthServices.todayFormat,
      deadline: DateFormat("yyyy-MM-dd").format(deadline!).toString(),
      title: _titleCtrl.text,
      description: _descriptionCtrl.text,
      listWork: _listWork,
      isFinished:
          AuthServices.calculateOverdueDays(
                    DateFormat("yyyy-MM-dd").format(deadline!).toString(),
                  ) >
                  0
              ? 2
              : 0,
      doneAt: _doneAt ?? "",
      taskID: widget.task!.taskID!,
    );
    await AuthServices.updateTask(newTask);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: CustomAppBar(
          title:
              widget.task == null
                  ? "Tạo công việc"
                  : AuthServices.userCtrl.isModified.value
                  ? "Chỉnh sửa"
                  : "Chi tiết",
          isAction: widget.task == null ? false : true,
          task:
              AuthServices.userCtrl.isModified.value == false
                  ? widget.task
                  : null,
        ),
        body: GestureDetector(
          onTap:
              () =>
                  FocusScope.of(
                    context,
                  ).unfocus(),
          child: Form(
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
                                minLines: 1,
                                maxLines: 3,
                                enabled: AuthServices.userCtrl.isModified.value,
                                decoration: InputDecoration(
                                  hintText: "Nhập tên công việc...",
                                  hintStyle: TextStyle(
                                    color: Colors.grey.shade700,
                                  ),
                                  border: InputBorder.none,
                                ),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                                textInputAction: TextInputAction.next,
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
                                enabled: AuthServices.userCtrl.isModified.value,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Nhập mô tả công việc",
                                  hintStyle: TextStyle(
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                                textInputAction: TextInputAction.next,
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
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          if (AuthServices
                                              .userCtrl
                                              .isModified
                                              .value) {
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
                                                value:
                                                    _isCheckedList[workIndex],
                                                onChanged: (value) {
                                                  if (AuthServices
                                                      .userCtrl
                                                      .isModified
                                                      .value) {
                                                    setState(() {
                                                      _isCheckedList[workIndex] =
                                                          value!;
                                                    });
                                                  }
                                                },
                                              ),
                                              Expanded(
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                  ),
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
                                                    minLines: 1,
                                                    maxLines: 2,
                                                    enabled:
                                                        AuthServices
                                                            .userCtrl
                                                            .isModified
                                                            .value,
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
                                                    textInputAction:
                                                        workIndex ==
                                                                _titleWorkCtrls
                                                                        .length -
                                                                    1
                                                            ? TextInputAction
                                                                .done
                                                            : TextInputAction
                                                                .next,
                                                  ),
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
                                                        if (AuthServices
                                                            .userCtrl
                                                            .isModified
                                                            .value) {
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    vertical: 10,
                                                  ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      if (AuthServices
                                                          .userCtrl
                                                          .isModified
                                                          .value) {
                                                        addItem();
                                                      }
                                                    },
                                                    child: Text(
                                                      "+ Thêm công việc",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.green,
                                                        fontWeight:
                                                            FontWeight.w500,
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
                                if (AuthServices.userCtrl.isModified.value) {
                                  DatePicker.showDatePicker(
                                    context,
                                    showTitleActions: true,
                                    minTime: DateTime.now(),
                                    maxTime: DateTime(2030, 3, 5),
                                    onConfirm: (selectedDate) {
                                      setState(() {
                                        deadline = selectedDate;
                                      });
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
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
                                child:
                                    AuthServices.userCtrl.isModified.value
                                        ? Row(
                                          children: [
                                            SizedBox(
                                              width: 130,
                                              child: Center(
                                                child: Text(
                                                  "Ngày ",
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.grey.shade100,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    showDate(deadline),
                                                    style: TextStyle(
                                                      fontSize:
                                                          deadline == null
                                                              ? 16
                                                              : 20,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                        : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  showDate(deadline!),
                                                  style: TextStyle(
                                                    fontSize:
                                                        deadline == null
                                                            ? 16
                                                            : 20,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                              ),
                            ),
                            if (_isFinished == 1)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  15.h,
                                  Text(
                                    "Ngày hoàn thành",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  10.h,
                                  Container(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              showDate(
                                                DateTime.parse(_doneAt!),
                                              ),
                                              style: TextStyle(
                                                fontSize:
                                                    deadline == null ? 16 : 20,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(height: 1, color: Colors.grey[200]),
                  if (AuthServices.userCtrl.isModified.value)
                    Container(
                      color: Colors.blue.withValues(alpha: 0.05),
                      height: 90,
                      child: Row(
                        mainAxisAlignment:
                            widget.task == null || _isFinished == 2
                                ? MainAxisAlignment.center
                                : MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              if (_formKey.currentState!.validate() &&
                                  deadline != null) {
                                EasyLoading.show(
                                  status:
                                      widget.task != null
                                          ? 'Đang cập nhật...'
                                          : 'Đang thêm...',
                                );
                                try {
                                  AuthServices.userCtrl.isModified.value =
                                      false;
                                  if (_isFinished == 2) {
                                    await reDeadlineAndUpdate();
                                  } else {
                                    await addAndUpdate(widget.task != null);
                                  }
                                  EasyLoading.dismiss();
                                  EasyLoading.showSuccess(
                                    widget.task != null
                                        ? "Cập nhật thành công!"
                                        : 'Thêm thành công!',
                                  );
                                  Navigator.of(context).pop();
                                } catch (e) {
                                  EasyLoading.dismiss();
                                  EasyLoading.showError('Có lỗi xảy ra!');
                                }
                              } else if (deadline == null) {
                                EasyLoading.showError(
                                  'Bạn cần phải chọn hạn hoàn thành!',
                                );
                              }
                            },
                            child: Container(
                              width: 160,
                              height: 45,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(25),
                                ),
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
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          widget.task != null && _isFinished == 0
                              ? CustomBtn(
                                onTap: () {
                                  showCupertinoDialog<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return CupertinoAlertDialog(
                                        title: Text('Xác nhận hoàn thành'),
                                        content: Text(
                                          'Bạn muốn chuyển công việc sang trạng thái hoàn thành?',
                                        ),
                                        actions: <Widget>[
                                          CupertinoDialogAction(
                                            isDefaultAction: true,
                                            child: Text('Hủy'),
                                            onPressed: () {
                                              Navigator.of(
                                                context,
                                              ).pop(); // Đóng dialog
                                            },
                                          ),
                                          CupertinoDialogAction(
                                            isDestructiveAction: true,
                                            child: Text('Chuyển'),
                                            onPressed: () async {
                                              Navigator.of(context).pop();
                                              EasyLoading.show(
                                                status: 'Đang cập nhật...',
                                              );
                                              try {
                                                await AuthServices.markDone(
                                                  true,
                                                  widget.task!,
                                                );
                                                setState(() {
                                                  _isFinished = 1;
                                                  _doneAt =
                                                      DateFormat("yyyy-MM-dd")
                                                          .format(
                                                            DateTime.now(),
                                                          )
                                                          .toString();
                                                });

                                                EasyLoading.showSuccess(
                                                  "Đã đánh dấu hoàn thành!",
                                                );
                                              } catch (e) {
                                                EasyLoading.dismiss();
                                                EasyLoading.showError(
                                                  'Có lỗi xảy ra!',
                                                );
                                              }
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                title: "Hoàn thành",
                              )
                              : widget.task != null && _isFinished == 1
                              ? CustomBtn(
                                onTap: () {
                                  showCupertinoDialog<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return CupertinoAlertDialog(
                                        title: Text('Xác nhận đang làm'),
                                        content: Text(
                                          'Bạn muốn chuyển công việc sang trạng thái đang làm?',
                                        ),
                                        actions: <Widget>[
                                          CupertinoDialogAction(
                                            isDefaultAction: true,
                                            child: Text('Hủy'),
                                            onPressed: () {
                                              Navigator.of(
                                                context,
                                              ).pop(); // Đóng dialog
                                            },
                                          ),
                                          CupertinoDialogAction(
                                            isDestructiveAction: true,
                                            child: Text('Chuyển'),
                                            onPressed: () async {
                                              Navigator.of(context).pop();
                                              EasyLoading.show(
                                                status: 'Đang cập nhật...',
                                              );
                                              try {
                                                await AuthServices.markDone(
                                                  false,
                                                  widget.task!,
                                                );
                                                setState(() {
                                                  _isFinished = 0;
                                                  _doneAt = "";
                                                });
                                                EasyLoading.dismiss();
                                                EasyLoading.showSuccess(
                                                  "Đã bỏ hoàn thành!",
                                                );
                                              } catch (e) {
                                                EasyLoading.dismiss();
                                                EasyLoading.showError(
                                                  'Có lỗi xảy ra!',
                                                );
                                              }
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                title: "Bỏ hoàn thành",
                              )
                              : SizedBox(),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
