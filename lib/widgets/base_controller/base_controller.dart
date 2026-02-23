import 'package:flutter/material.dart';
import 'package:flutter_easyloading_plus/flutter_easyloading_plus.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nokair_assignment/flavors/build_config.dart';

abstract class BaseController extends GetxController {
  final PreferredSizeWidget? appBar = null;
  // final Logger logger = AppConfig.logger;
  final Logger logger = BuildConfig.instance.config.logger;

  // AppLocalizations get appLocalization => AppLocalizations.of(Get.context!)!;

  final logoutController = false.obs;

  Future<void> showLoading() => EasyLoading.show();

  Future<void> hideLoading() => EasyLoading.dismiss();
}
