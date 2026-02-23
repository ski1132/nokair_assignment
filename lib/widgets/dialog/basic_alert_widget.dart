import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nokair_assignment/widgets/container/container_curved.dart';
import 'package:sizer/sizer.dart';

class BasicAlertWidget {
  static Future alertWarning({String contents = ""}) async {
    if (Get.isDialogOpen ?? false) Get.back();
    await Get.defaultDialog(
      contentPadding: const EdgeInsets.all(16),
      backgroundColor: Colors.white,
      title: 'Warning',
      titleStyle: TextStyle(color: Colors.black, fontSize: 20),
      content: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: 70.h, // จำกัดความสูงไม่เกิน 70% ของจอ
        ),
        child: SingleChildScrollView(
          child: Text(
            contents,
            style: TextStyle(color: Colors.black, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      confirm: ContainerCurved(
        onTap: () => Get.back(),
        borderColor: Colors.black,
        child: Text(
          'Confirm',
          style: TextStyle(color: Colors.black, fontSize: 12),
        ),
      ),
    );
  }
}
