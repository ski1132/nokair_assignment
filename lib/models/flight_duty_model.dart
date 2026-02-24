import 'package:freezed_annotation/freezed_annotation.dart';

part 'flight_duty_model.freezed.dart';
part 'flight_duty_model.g.dart';

@freezed
abstract class FlightDutyModel with _$FlightDutyModel {
  const factory FlightDutyModel({
    @JsonKey(name: "from") required String from,
    @JsonKey(name: "to") required String to,
    @JsonKey(name: "flight_number") required String flightNumber,
  }) = _FlightDutyModel;

  factory FlightDutyModel.fromJson(Map<String, dynamic> json) =>
      _$FlightDutyModelFromJson(json);
}
