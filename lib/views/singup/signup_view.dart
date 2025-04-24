import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:task_management/extensions/space_exs.dart';
import 'package:task_management/utils/app_colors.dart';
import 'package:task_management/utils/custom_field.dart';
import 'package:task_management/utils/http_services.dart';
import 'package:task_management/utils/shared_user_data.dart';
import 'package:task_management/utils/user_controller.dart';
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
  final TextEditingController _rePasswordCtrl = TextEditingController();
  final TextEditingController _nameCtrl = TextEditingController();
  final userController = Get.put(UserController());

  void _signup() async {
    if (_formKey.currentState!.validate()) {
      HttpServices httpServices = HttpServices();
      final result = await httpServices.register(
        _usernameCtrl.text,
        _passwordCtrl.text,
        _nameCtrl.text,
      );
      if (result['success']) {
        SharedUserData sharedUserData = SharedUserData();
        await sharedUserData.saveUserInfo(result['username'], result['name']);
        userController.setUser(result['username']!, result['name']);
        EasyLoading.showSuccess('Đăng ký thành công!');
        Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => HomeView()),
        );
      } else {
        EasyLoading.showError(
          'Tài khoản đã tồn tại hoặc thông tin không hợp lệ!',
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 50),
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "Taskment",
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "Đăng ký để tiếp tục ...",
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ),
                  35.h,
                  CustomField(
                    controller: _nameCtrl,
                    label: "Họ và tên",
                    hint: "Ví dụ: Nhựt Quang",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Nhập họ và tên";
                      }
                      return null;
                    },
                  ),
                  20.h,
                  CustomField(
                    controller: _usernameCtrl,
                    label: "Tài khoản",
                    hint: "Ví dụ: tnquang201",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Nhập tài khoản";
                      } else if (value.length < 6) {
                        return "Tài khoản phải có ít nhất 6 ký tự";
                      }
                      return null;
                    },
                  ),
                  20.h,
                  CustomField(
                    controller: _passwordCtrl,
                    isPassword: true,
                    label: "Mật khẩu",
                    hint: "Ví dụ: Quang@123",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Nhập mật khẩu";
                      } else if (value.length < 6) {
                        return "Mật khẩu phải có ít nhất 6 ký tự";
                      }
                      return null;
                    },
                  ),
                  20.h,
                  CustomField(
                    controller: _rePasswordCtrl,
                    isPassword: true,
                    label: "Nhập lại mật khẩu",
                    hint: "Ví dụ: Quang@123",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Nhập mật khẩu";
                      } else if (value.length < 6) {
                        return "Mật khẩu phải có ít nhất 6 ký tự";
                      } else if (value != _passwordCtrl.text) {
                        return "Mật khẩu không trùng khớp";
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => _signup(),
                  ),
                  45.h,
                  Center(
                    child: GestureDetector(
                      onTap: () => _signup(),
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
                  35.h,
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
                              MaterialPageRoute(
                                builder: (context) => LoginView(),
                              ),
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
        ),
      ),
    );
  }
}
