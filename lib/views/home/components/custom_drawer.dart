import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:task_management/extensions/space_exs.dart';
import 'package:task_management/utils/app_colors.dart';
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
  final userController = Get.find<UserController>();
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
                  EasyLoading.showSuccess('Đăng xuất thành công!');
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginView()),
                    (route) => false,
                  );
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
                userController.name.value,
                style: textTheme.displaySmall,
              ),
            ),
            Obx(
              () => Text(
                userController.username.value,
                style: textTheme.displaySmall,
              ),
            ),
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
