import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nokair_assignment/models/flight_duty_model.dart';
import 'package:nokair_assignment/models/time_duty_model.dart';

part 'duty_model.freezed.dart';
part 'duty_model.g.dart';

@freezed
abstract class DutyModel with _$DutyModel {
  const factory DutyModel({
    @JsonKey(name: "duty_type") required String dutyType,
    @JsonKey(name: "duty_date") required DateTime dutyDate,
    @JsonKey(name: "off_date") required DateTime offDate,
    @JsonKey(name: "duty_id") required String dutyId,
    @JsonKey(name: "route_summary") required String routeSummary,
    @JsonKey(name: "timing") required TimeDutyModel timing,
    @JsonKey(name: "flights") required List<FlightDutyModel> flights,
  }) = _DutyModel;

  factory DutyModel.fromJson(Map<String, dynamic> json) =>
      _$DutyModelFromJson(json);
}
