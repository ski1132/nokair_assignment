import 'package:dio/dio.dart';
import 'package:nokair_assignment/models/response_api_model.dart';
import 'package:retrofit/retrofit.dart';

part 'home_remote.g.dart';

@RestApi()
abstract class HomeRemote {
  factory HomeRemote(
    Dio dio, {
    String? baseUrl,
    ParseErrorLogger? errorLogger,
  }) = _HomeRemote;

  @GET('/duty')
  Future<HttpResponse<ResponseApiModel>> getDuty();

  @GET('/profile')
  Future<HttpResponse<ResponseApiModel>> getProfile();
}
