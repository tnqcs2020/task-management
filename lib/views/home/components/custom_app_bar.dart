import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_management/models/task_model.dart';
import 'package:task_management/utils/app_colors.dart';
import 'package:task_management/utils/auth_services.dart';
import 'package:task_management/views/search/search_view.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.scaffoldKey,
    this.title,
    this.isMenu = false,
    this.isAction = false,
    this.task,
  });
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final String? title;
  final bool isMenu;
  final bool isAction;
  final TaskModel? task;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title != null ? title! : "Taskment",
        style: TextStyle(
          fontSize: title != null ? 25 : 30,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
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
      leading: IconButton(
        onPressed:
            () =>
                scaffoldKey != null || isMenu
                    ? scaffoldKey!.currentState?.openDrawer()
                    : Navigator.pop(context, true),
        icon: Icon(
          scaffoldKey != null || isMenu ? Icons.menu : CupertinoIcons.back,
          color: Colors.white,
          size: 30,
        ),
      ),
      actions:
          isAction
              ? AuthServices.userCtrl.isModified.value == false && task != null
                  ? [
                    IconButton(
                      onPressed: () {
                        AuthServices.userCtrl.isModified.value = true;
                      },
                      icon: Icon(
                        Icons.edit_note,
                        color: Colors.white,
                        size: 35,
                      ),
                    ),
                  ]
                  : [
                    IconButton(
                      onPressed: () {
                        AuthServices.userCtrl.isModified.value = false;
                      },
                      icon: Icon(Icons.close, color: Colors.white, size: 35),
                    ),
                  ]
              : [
                IconButton(
                  icon: Icon(Icons.search, size: 30, color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SearchView()),
                    );
                  },
                ),
              ],
      bottom:
          scaffoldKey != null && title == null
              ? TabBar(
                indicatorColor: Colors.amber,
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: Colors.white,
                labelStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                unselectedLabelStyle: TextStyle(fontSize: 16),
                unselectedLabelColor: Colors.grey[400],
                tabs: [
                  Tab(text: "Đang làm"),
                  Tab(text: "Hoàn thành"),
                  Tab(text: "Trễ hạn"),
                ],
              )
              : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(title != null ? 60 : 110);
}
