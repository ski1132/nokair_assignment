import 'package:get/get.dart';
import 'package:nokair_assignment/bindings/main_shell_binding.dart';
import 'package:nokair_assignment/services/dio_service.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DioService(), permanent: true);
    MainShellBinding().dependencies();
  }
}
