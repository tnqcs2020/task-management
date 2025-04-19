import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:task_management/extensions/space_exs.dart';
import 'package:task_management/utils/app_colors.dart';
import 'package:task_management/utils/shared_user_data.dart';
import 'package:task_management/utils/user_controller.dart';
import 'package:task_management/views/home/home_view.dart';
import 'package:task_management/views/login/login_view.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final userController = Get.find<UserController>();
  //Icon
  final List<IconData> icons = [
    CupertinoIcons.home,
    CupertinoIcons.person_fill,
    CupertinoIcons.settings,
    CupertinoIcons.info_circle_fill,
    CupertinoIcons.square_arrow_right,
  ];

  // Texts
  final List<String> texts = [
    "Trang chủ",
    "Thông tin cá nhân",
    "Cài đặt",
    "Giới thiệu",
    "Đăng xuất",
  ];
  final List<Function(BuildContext)> onTaps = [
    (context) {
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeView()),
      );
    },
    (context) {},
    (context) {},
    (context) {},
    (context) async {
      SharedUserData sharedUserData = SharedUserData();
      await sharedUserData.logout();
      EasyLoading.showSuccess('Đăng xuất thành công!');
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginView()),
        (route) => false,
      );
    },
  ];

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Drawer(
      backgroundColor: Colors.transparent,
      width: 330,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 90),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: AppColors.primaryGradientColor,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                "https://avatars.githubusercontent.com/u/91388754?v=4",
              ),
            ),
            20.h,
            Obx(
              () => Text(
                userController.name.value,
                style: textTheme.displayMedium,
              ),
            ),
            // Text('Flutter dev', style: textTheme.displaySmall),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: icons.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => onTaps[index](context),
                      child: Container(
                        margin: EdgeInsets.all(3),
                        child: ListTile(
                          leading: Icon(
                            icons[index],
                            color: Colors.white,
                            size: 30,
                          ),
                          title: Text(
                            texts[index],
                            style: textTheme.titleMedium!.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
