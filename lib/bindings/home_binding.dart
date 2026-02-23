import 'package:get/get.dart';
import 'package:nokair_assignment/controllers/home_controller.dart';
import 'package:nokair_assignment/remote/home_remote.dart';
import 'package:nokair_assignment/repository/home_repository.dart';
import 'package:nokair_assignment/repository/home_repository_impl.dart';
import 'package:nokair_assignment/services/dio_service.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    final dio = Get.find<DioService>().dio;
    Get.lazyPut<HomeRemote>(() => HomeRemote(dio));
    Get.lazyPut<HomeRepository>(() => HomeRepositoryImpl());
    Get.lazyPut(() => HomeController());
  }
}
