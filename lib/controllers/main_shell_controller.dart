import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nokair_assignment/bindings/home_binding.dart';
import 'package:nokair_assignment/screens/home/coming_soon_screen.dart';
import 'package:nokair_assignment/screens/home/home_screen.dart';

class MainShellController extends GetxController {
  RxInt currentIndex = 0.obs;

  final List<Widget> pages = const [
    HomeScreen(),
    ComingSoonScreen(label: 'Ops'),
    ComingSoonScreen(label: 'Roster'),
    ComingSoonScreen(label: 'Message'),
    ComingSoonScreen(label: 'More'),
  ];

  Widget get currentPage {
    if (currentIndex.value == 0) {
      HomeBinding().dependencies();
    }
    return pages[currentIndex.value];
  }

  void changeIndex(int index) {
    currentIndex.value = index;
  }
}
