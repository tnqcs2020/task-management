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

class _SearchViewState extends State<SearchView> {
  final TextEditingController _searchController = TextEditingController();
  List<TaskModel> _filteredTasks = [];
  int _type = 4;
  List<TaskModel> temp = [];

  @override
  void initState() {
    super.initState();
    _filteredTasks = AuthServices.userCtrl.tasks;
  }

  _filterTasks(String query) {
    if (_type == 4) {
      setState(() {
        temp = AuthServices.userCtrl.tasks;
      });
    } else if (_type == 0) {
      setState(() {
        temp =
            AuthServices.userCtrl.tasks
                .where((task) => task.isFinished! == 0)
                .toList();
      });
    } else if (_type == 1) {
      setState(() {
        temp =
            AuthServices.userCtrl.tasks
                .where((task) => task.isFinished! == 1)
                .toList();
      });
    } else if (_type == 2) {
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

  void toggleType(int type) {
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
                        if (value == "4") {
                          toggleType(4);
                        } else if (value == "0") {
                          toggleType(0);
                        } else if (value == "1") {
                          toggleType(1);
                        } else {
                          toggleType(2);
                        }
                      },
                      itemBuilder:
                          (context) => [
                            PopupMenuItem(
                              value: "4",
                              child: Text(
                                'Tất cả',
                                style:
                                    _type == 4
                                        ? TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        )
                                        : null,
                              ),
                            ),
                            PopupMenuItem(
                              value: "0",
                              child: Text(
                                'Đang làm',
                                style:
                                    _type == 0
                                        ? TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        )
                                        : null,
                              ),
                            ),
                            PopupMenuItem(
                              value: "1",
                              child: Text(
                                'Hoàn thành',
                                style:
                                    _type == 1
                                        ? TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        )
                                        : null,
                              ),
                            ),
                            PopupMenuItem(
                              value: "2",
                              child: Text(
                                'Trễ hạn',
                                style:
                                    _type == 2
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
                      _type == 4
                          ? 'Tất cả'
                          : _type == 0
                          ? 'Đang làm'
                          : _type == 1
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
                        onTap: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      TaskView(task: task, isModified: false),
                            ),
                          );
                          if (result == true) {
                            setState(() {
                              _filterTasks(_searchController.text);
                            });
                          }
                        },
                        child: TaskWidget(task: task, isMore: false),
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
