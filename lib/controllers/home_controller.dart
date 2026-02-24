import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nokair_assignment/models/duty_model.dart';
import 'package:nokair_assignment/models/profile_model.dart';
import 'package:nokair_assignment/models/response_api_model.dart';
import 'package:nokair_assignment/repository/home_repository.dart';
import 'package:nokair_assignment/widgets/base_controller/base_controller.dart';
import 'package:nokair_assignment/widgets/dialog/basic_alert_widget.dart';

class HomeController extends BaseController {
  HomeRepository repository = Get.find();

  final dutyModel = Rxn<DutyModel>();
  final profileModel = Rxn<ProfileModel>();

  @override
  void onInit() async {
    super.onInit();

    showLoading();
    await fetchProfile();
    await fetchDuty();
    hideLoading();
  }

  Future fetchDuty({bool isMock = true}) async {
    dutyModel.value = null;
    if (isMock) {
      //mock data
      await Future.delayed(const Duration(seconds: 1));
      final String response = await rootBundle.loadString(
        'assets/mock_data/duty.json',
      );
      // Decode the JSON string into a Dart object (in this case, a Map)
      final Map<String, dynamic> data = jsonDecode(response);
      final responseModel = ResponseApiModel.fromJson(data);
      dutyModel.value = DutyModel.fromJson(responseModel.data);
    } else {
      //call api
      await repository
          .getDuty()
          .then((httpResponse) async {
            final res = httpResponse.data;
            try {
              if (res.status != 'success') {
                logger.e(
                  'fetchDuty response status ${res.status} : ${res.message}',
                );
                BasicAlertWidget.alertWarning(contents: res.message.toString());
              } else {
                final json = res.data as Map<String, dynamic>? ?? {};
                dutyModel.value = DutyModel.fromJson(json);
              }
            } catch (e) {
              BasicAlertWidget.alertWarning(contents: '${e.toString()}!');
              logger.e('fetchDuty catch : $e');
            }
          })
          .onError((e, s) async {
            BasicAlertWidget.alertWarning(contents: e.toString());
            logger.e('fetchDuty onError : $e');
          });
    }
  }

  Future fetchProfile({bool isMock = true}) async {
    profileModel.value = null;

    if (isMock) {
      //mock data
      await Future.delayed(const Duration(seconds: 1));
      final String response = await rootBundle.loadString(
        'assets/mock_data/profile.json',
      );
      // Decode the JSON string into a Dart object (in this case, a Map)
      final Map<String, dynamic> data = jsonDecode(response);
      final responseModel = ResponseApiModel.fromJson(data);
      profileModel.value = ProfileModel.fromJson(responseModel.data);
    } else {
      await repository
          .getProfile()
          .then((httpResponse) async {
            final res = httpResponse.data;
            try {
              if (res.status != 'success') {
                logger.e(
                  'fetchProfile response status ${res.status} : ${res.message}',
                );
                BasicAlertWidget.alertWarning(contents: res.message.toString());
              } else {
                final json = res.data as Map<String, dynamic>? ?? {};
                profileModel.value = ProfileModel.fromJson(json);
              }
            } catch (e) {
              BasicAlertWidget.alertWarning(contents: '${e.toString()}!');
              logger.e('fetchProfile catch : $e');
            }
          })
          .onError((e, s) async {
            BasicAlertWidget.alertWarning(contents: e.toString());
            logger.e('fetchProfile onError : $e');
          });
    }
  }
}
