import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_management/extensions/space_exs.dart';
import 'package:task_management/utils/app_colors.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  //Icon
  final List<IconData> icons = [
    CupertinoIcons.home,
    CupertinoIcons.person_fill,
    CupertinoIcons.settings,
    CupertinoIcons.info_circle_fill,
  ];

  // Texts
  final List<String> texts = ["Home", "Profile", "Settings", "Details"];

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
            8.h,
            Text('Nhut Quang', style: textTheme.displayMedium),
            Text('Flutter dev', style: textTheme.displaySmall),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
              width: double.infinity,
              height: 300,
              child: ListView.builder(
                itemCount: icons.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {},
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
          ],
        ),
      ),
    );
  }
}
