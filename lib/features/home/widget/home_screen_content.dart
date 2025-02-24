import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:one_ai/features/home/provider/home_provider.dart';
import 'package:one_ai/features/home/widget/custom_gradient_app_bar.dart';
import 'package:one_ai/features/home/widget/home_screen_body.dart';
import 'package:one_ai/utils/constant/colors.dart';
import 'package:provider/provider.dart';

class HomeScreenContent extends StatefulWidget {
  const HomeScreenContent({super.key});

  @override
  State<HomeScreenContent> createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<HomeScreenContent>
    with TickerProviderStateMixin {
  late final HomeProvider _provider;

  @override
  void initState() {
    super.initState();
    _provider = HomeProvider(vsync: this);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  @override
  void dispose() {
    _provider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _provider,
      child: Scaffold(
        appBar: CustomGradientAppBar(),
        backgroundColor: AppColors.secondary.withOpacity(0.5),
        body: const HomeScreenBody(),
      ),
    );
  }
}