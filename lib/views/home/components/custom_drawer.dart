import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/extensions/space_exs.dart';
import 'package:task_management/utils/app_colors.dart';
import 'package:task_management/utils/auth_services.dart';
import 'package:task_management/utils/shared_user_data.dart';
import 'package:task_management/utils/user_controller.dart';
import 'package:task_management/views/home/home_view.dart';
import 'package:task_management/views/introduction/intro_view.dart';
import 'package:task_management/views/login/login_view.dart';
// import 'package:task_management/views/profile/profile_view.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final userCtrl = Get.find<UserController>();
  //Icon
  final List<IconData> icons = [
    CupertinoIcons.home,
    // CupertinoIcons.person_fill,
    CupertinoIcons.info_circle_fill,
    CupertinoIcons.square_arrow_right,
  ];

  // Texts
  final List<String> texts = [
    "Trang chủ",
    // "Thông tin cá nhân",
    "Giới thiệu",
    "Đăng xuất",
  ];
  final List<Function(BuildContext)> onTaps = [
    (context) {
      Navigator.pop(context);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeView()),
        (route) => false,
      );
    },
    // (context) {
    //   Navigator.pop(context);
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => ProfileView()),
    //   );
    // },
    (context) {
      Navigator.pop(context);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => IntroductionView()),
        (route) => false,
      );
    },
    (context) {
      showCupertinoDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text('Đăng xuất'),
            content: Text('Bạn có chắc chắn muốn thoát?'),
            actions: <Widget>[
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text('Đóng'),
                onPressed: () {
                  Navigator.of(context).pop(); // Đóng dialog
                },
              ),
              CupertinoDialogAction(
                isDestructiveAction: true,
                child: Text('Đồng ý'),
                onPressed: () async {
                  SharedUserData sharedUserData = SharedUserData();
                  await sharedUserData.logout();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginView()),
                    (route) => false,
                  );
                  AuthServices.userCtrl.clearUser();
                },
              ),
            ],
          );
        },
      );
    },
  ];

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    double screenWidth = MediaQuery.of(context).size.width;
    return Drawer(
      backgroundColor: Colors.transparent,
      width: screenWidth * 0.75,
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
                userCtrl.name.value,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
            Obx(
              () => Text(
                "(${userCtrl.username.value})",
                style: TextStyle(fontSize: 20, color: Colors.white70),
              ),
            ),
            30.h,
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
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
