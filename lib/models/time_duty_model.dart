import 'package:freezed_annotation/freezed_annotation.dart';

part 'time_duty_model.freezed.dart';
part 'time_duty_model.g.dart';

@freezed
abstract class TimeDutyModel with _$TimeDutyModel {
  const factory TimeDutyModel({
    @JsonKey(name: "report") required String report,
    @JsonKey(name: "duty_fdp") required String dutyFdp,
    @JsonKey(name: "off_clear") required String offClear,
    @JsonKey(name: "flight_time") required String flightTime,
    @JsonKey(name: "tafb") required String tafb,
    @JsonKey(name: "layover") required String layover,
  }) = _TimeDutyModel;

  factory TimeDutyModel.fromJson(Map<String, dynamic> json) =>
      _$TimeDutyModelFromJson(json);
}
