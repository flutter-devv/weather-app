import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsController extends GetxController {
  RxInt groupValue = 0.obs;
  RxString selectedNotificationTime = "1 hour".obs;
  RxBool notificationSwitch = false.obs;

  void changeGroupValueState(int val) => groupValue.value = val;
  void changeNotificationTime(String time) =>
      selectedNotificationTime.value = time;
  void changeNotificationSwitchState(bool val) =>
      notificationSwitch.value = val;

  @override
  void onInit() {
    GetStorage box = GetStorage();
    notificationSwitch.value = box.read("switchState") ?? false;
    groupValue.value = box.read("radioState") ?? 0;
    selectedNotificationTime.value = box.read("notificationTime") ?? "1 hour";
    super.onInit();
  }
}
