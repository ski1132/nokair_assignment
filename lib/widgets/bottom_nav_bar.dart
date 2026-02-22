import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../theme/app_colors.dart';

class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 10.h,
          child: Row(
            children: [
              _buildNavItem(index: 0, icon: Icons.home_rounded, label: 'Home'),
              _buildNavItem(index: 1, icon: Icons.read_more, label: 'Ops'),
              _buildNavItem(index: 2, icon: null, label: 'Roster'),
              _buildNavItem(
                index: 3,
                icon: Icons.chat_bubble_rounded,
                label: 'Message',
              ),
              _buildNavItem(index: 4, icon: Icons.menu, label: 'More'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    IconData? icon,
    required String label,
  }) {
    final bool isSelected = currentIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              child: icon != null
                  ? Icon(
                      icon,
                      size: 8.w,
                      color: isSelected ? AppColors.yellow : AppColors.black,
                    )
                  : SizedBox(height: 8.w),
            ),
            SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? AppColors.yellow : AppColors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
