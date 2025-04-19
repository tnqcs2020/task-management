import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:task_management/utils/shared_user_data.dart';
import 'package:task_management/utils/user_controller.dart';
import 'package:task_management/views/home/home_view.dart';
import 'package:task_management/views/login/login_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedUserData sharedUserData = SharedUserData();
  final userInfo = await sharedUserData.getUserInfo();
  final userController = Get.put(UserController());
  bool isLoggedIn = false;
  if (userInfo['username'] != null &&
      userInfo['username'] != "" &&
      userInfo['name'] != null &&
      userInfo['name'] != "") {
    isLoggedIn = true;
    userController.setUser(userInfo['username']!, userInfo['name']!);
  }
  runApp(
    // DevicePreview(
    //   enabled: true,
    //   tools: const [...DevicePreview.defaultTools],
    //   builder: (context) => MyApp(isLoggedIn: isLoggedIn),
    // ),
    MyApp(isLoggedIn: isLoggedIn),
  );
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: const TextTheme(
          displaySmall: TextStyle(color: Colors.black, fontSize: 15),
          displayMedium: TextStyle(color: Colors.black, fontSize: 18),
          displayLarge: TextStyle(color: Colors.black, fontSize: 23),
          titleSmall: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
          titleLarge: TextStyle(
            fontSize: 35,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [const Locale('vi', ''), const Locale('en', '')],
      home: isLoggedIn ? const HomeView() : const LoginView(),
      // home: HomeView(),
      builder: EasyLoading.init(),
    );
  }
}
