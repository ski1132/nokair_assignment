import 'package:get/get.dart';
import 'package:nokair_assignment/controllers/main_shell_controller.dart';

class MainShellBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainShellController());
  }
}
