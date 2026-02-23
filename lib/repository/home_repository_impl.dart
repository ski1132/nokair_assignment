import 'package:get/get.dart';
import 'package:nokair_assignment/models/response_api_model.dart';
import 'package:nokair_assignment/remote/home_remote.dart';
import 'package:nokair_assignment/repository/home_repository.dart';
import 'package:retrofit/dio.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemote remoteSource = Get.find();

  @override
  Future<HttpResponse<ResponseApiModel>> getDuty() {
    return remoteSource.getDuty();
  }
}
