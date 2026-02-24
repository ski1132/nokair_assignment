import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nokair_assignment/utils/format/num_converter.dart';

part 'response_api_model.freezed.dart';
part 'response_api_model.g.dart';

@freezed
abstract class ResponseApiModel with _$ResponseApiModel {
  const factory ResponseApiModel({
    @JsonKey(name: 'status') String? status,
    @JsonKey(name: 'message') String? message,
    @JsonKey(name: 'data') dynamic data,
  }) = _ResponseApiModel;

  factory ResponseApiModel.fromJson(Map<String, Object?> json) =>
      _$ResponseApiModelFromJson(json);
}
