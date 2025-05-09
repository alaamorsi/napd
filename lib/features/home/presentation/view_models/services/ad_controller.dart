import 'dart:async';
import 'package:flutter/material.dart';

class AdSliderController {
  final PageController pageController = PageController();
  final ValueNotifier<int> currentIndex = ValueNotifier<int>(0);
  final List<String> ads;
  final List<String> adsImages;

  Timer? _timer;

  AdSliderController({required this.ads, required this.adsImages}) {
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      int next = (currentIndex.value + 1) % ads.length;
      currentIndex.value = next;

      pageController.animateToPage(
        next,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  void dispose() {
    _timer?.cancel();
    pageController.dispose();
    currentIndex.dispose();
  }
}
