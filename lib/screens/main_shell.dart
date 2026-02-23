import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:nokair_assignment/controllers/main_shell_controller.dart';
import 'package:nokair_assignment/gen/assets.gen.dart';
import 'package:nokair_assignment/theme/app_colors.dart';
import 'package:sizer/sizer.dart';
import '../widgets/bottom_nav_bar.dart';

class MainShell extends GetView<MainShellController> {
  const MainShell({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => controller.currentPage),
      bottomNavigationBar: Obx(
        () => AppBottomNavBar(
          currentIndex: controller.currentIndex.value,
          onTap: (index) => controller.changeIndex(index),
        ),
      ),
      floatingActionButton: InkWell(
        onTap: () => controller.changeIndex(2),
        child: CircleAvatar(
          radius: 10.w, // radius ใหญ่กว่าชั้นในนิดหน่อย = ความหนาของขอบ
          backgroundColor: Colors.white, // สีขอบ
          child: CircleAvatar(
            radius: 9.w,
            backgroundColor: AppColors.yellowLight,
            child: Container(
              padding: EdgeInsets.all(5.w),
              child: Assets.icons.planIc.image(),
            ),
          ),
        ).marginOnly(top: 5.w),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
