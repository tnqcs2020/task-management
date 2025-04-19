import 'package:get/get.dart';

class UserController extends GetxController {
  // Reactive user data
  var username = ''.obs;
  var name = ''.obs;

  // Set user data
  void setUser(String u, String n) {
    username.value = u;
    name.value = n;
  }

  // Clear user data (e.g. on logout)
  void clearUser() {
    username.value = '';
    name.value = '';
  }
}
