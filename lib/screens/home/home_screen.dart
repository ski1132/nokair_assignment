import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nokair_assignment/controllers/home_controller.dart';
import 'package:nokair_assignment/gen/assets.gen.dart';
import 'package:nokair_assignment/models/today_duty_model.dart';
import 'package:nokair_assignment/utils/format/date_format.dart';
import 'package:nokair_assignment/widgets/clipper/right_cornor_clipper.dart';
import 'package:nokair_assignment/widgets/container/container_curved.dart';
import 'package:sizer/sizer.dart';

import '../../theme/app_colors.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              _buildFlightBanner(),
              const SizedBox(height: 16),
              _buildQuickActions(),
              const SizedBox(height: 16),
              _buildNotificationBar(),
              const SizedBox(height: 28),
              _buildTodaysDutiesSection(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  // ─── Header ───────────────────────────────────────────────────────────────
  Widget _buildHeader() {
    return Container(
      color: AppColors.darkBackground,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_buildDateInfo(), _buildPilotInfo()],
      ),
    );
  }

  Widget _buildDateInfo() {
    final date = DateTime.now();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          date.formatDayWeek(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          date.formatDMM(symbol: ' '),
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildPilotInfo() {
    return Obx(
      () => Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                controller.profileModel.value?.name ?? '-',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.yellow,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '${controller.profileModel.value?.type ?? '-'} / ${controller.profileModel.value?.id ?? '-'}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
          _buildAvatarBadge(),
        ],
      ),
    );
  }

  Widget _buildAvatarBadge() {
    return CircleAvatar(
      radius: 7.w,
      backgroundColor: AppColors.yellowLight,
      backgroundImage: Assets.icons.nokairLogo.image().image,
    );
  }

  // ─── Flight Banner ─────────────────────────────────────────────────────────
  Widget _buildFlightBanner() {
    return Container(
      color: AppColors.darkBackground,
      child: ClipPath(
        clipper: RightCornerClipper(),
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(color: AppColors.yellow),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(backgroundColor: AppColors.blue, radius: 1.5.w),
              const SizedBox(width: 8),
              const Text(
                'FLIGHT',
                style: TextStyle(
                  color: AppColors.darkBackground,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.darkBackground,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Center(
                  child: Text(
                    'FLY01-02 • DMK-CNX-DMK',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  // ─── Quick Actions ─────────────────────────────────────────────────────────
  Widget _buildQuickActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildActionButton(
            iconSvgPath: Assets.svg.calendarIc,
            label: 'Duties',
            hasNotification: false,
          ),
          _buildActionButton(
            iconSvgPath: Assets.svg.swapIc,
            label: 'Changes',
            hasNotification: true,
          ),
          _buildActionButton(
            iconSvgPath: Assets.svg.messageIc,
            label: 'Message',
            hasNotification: false,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required String iconSvgPath,
    required String label,
    required bool hasNotification,
  }) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 27.w,
          height: 27.w,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.3),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: CircleAvatar(
                  radius: 7.w,
                  backgroundColor: AppColors.yellowLight,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Center(
                      child: SvgPicture.asset(
                        iconSvgPath,
                        colorFilter: ColorFilter.mode(
                          AppColors.yellow,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (hasNotification)
          Positioned(
            top: -6,
            right: -6,
            child: CircleAvatar(
              radius: 12,
              backgroundColor: Colors.red,
              child: const Center(
                child: Text(
                  'N',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  // ─── Notification Bar ──────────────────────────────────────────────────────
  Widget _buildNotificationBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 7.w,
            backgroundColor: AppColors.yellowLight,
            child: Container(
              padding: EdgeInsets.all(8),
              child: Center(
                child: SvgPicture.asset(
                  Assets.svg.notificationIc,
                  colorFilter: ColorFilter.mode(
                    AppColors.yellow,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Notification',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          CircleAvatar(
            radius: 12,
            backgroundColor: Colors.red,
            child: const Center(
              child: Text(
                'N',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Today's Duties ────────────────────────────────────────────────────────
  Widget _buildTodaysDutiesSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                "Today's Duties",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                "(n)",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _buildDutyCard(),
        ],
      ),
    );
  }

  Widget _buildDutyCard() {
    return Obx(() {
      final todayDuty = controller.dutyModel.value?.todayDuty;
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            _buildDutyCardHeader(todayDuty),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _buildDutyTimes(todayDuty),
                  const SizedBox(height: 16),
                  _buildDutyMetrics(todayDuty),
                  const SizedBox(height: 16),
                  _buildRouteSegments(todayDuty),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildDutyCardHeader(TodayDutyModel? duty) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: const BoxDecoration(
        color: AppColors.darkBackground,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.blue,
              borderRadius: BorderRadius.circular(6),
            ),
            child: SvgPicture.asset(
              Assets.svg.pilotHatIc,
              colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${duty?.dutyId ?? '-'} • ${duty?.route ?? '-'}',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              SizedBox(height: 2),
              Text(
                duty?.date ?? '-',
                style: TextStyle(color: Colors.white60, fontSize: 11),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDutyTimes(TodayDutyModel? duty) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildTimeItem(
          label: 'ON (REPORT)',
          value: duty?.timings.report ?? '-',
          valueColor: AppColors.green,
        ),
        _buildTimeItem(
          label: 'DUTY (FDP)',
          value: duty?.timings.dutyFdp ?? '-',
          valueColor: AppColors.textPrimary,
        ),
        _buildTimeItem(
          label: 'OFF (CLEAR)',
          value: duty?.timings.offClear ?? '-',
          valueColor: Colors.red,
        ),
      ],
    );
  }

  Widget _buildDutyMetrics(TodayDutyModel? duty) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildTimeItem(
          label: 'FLIGHT TIME',
          value: duty?.timings.flightTime ?? '-',
          valueColor: AppColors.yellow,
        ),
        _buildTimeItem(
          label: 'TAFB',
          value: duty?.timings.tafb ?? '-',
          valueColor: AppColors.textPrimary,
        ),
        _buildTimeItem(
          label: 'LAYOVER',
          value: duty?.timings.layover ?? '-',
          valueColor: Colors.grey,
        ),
      ],
    );
  }

  Widget _buildTimeItem({
    required String label,
    required String value,
    required Color valueColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 9,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: valueColor,
          ),
        ),
      ],
    );
  }

  Widget _buildRouteSegments(TodayDutyModel? duty) {
    if (duty == null || duty.flights.isEmpty) {
      return SizedBox();
    }
    final flightPathList = <Widget>[];
    flightPathList.add(_buildAirportCode(duty.flights.first.from));
    for (final flight in duty.flights) {
      flightPathList.add(_buildFlightSegment(flight.flightNumber));
      flightPathList.add(_buildAirportCode(flight.to));
    }
    return ContainerCurved(
      padding: const EdgeInsets.all(16),
      backgroundColor: AppColors.yellowLight,
      child: Column(
        children: [
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: flightPathList,
          ),
        ],
      ),
    );
  }

  Widget _buildAirportCode(String code) {
    return Text(
      code,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 14,
        color: AppColors.yellowAccent,
      ),
    );
  }

  Widget _buildFlightSegment(String flightNo) {
    return Column(
      children: [
        Icon(Icons.arrow_forward, color: Colors.grey, size: 16),
        const SizedBox(height: 2),
        Text(
          flightNo,
          style: const TextStyle(
            fontSize: 10,
            color: AppColors.yellowAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
