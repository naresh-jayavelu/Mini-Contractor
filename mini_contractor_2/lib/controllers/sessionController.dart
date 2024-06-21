import 'package:get/get.dart';

class SessionController extends GetxController {
  RxString userId = ''.obs;
  RxString userName = ''.obs;
  RxString userType = ''.obs;

  SessionController();

  void setSession(String id, String name, String type) {
    userId.value = id;
    userName.value = name;
    userType.value = type;
  }

  void clearSession() {
    userId.value = '';
    userName.value = '';
    userType.value = '';
  }
}
