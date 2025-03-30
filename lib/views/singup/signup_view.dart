import 'package:flutter/material.dart';
import 'package:task_management/extensions/space_exs.dart';
import 'package:task_management/utils/app_colors.dart';
import 'package:task_management/views/home/home_view.dart';
import 'package:task_management/views/login/login_view.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  final TextEditingController _nameCtrl = TextEditingController();
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
              Center(
                child: Text(
                  "Task Management",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ),
              Center(
                child: Text(
                  "Đăng ký để tiếp tục ...",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ),
              45.h,
              Text("Họ và tên", style: TextStyle(fontSize: 23)),
              TextFormField(
                controller: _nameCtrl,
                decoration: InputDecoration(hintText: "Ví dụ: Nhựt Quang"),
                style: TextStyle(fontSize: 20),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Nhập họ và tên";
                  }
                  return null;
                },
              ),
              40.h,
              Text("Tài khoản", style: TextStyle(fontSize: 23)),
              TextFormField(
                controller: _usernameCtrl,
                decoration: InputDecoration(hintText: "Ví dụ: tnquang201"),
                style: TextStyle(fontSize: 20),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Nhập tài khoản";
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Nhập mật khẩu";
                  }
                  return null;
                },
              ),
              Expanded(
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomeView()),
                        );
                      }
                    },
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
                          "Đăng Ký",
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
                      "Đã có tài khoản? ",
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginView()),
                        );
                      },
                      child: Text(
                        "Đăng nhập ngay",
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
