import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:one_ai/features/navigation/providers/navigation_provider.dart';
import 'package:one_ai/features/scan/providers/scan_screen_state.dart';
import 'package:one_ai/utils/constants/colors.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NavigationProvider(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ScanScreen()),
            );
          },
          backgroundColor: AppColors.secondary.withOpacity(0.8),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset(
              'assets/logos/scannify-logo.png',
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primary,
                AppColors.secondary,
                Color(0xFF1D5C5C),
              ],
            ),
          ),
          child: Consumer<NavigationProvider>(
            builder: (context, controller, _) =>
                AnimatedBottomNavigationBar.builder(
              itemCount: controller.icons.length,
              tabBuilder: (index, isActive) {
                return Icon(
                  controller.icons[index],
                  size: 30,
                  color: isActive ? AppColors.primary : Colors.grey,
                );
              },
              onTap: (index) => controller.selectedIndex = index,
              backgroundColor: Colors.transparent,
              activeIndex: controller.selectedIndex,
              splashColor: AppColors.primary,
              splashSpeedInMilliseconds: 300,
              notchSmoothness: NotchSmoothness.defaultEdge,
              leftCornerRadius: 32,
              rightCornerRadius: 32,
              gapLocation: GapLocation.center,
            ),
          ),
        ),
        body: Consumer<NavigationProvider>(
          builder: (context, controller, _) =>
              controller.screens[controller.selectedIndex],
        ),
      ),
    );
  }
}
