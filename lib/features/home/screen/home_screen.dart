import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:one_ai/features/auth/screen/login_screen.dart';
import 'package:one_ai/features/auth/widget/google_sign_in_avatar.dart';
import 'package:one_ai/features/home/provider/home_provider.dart';
import 'package:one_ai/features/home/widget/featured_card.dart';
import 'package:one_ai/features/home/widget/home_header.dart';
import 'package:one_ai/features/home/widget/home_screen_content.dart';
import 'package:one_ai/features/home/widget/neural_network_painter.dart';
import 'package:one_ai/features/image_ai/screen/image_ai_screen.dart';
import 'package:one_ai/features/text_ai/text_ai_screen.dart';
import 'package:one_ai/utils/constant/colors.dart';
import 'dart:ui';
import 'package:provider/provider.dart';
import 'package:flutter/rendering.dart';
import 'package:one_ai/features/auth/provider/auth_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeScreenContent();
  }
}
