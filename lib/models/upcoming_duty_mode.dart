import 'package:freezed_annotation/freezed_annotation.dart';

part 'upcoming_duty_mode.freezed.dart';
part 'upcoming_duty_mode.g.dart';

@freezed
abstract class UpcomingDutyModel with _$UpcomingDutyModel {
  const factory UpcomingDutyModel({
    @JsonKey(name: "id") required String id,
    @JsonKey(name: "date_number") required String dateNumber,
    @JsonKey(name: "month") required String month,
    @JsonKey(name: "day_type_label") required String dayTypeLabel,
    @JsonKey(name: "title") required String title,
    @JsonKey(name: "is_urgent") required bool isUrgent,
    @JsonKey(name: "urgent_label") String? urgentLabel,
  }) = _UpcomingDutyModel;

  factory UpcomingDutyModel.fromJson(Map<String, dynamic> json) =>
      _$UpcomingDutyModelFromJson(json);
}
