import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nokair_assignment/models/today_duty_model.dart';
import 'package:nokair_assignment/models/upcoming_duty_mode.dart';

part 'duty_model.freezed.dart';
part 'duty_model.g.dart';

@freezed
abstract class DutyModel with _$DutyModel {
  const factory DutyModel({
    @JsonKey(name: "notifications_count") required int notificationsCount,
    @JsonKey(name: "today_duty") required TodayDutyModel todayDuty,
    @JsonKey(name: "upcoming_duties")
    required List<UpcomingDutyModel> upcomingDuties,
  }) = _DutyModel;

  factory DutyModel.fromJson(Map<String, dynamic> json) =>
      _$DutyModelFromJson(json);
}
