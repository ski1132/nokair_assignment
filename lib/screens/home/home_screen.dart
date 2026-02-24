import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nokair_assignment/controllers/home_controller.dart';
import 'package:nokair_assignment/gen/assets.gen.dart';
import 'package:nokair_assignment/utils/format/date_format.dart';
import 'package:nokair_assignment/widgets/clipper/right_cornor_clipper.dart';
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
              const SizedBox(height: 12),
              _buildNotificationBar(),
              const SizedBox(height: 16),
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
                controller.profile.value?.name ?? '-',
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
                  '${controller.profile.value?.type ?? '-'} / ${controller.profile.value?.id ?? '-'}',
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
            icon: Icons.calendar_month,
            label: 'Duties',
            hasNotification: false,
          ),
          _buildActionButton(
            icon: Icons.sync_alt,
            label: 'Changes',
            hasNotification: true,
          ),
          _buildActionButton(
            icon: Icons.chat_bubble_outline,
            label: 'Message',
            hasNotification: false,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
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
                color: Colors.grey.withValues(alpha: 0.5),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 6.w,
                backgroundColor: AppColors.yellowLight,
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Center(
                    child: Icon(icon, color: AppColors.yellow, size: 7.w),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
        if (hasNotification)
          Positioned(
            top: -6,
            right: -6,
            child: Container(
              width: 20,
              height: 20,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text(
                  'N',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
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
            color: Colors.grey.withValues(alpha: 0.5),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.yellow.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.notifications,
              color: AppColors.yellow,
              size: 20,
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
          Container(
            width: 22,
            height: 22,
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text(
                'N',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
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
          const Text(
            "Today's Duties (n)",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 10),
          Obx(
            () => ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: controller.dutyList.value?.upcomingDuties.length ?? 0,
              itemBuilder: (context, index) {
                return _buildDutyCard();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDutyCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.5),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildDutyCardHeader(),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              children: [
                _buildDutyTimes(),
                const SizedBox(height: 14),
                _buildDutyMetrics(),
                const SizedBox(height: 14),
                _buildRouteSegments(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDutyCardHeader() {
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
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppColors.yellow.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Icon(Icons.flight, color: AppColors.yellow, size: 18),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'FLY01-02 • DMK-CNX-DMK',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'Mon 12 Jan 26',
                style: TextStyle(color: Colors.white60, fontSize: 11),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDutyTimes() {
    return Row(
      children: [
        _buildTimeItem(
          label: 'ON (REPORT)',
          value: '08:00L',
          valueColor: AppColors.green,
        ),
        _buildTimeItem(
          label: 'ONLINE (FDP)',
          value: '5h 45m',
          valueColor: AppColors.textPrimary,
        ),
        _buildTimeItem(
          label: 'OFF (CLEAR)',
          value: '13:45L',
          valueColor: Colors.red,
        ),
      ],
    );
  }

  Widget _buildDutyMetrics() {
    return Row(
      children: [
        _buildTimeItem(
          label: 'FLIGHT TIME',
          value: '2h 30m',
          valueColor: AppColors.yellow,
        ),
        _buildTimeItem(
          label: 'TAFB',
          value: '5h 45m',
          valueColor: AppColors.textPrimary,
        ),
        _buildTimeItem(
          label: 'LAYOVER',
          value: '0h 00m',
          valueColor: AppColors.textPrimary,
        ),
      ],
    );
  }

  Widget _buildTimeItem({
    required String label,
    required String value,
    required Color valueColor,
  }) {
    return Expanded(
      child: Column(
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
      ),
    );
  }

  Widget _buildRouteSegments() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildAirportCode('DMK'),
          _buildFlightSegment('DD 132'),
          _buildAirportCode('CNX'),
          _buildFlightSegment('DD 231'),
          _buildAirportCode('DMK'),
        ],
      ),
    );
  }

  Widget _buildAirportCode(String code) {
    return Text(
      code,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 13,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildFlightSegment(String flightNo) {
    return Column(
      children: [
        Text(
          flightNo,
          style: const TextStyle(
            fontSize: 9,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 2),
        Row(
          children: [
            Container(width: 30, height: 1.5, color: AppColors.yellow),
            const Icon(Icons.flight, color: AppColors.yellow, size: 14),
            Container(width: 30, height: 1.5, color: AppColors.yellow),
          ],
        ),
      ],
    );
  }
}
