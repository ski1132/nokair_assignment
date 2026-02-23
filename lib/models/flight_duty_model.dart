import 'package:freezed_annotation/freezed_annotation.dart';

part 'flight_duty_model.freezed.dart';
part 'flight_duty_model.g.dart';

@freezed
abstract class FlightDutyModel with _$FlightDutyModel {
  const factory FlightDutyModel({
    @JsonKey(name: "flight_no") required String flightNo,
    @JsonKey(name: "origin") required String origin,
    @JsonKey(name: "destination") required String destination,
  }) = _FlightDutyModel;

  factory FlightDutyModel.fromJson(Map<String, dynamic> json) =>
      _$FlightDutyModelFromJson(json);
}
