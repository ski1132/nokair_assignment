import 'package:get/get.dart';
import 'package:nokair_assignment/models/response_api_model.dart';
import 'package:nokair_assignment/remote/duty_remote.dart';
import 'package:nokair_assignment/repository/duty_repository.dart';
import 'package:retrofit/dio.dart';

class DutyRepositoryImpl implements DutyRepository {
  final DutyRemote remoteSource = Get.find();

  @override
  Future<HttpResponse<ResponseApiModel>> getDuty() {
    return remoteSource.getDuty();
  }
}
