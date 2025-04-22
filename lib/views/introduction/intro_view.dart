import 'package:flutter/material.dart';
import 'package:task_management/extensions/space_exs.dart';
import 'package:task_management/views/home/components/custom_app_bar.dart';
import 'package:task_management/views/home/components/custom_drawer.dart';

class IntroductionView extends StatefulWidget {
  const IntroductionView({super.key});

  @override
  State<IntroductionView> createState() => _IntroductionViewState();
}

class _IntroductionViewState extends State<IntroductionView> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "Giới thiệu",
        isMenu: true,
        scaffoldKey: scaffoldKey,
      ),
      drawer: CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Nhóm 1",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
            10.h,
            Text.rich(
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 20),
              TextSpan(
                text: "Tên đồ án: ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                children: [
                  TextSpan(
                    text:
                        "Ứng dụng quản lý công việc (Taskment) sử dụng kiểu dữ liệu Key-Value",
                    style: TextStyle(fontSize: 25),
                  ),
                  TextSpan(
                    text:
                        " (Sử dụng Flutter để phát triển giao diện và Redis cho phần backend.)",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            20.h,
            Text(
              "Thành viên nhóm 1:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text("1. Trần Nhựt Quang", style: TextStyle(fontSize: 20)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text(
                "2. Nguyễn Quốc Kiệt",
                style: TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text(
                "3. Trương Hiếu Nghĩa",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
