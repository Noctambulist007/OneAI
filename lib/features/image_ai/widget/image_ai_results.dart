import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'dart:ui';

class ImageAiResults extends StatelessWidget {
  final bool isLoading;
  final bool hasResults;
  final Map<String, String> results;
  final Function(String) onCopy;

  const ImageAiResults({
    super.key,
    required this.isLoading,
    required this.hasResults,
    required this.results,
    required this.onCopy,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(
        child: Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.black.withOpacity(0.2),
          ),
          child: Lottie.asset(
            'assets/animations/loading.json',
            height: 100,
            width: 100,
          ),
        ),
      );
    }

    if (!hasResults) {
      return const SizedBox.shrink();
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.1),
                Colors.white.withOpacity(0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1.5,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: results.entries.map((entry) {
              return _buildResultSection(
                entry.key,
                entry.value,
                () => onCopy(entry.value),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildResultSection(
    String title,
    String content,
    VoidCallback onCopy,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
            _buildGlassIconButton(Icons.copy, onCopy),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildGlassIconButton(IconData icon, VoidCallback? onPressed) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.15),
                  Colors.white.withOpacity(0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: IconButton(
              icon: Icon(icon, color: Colors.white.withOpacity(0.9), size: 20),
              onPressed: onPressed,
            ),
          ),
        ),
      ),
    );
  }
} 