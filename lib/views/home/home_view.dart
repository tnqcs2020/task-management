import 'package:flutter/material.dart';
import 'package:task_management/views/home/components/custom_app_bar.dart';
import 'package:task_management/views/home/components/float_btn.dart';
import 'package:task_management/views/home/components/custom_drawer.dart';
import 'package:task_management/views/home/sub_views/current_task.dart';
import 'package:task_management/views/home/sub_views/done_task.dart';
import 'package:task_management/views/home/sub_views/overdue_task.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        initialIndex: 0,
        length: 3,
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.white,
          floatingActionButton: FloatBtn(),
          appBar: CustomAppBar(scaffoldKey: scaffoldKey),
          drawer: CustomDrawer(),
          body: TabBarView(
            children: [CurrentTask(), DoneTask(), OverdueTask()],
          ),
        ),
      ),
    );
  }
}
