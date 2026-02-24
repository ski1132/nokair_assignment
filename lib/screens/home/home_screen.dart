import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nokair_assignment/controllers/home_controller.dart';
import 'package:nokair_assignment/gen/assets.gen.dart';
import 'package:nokair_assignment/models/today_duty_model.dart';
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
              const SizedBox(height: 12),
              _buildTodaysDutiesNote(),
              const SizedBox(height: 16),
              _buildUpcomingDutiesSection(),
              const SizedBox(height: 16),
              _buildBottomActionCards(),
              const SizedBox(height: 32),
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
    return Obx(() {
      if (controller.dutyModel.value == null) return SizedBox();
      if ((controller.dutyModel.value?.todayDuty.date.split(' ').length ?? 0) <
          3) {
        return SizedBox();
      }
      final dateList = controller.dutyModel.value!.todayDuty.date.split(' ');
      final dayInWeek = dateList.first;
      final day = dateList[1];
      final month = dateList[2];
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            dayInWeek,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '$day $month',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
    });
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
              Obx(
                () => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.darkBackground,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Text(
                      controller.dutyModel.value == null
                          ? 'No Duty'
                          : '${controller.dutyModel.value?.todayDuty.dutyId ?? '-'} • ${controller.dutyModel.value?.todayDuty.route ?? '-'}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
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
            borderRadius: BorderRadius.circular(16),
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
        borderRadius: BorderRadius.circular(16),
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
          Obx(
            () => (controller.dutyModel.value?.notificationsCount ?? 0) == 0
                ? SizedBox()
                : CircleAvatar(
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

  Widget _buildTodaysDutiesNote() {
    return Obx(() {
      final todayDuty = controller.dutyModel.value?.todayDuty;
      if (todayDuty == null) {
        return SizedBox();
      }
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Container(
                width: 6,
                decoration: BoxDecoration(
                  color: AppColors.purple,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Container(
                        width: 15.w,
                        height: 15.w,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: SvgPicture.asset(Assets.svg.noteIc),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              todayDuty.date.length > 1
                                  ? todayDuty.date
                                        .split(' ')
                                        .sublist(
                                          0,
                                          todayDuty.date.split(' ').length - 1,
                                        )
                                        .join(' ')
                                        .toUpperCase()
                                  : '-',
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              todayDuty.route.length > 1
                                  ? todayDuty.route
                                        .split('-')
                                        .sublist(
                                          0,
                                          todayDuty.route.split('-').length - 1,
                                        )
                                        .join(' • ')
                                  : '-',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildDutyCard() {
    return Obx(() {
      final todayDuty = controller.dutyModel.value?.todayDuty;
      if (todayDuty == null) {
        return SizedBox(
          height: 20.w,
          child: Center(
            child: Text(
              'No Today Duties',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        );
      }
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
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
            _buildWindowOpen(todayDuty.isWindowOpen),
          ],
        ),
      );
    });
  }

  Widget _buildDutyCardHeader(TodayDutyModel? duty) {
    return Container(
      width: 100.w,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: AppColors.darkBackground,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.blue,
              borderRadius: BorderRadius.circular(16),
            ),
            child: SvgPicture.asset(
              Assets.svg.pilotHatIc,
              colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
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
          ),
        ],
      ),
    );
  }

  Widget _buildWindowOpen(bool isWindowOpen) {
    return Container(
      width: 100.w,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isWindowOpen ? AppColors.yellow : Colors.transparent,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: isWindowOpen
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.fingerprint, color: AppColors.textPrimary),
                SizedBox(width: 8),
                Text(
                  "WINDOW OPEN",
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            )
          : SizedBox(),
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

  // ─── Upcoming Duties ───────────────────────────────────────────────────────
  Widget _buildUpcomingDutiesSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                "Next Duty / Upcoming",
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
          const SizedBox(height: 12),
          Obx(() {
            final upcomingDuties =
                controller.dutyModel.value?.upcomingDuties ?? [];
            if (upcomingDuties.isEmpty) {
              return SizedBox(
                height: 20.w,
                child: Center(
                  child: Text(
                    'No Upcoming Duties',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              );
            }
            return ListView.separated(
              shrinkWrap: true,
              primary: false,
              itemCount: upcomingDuties.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final duty = upcomingDuties[index];
                return _buildUpcomingDutyCard(
                  date: duty.dateNumber,
                  month: duty.month,
                  title: duty.title,
                  subtitle: duty.dayTypeLabel,
                  isUrgent: duty.isUrgent,
                  urgentLabel: duty.urgentLabel,
                  onTap: () {},
                );
              },
            );
          }),
        ],
      ),
    );
  }

  Widget _buildUpcomingDutyCard({
    required String date,
    required String month,
    required String title,
    required String subtitle,
    required bool isUrgent,
    String? urgentLabel,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Container(
              width: 6,
              decoration: BoxDecoration(
                color: isUrgent ? AppColors.darkBackground : AppColors.blue,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 15.w,
                      height: 15.w,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              month,
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            Text(
                              date,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                subtitle,
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey,
                                ),
                              ),
                              if (isUrgent && urgentLabel != null) ...[
                                const SizedBox(width: 12),
                                Assets.icons.planIc.image(
                                  width: 16,
                                  height: 16,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  urgentLabel.toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.yellowAccent,
                                  ),
                                ),
                              ],
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Bottom Action Cards ───────────────────────────────────────────────────
  Widget _buildBottomActionCards() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: _buildActionCard(
                title: 'ROSTER',
                subtitle: 'List and Monthly View',
                icon: Assets.icons.planIc.image(width: 8.w, height: 8.w),
                iconBackgroundColor: AppColors.yellowLight,
                iconColor: AppColors.yellowAccent,
                backgroundColor: Colors.white,
                textColor: AppColors.textPrimary,
                subtitleColor: Colors.grey,
                isSignOn: false,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildActionCard(
                title: 'SIGN ON',
                subtitle: 'Window Open',
                icon: Icon(
                  Icons.fingerprint,
                  color: AppColors.yellowAccent,
                  size: 8.w,
                ),
                iconBackgroundColor: Colors.white.withValues(alpha: 0.2),
                iconColor: AppColors.yellowAccent,
                backgroundColor: AppColors.darkBackground,
                textColor: Colors.white,
                subtitleColor: Colors.white,
                isSignOn: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard({
    required String title,
    required String subtitle,
    required Widget icon,
    required Color iconBackgroundColor,
    required Color iconColor,
    required Color backgroundColor,
    required Color textColor,
    required Color subtitleColor,
    required bool isSignOn,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 6.w,
            backgroundColor: iconBackgroundColor,
            child: icon,
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              if (isSignOn) ...[
                CircleAvatar(radius: 1.w, backgroundColor: AppColors.green),
                const SizedBox(width: 6),
              ],
              Expanded(
                child: Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: subtitleColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
