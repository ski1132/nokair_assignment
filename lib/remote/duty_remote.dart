import 'package:dio/dio.dart';
import 'package:nokair_assignment/models/response_api_model.dart';
import 'package:retrofit/retrofit.dart';

part 'duty_remote.g.dart';

@RestApi()
abstract class DutyRemote {
  factory DutyRemote(
    Dio dio, {
    String? baseUrl,
    ParseErrorLogger? errorLogger,
  }) = _DutyRemote;

  @GET('/duty')
  Future<HttpResponse<ResponseApiModel>> getDuty();
}
