import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:nokair_assignment/gen/assets.gen.dart';
import 'package:nokair_assignment/theme/app_colors.dart';
import 'package:sizer/sizer.dart';
import '../screens/home/home_screen.dart';
import '../widgets/bottom_nav_bar.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
    _PlaceholderScreen(label: 'Ops'),
    SizedBox(),
    _PlaceholderScreen(label: 'Message'),
    _PlaceholderScreen(label: 'More'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
      floatingActionButton: CircleAvatar(
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _PlaceholderScreen extends StatelessWidget {
  final String label;

  const _PlaceholderScreen({required this.label});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Center(
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1B1B2F),
          ),
        ),
      ),
    );
  }
}
