import 'package:flutter/material.dart';
import 'package:task_management/utils/app_colors.dart';
import 'package:task_management/utils/app_string.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.scaffoldKey});
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        AppString.mainTitle.toUpperCase(),
        style: TextStyle(
          fontSize: 35,
          color: Colors.black,
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
      leading: GestureDetector(
        onTap: () => scaffoldKey.currentState?.openDrawer(),
        child: Icon(Icons.menu, color: Colors.black, size: 30),
      ),
      bottom: TabBar(
        indicatorColor: Colors.amberAccent,
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: Colors.white,
        labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(fontSize: 16),
        unselectedLabelColor: Colors.grey[400],
        tabs: [
          Tab(text: 'Đang thực hiện'),
          Tab(text: 'Hoàn thành'),
          Tab(text: 'Trễ hạn'),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(80);
}
