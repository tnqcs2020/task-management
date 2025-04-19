import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:task_management/extensions/space_exs.dart';
import 'package:task_management/utils/app_colors.dart';
import 'package:task_management/utils/http_services.dart';
import 'package:task_management/utils/shared_user_data.dart';
import 'package:task_management/views/home/home_view.dart';
import 'package:task_management/views/singup/signup_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  void _login() async {
    if (_formKey.currentState!.validate()) {
      HttpServices httpServices = HttpServices();
      final result = await httpServices.login(
        _usernameCtrl.text,
        _passwordCtrl.text,
      );
      if (result['success']) {
        SharedUserData sharedUserData = SharedUserData();
        await sharedUserData.saveUserInfo(
          result['username'],
          result['username'],
        );
        EasyLoading.showSuccess('Đăng nhập thành công!');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeView()),
        );
      } else {
        EasyLoading.showError('Tài khoản hoặc mật khẩu không đúng!');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              45.h,
              Center(
                child: Text(
                  "Task Management",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ),
              Center(
                child: Text(
                  "Đăng nhập để tiếp tục ...",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ),
              70.h,
              Text("Tài khoản", style: TextStyle(fontSize: 23)),
              TextFormField(
                controller: _usernameCtrl,
                decoration: InputDecoration(hintText: "Ví dụ: tnquang201"),
                style: TextStyle(fontSize: 20),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Nhập tài khoản";
                  } else if (value.length < 6) {
                    return "Tài khoản phải có ít nhất 6 ký tự";
                  }
                  return null;
                },
              ),
              40.h,
              Text("Mật khẩu", style: TextStyle(fontSize: 23)),
              TextFormField(
                controller: _passwordCtrl,
                obscureText: true,
                decoration: InputDecoration(hintText: "Ví dụ: Quang@123"),
                style: TextStyle(fontSize: 20),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Nhập mật khẩu";
                  } else if (value.length < 6) {
                    return "Mật khẩu phải có ít nhất 6 ký tự";
                  }
                  return null;
                },
                onFieldSubmitted: (_) => _login(),
              ),
              Expanded(
                child: Center(
                  child: GestureDetector(
                    onTap: () => _login(),
                    child: Container(
                      width: 200,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        gradient: LinearGradient(
                          colors: AppColors.primaryGradientColor,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Đăng Nhập",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Chưa có tài khoản? ",
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignupView()),
                        );
                      },
                      child: Text(
                        "Đăng ký ngay",
                        style: TextStyle(
                          fontSize: 18,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
