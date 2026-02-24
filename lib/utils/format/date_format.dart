import 'dart:developer';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

extension DateFormatCustom on DateTime {
  String formatYMD({bool local = true}) {
    DateTime date = toLocal();
    String result = DateFormat('yyyy-MM-dd').format(local ? date : this);
    return result;
  }

  String formatDMY({String symbol = '-'}) {
    DateTime date = toLocal();
    String result = DateFormat('dd${symbol}MM${symbol}yyyy').format(date);
    return result;
  }

  String formatDMM({String symbol = '-'}) {
    DateTime date = toLocal();
    String result = DateFormat('dd${symbol}MMM').format(date);
    return result;
  }

  String formatDMYShort() {
    DateTime date = toLocal();
    String result = DateFormat('dd MMM yy').format(date);
    return result;
  }

  String formatDMMMMY({String symbol = '-'}) {
    DateTime date = toLocal();
    String result = DateFormat('dd${symbol}MMMM${symbol}yyyy').format(date);
    return result;
  }

  String formatDMYHM({String symbol = '-'}) {
    DateTime date = toLocal();
    String result = DateFormat(
      'dd${symbol}MMM${symbol}yyyy, hh:mm a',
    ).format(date);
    return result;
  }

  String formatHM() {
    DateTime date = toLocal();
    String result = DateFormat('HH : mm').format(date);
    return result;
  }

  String formatDE({String symbol = '-'}) {
    DateTime date = toLocal();
    String day = DateFormat('d').format(date); // ดึงวันที่ (19, 20)
    String shortWeekDay = DateFormat(
      'EEE',
    ).format(date).substring(0, 2); // ดึงชื่อวัน 2 ตัวอักษร
    return '$day\n$shortWeekDay';
  }

  String formatDayNumber() {
    DateTime date = toLocal();
    return DateFormat('d').format(date);
  }

  String formatDayWeek() {
    //name of day in week
    DateTime date = toLocal();
    return DateFormat('EEE', Get.locale?.languageCode).format(date);
  }

  String formatWeekDMMMYHM() {
    //name of day in week
    DateTime date = toLocal();
    return DateFormat('EEEE dd MMM yyyy , HH:mm').format(date);
  }

  String formatyMMMMd() {
    DateTime date = toLocal();
    DateFormat format = DateFormat.yMMMMd(Get.locale!.languageCode);
    String result = format.format(date);
    return result;
  }

  String formatM() {
    DateTime date = toLocal();
    DateFormat format = DateFormat.MMMM(Get.locale!.languageCode);
    String result = format.format(date);
    return result;
  }

  String formatMMMDY() {
    log('countryCode : ${Get.locale?.languageCode}');
    DateTime date = toLocal();
    DateFormat format = DateFormat.MMMd(Get.locale?.languageCode ?? 'th');
    String result = format.format(date);
    return '$result,${date.year}';
  }

  String formatTimeLeft() {
    final duration = difference(DateTime.now());
    if (duration.inDays > 0) {
      return '${duration.inDays} ${'day'.tr}';
    } else if (duration.inHours > 0) {
      return '${duration.inHours} ${'hour'.tr}';
    } else {
      return '${duration.inMinutes} ${'minute'.tr}';
    }
  }

  bool isSameday(DateTime date) {
    return date.year == year && date.month == month && date.day == day;
  }

  String formatMMMMY({String symbol = '-'}) {
    DateTime date = toLocal();
    String result = DateFormat('MMMM${symbol}yyyy').format(date);
    return result;
  }
}

extension StringDateFormatCustom on String? {
  DateTime? toDateTime() {
    if (this == null) return null;
    try {
      return DateTime.parse(this!).toLocal();
    } catch (e) {
      return null;
    }
  }

  String formatIsoDate() {
    final date = toDateTime();
    if (date == null) return this ?? '-';
    return DateFormat('dd MMM yyyy', Get.locale?.languageCode).format(date);
  }

  String formatIsoTime() {
    final date = toDateTime();
    if (date == null) return this ?? '-';
    return DateFormat('HH:mm').format(date);
  }

  String formatIsoDateTime() {
    final date = toDateTime();
    if (date == null) return this ?? '-';
    return DateFormat('dd MMM yyyy, HH:mm', Get.locale?.languageCode)
        .format(date);
  }
}
