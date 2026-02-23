import 'package:nokair_assignment/models/response_api_model.dart';
import 'package:retrofit/dio.dart';

abstract class DutyRepository {
  Future<HttpResponse<ResponseApiModel>> getDuty();
}
