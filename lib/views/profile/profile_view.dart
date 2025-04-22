import 'package:flutter/material.dart';
import 'package:task_management/extensions/space_exs.dart';
import 'package:task_management/views/home/components/custom_app_bar.dart';
import 'package:task_management/views/home/components/custom_drawer.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "Thông tin",
        isMenu: true,
        scaffoldKey: scaffoldKey,
      ),
      drawer: CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Tài khoản",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                15.w,
                Container(
                  width: 200,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.withValues(alpha: 0.5),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text("", style: TextStyle(fontSize: 20)),
                ),
              ],
            ),
            20.h,
            Row(
              children: [
                Text(
                  "Họ và tên",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                15.w,
                Container(
                  width: 200,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.withValues(alpha: 0.5),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text("", style: TextStyle(fontSize: 20)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
