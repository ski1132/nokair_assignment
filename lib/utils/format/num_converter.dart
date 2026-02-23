import 'package:freezed_annotation/freezed_annotation.dart';

class NumConverter implements JsonConverter<num?, Object?> {
  const NumConverter();

  @override
  num? fromJson(Object? json) {
    if (json == null) return null;
    if (json is num) return json;
    if (json is String) return num.tryParse(json);
    return null;
  }

  @override
  Object? toJson(num? object) => object;
}

class IntConverter implements JsonConverter<int?, Object?> {
  const IntConverter();

  @override
  int? fromJson(Object? json) {
    if (json == null) return null;
    if (json is int) return json;
    if (json is num) return json.toInt();
    if (json is String) {
      return int.tryParse(json) ?? double.tryParse(json)?.toInt();
    }
    return null;
  }

  @override
  Object? toJson(int? object) => object;
}

class DoubleConverter implements JsonConverter<double?, Object?> {
  const DoubleConverter();

  @override
  double? fromJson(Object? json) {
    if (json == null) return null;
    if (json is double) return json;
    if (json is num) return json.toDouble();
    if (json is String) return double.tryParse(json);
    return null;
  }

  @override
  Object? toJson(double? object) => object;
}
