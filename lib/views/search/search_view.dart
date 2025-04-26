import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_management/models/task_model.dart';
import 'package:task_management/utils/app_colors.dart';
import 'package:task_management/utils/auth_services.dart';
import 'package:task_management/views/home/widgets/task_widget.dart';
import 'package:task_management/views/tasks/task_views.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

enum Type { all, inProgress, done, overdue }

class _SearchViewState extends State<SearchView> {
  final TextEditingController _searchController = TextEditingController();
  List<TaskModel> _filteredTasks = [];
  Type _type = Type.all;
  List<TaskModel> temp = [];

  @override
  void initState() {
    super.initState();
    _filteredTasks = AuthServices.userCtrl.tasks;
  }

  _filterTasks(String query) {
    if (_type == Type.all) {
      setState(() {
        temp = AuthServices.userCtrl.tasks;
      });
    } else if (_type == Type.inProgress) {
      setState(() {
        temp =
            AuthServices.userCtrl.tasks
                .where((task) => task.isFinished! == 0)
                .toList();
      });
    } else if (_type == Type.done) {
      setState(() {
        temp =
            AuthServices.userCtrl.tasks
                .where((task) => task.isFinished! == 1)
                .toList();
      });
    } else if (_type == Type.overdue) {
      setState(() {
        temp =
            AuthServices.userCtrl.tasks
                .where((task) => task.isFinished! == 2)
                .toList();
      });
    }
    setState(() {
      _filteredTasks =
          temp
              .where(
                (task) =>
                    task.title!.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
    });
  }

  void toggleType(Type type) {
    setState(() {
      _type = type;
      _filterTasks(_searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: TextField(
            controller: _searchController,
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Tìm kiếm công việc...',
              border: InputBorder.none,
              hintStyle: TextStyle(color: Colors.white70),
            ),
            style: TextStyle(color: Colors.white, fontSize: 18),
            onChanged: _filterTasks,
          ),
          toolbarHeight: 80,
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
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(CupertinoIcons.back, color: Colors.white, size: 30),
          ),
          actionsPadding: EdgeInsets.symmetric(horizontal: 5),
          actions: [
            SizedBox(
              width: 70,
              height: 55,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 0,
                    child: PopupMenuButton<String>(
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        Icons.filter_list,
                        color: Colors.white,
                        size: 25,
                      ),
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          12,
                        ), // Apply border radius
                      ),
                      menuPadding: EdgeInsets.zero,
                      elevation: 3,
                      onSelected: (value) {
                        if (value == Type.all.toString()) {
                          toggleType(Type.all);
                        } else if (value == Type.inProgress.toString()) {
                          toggleType(Type.inProgress);
                        } else if (value == Type.done.toString()) {
                          toggleType(Type.done);
                        } else {
                          toggleType(Type.overdue);
                        }
                      },
                      itemBuilder:
                          (context) => [
                            PopupMenuItem(
                              value: Type.all.toString(),
                              child: Text(
                                'Tất cả',
                                style:
                                    _type == Type.all
                                        ? TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        )
                                        : null,
                              ),
                            ),
                            PopupMenuItem(
                              value: Type.inProgress.toString(),
                              child: Text(
                                'Đang làm',
                                style:
                                    _type == Type.inProgress
                                        ? TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        )
                                        : null,
                              ),
                            ),
                            PopupMenuItem(
                              value: Type.done.toString(),
                              child: Text(
                                'Hoàn thành',
                                style:
                                    _type == Type.done
                                        ? TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        )
                                        : null,
                              ),
                            ),
                            PopupMenuItem(
                              value: Type.overdue.toString(),
                              child: Text(
                                'Trễ hạn',
                                style:
                                    _type == Type.overdue
                                        ? TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        )
                                        : null,
                              ),
                            ),
                          ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Text(
                      _type == Type.all
                          ? 'Tất cả'
                          : _type == Type.inProgress
                          ? 'Đang làm'
                          : _type == Type.done
                          ? 'Hoàn thành'
                          : 'Trễ hạn',
                      style: TextStyle(color: Colors.white, fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        body:
            _filteredTasks.isNotEmpty
                ? ListView.builder(
                  itemCount: _filteredTasks.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, taskIndex) {
                    TaskModel task = _filteredTasks[taskIndex];
                    return Padding(
                      padding: EdgeInsets.only(
                        top: taskIndex == 0 ? 10 : 0,
                        left: 10,
                        right: 10,
                      ),
                      child: GestureDetector(
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
                      ),
                    );
                  },
                )
                : Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 150,
                        height: 150,
                        child: SvgPicture.asset('assets/images/no-data.svg'),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Không tìm thấy dữ liệu!",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
      ),
    );
  }
}
