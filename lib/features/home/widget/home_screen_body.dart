import 'package:flutter/material.dart';
import 'package:one_ai/features/home/provider/home_provider.dart';
import 'package:one_ai/features/home/widget/feature_cards_grid.dart';
import 'package:one_ai/features/home/widget/home_header.dart';
import 'package:one_ai/features/home/widget/neural_network_painter.dart';
import 'package:one_ai/utils/constant/colors.dart';
import 'package:provider/provider.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeProvider>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.setContext(context);
    });

    return Stack(
      fit: StackFit.expand,
      children: [
        CustomPaint(
          painter: NeuralNetworkPainter(
            animation: provider.particleController,
            particleColor: AppColors.primary.withOpacity(0.15),
          ),
          size: Size.infinite,
        ),
        Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.center,
              radius: 1.5,
              colors: [
                AppColors.backgroundPrimary.withOpacity(0.2),
                AppColors.backgroundPrimary.withOpacity(0.8),
              ],
            ),
          ),
        ),
        SafeArea(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                expandedHeight: 250.0,
                floating: false,
                pinned: true,
                backgroundColor: Colors.transparent,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: const Text(
                    'OneAI\nOne Click, One Solution',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.textWhite,
                      fontSize: 12,
                      fontFamily: 'RobotoMono',
                      letterSpacing: 0.5,
                    ),
                  ),
                  background:
                      HomeHeader(pulseController: provider.pulseController),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    const FeatureCardsGrid(),
                    const SizedBox(height: 40),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
