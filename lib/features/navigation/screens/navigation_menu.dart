import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dashscan/features/navigation/providers/navigation_provider.dart';
import 'package:dashscan/features/scan/providers/scan_screen_state.dart';
import 'package:dashscan/utils/constants/colors.dart';
import 'package:dashscan/utils/constants/image_strings.dart';

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
          backgroundColor: AppColors.primary,
          child: const Padding(
            padding: EdgeInsets.all(10.0),
            child: Image(image: AssetImage(AppImages.appLogo)),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: Consumer<NavigationProvider>(
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
            backgroundColor: const Color(0xffe7ebee),
            activeIndex: controller.selectedIndex,
            splashColor: AppColors.primary,
            splashSpeedInMilliseconds: 300,
            notchSmoothness: NotchSmoothness.defaultEdge,
            leftCornerRadius: 32,
            rightCornerRadius: 32,
            gapLocation: GapLocation.center,
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
