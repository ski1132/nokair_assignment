import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nokair_assignment/models/flight_duty_model.dart';
import 'package:nokair_assignment/models/time_duty_model.dart';

part 'today_duty_model.freezed.dart';
part 'today_duty_model.g.dart';

@freezed
abstract class TodayDutyModel with _$TodayDutyModel {
  const factory TodayDutyModel({
    @JsonKey(name: "duty_id") required String dutyId,
    @JsonKey(name: "route") required String route,
    @JsonKey(name: "date") required String date,
    @JsonKey(name: "timings") required TimeDutyModel timings,
    @JsonKey(name: "flights") required List<FlightDutyModel> flights,
    @JsonKey(name: "is_window_open") required bool isWindowOpen,
  }) = _TodayDutyModel;

  factory TodayDutyModel.fromJson(Map<String, dynamic> json) =>
      _$TodayDutyModelFromJson(json);
}
