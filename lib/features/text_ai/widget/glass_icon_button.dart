import 'package:flutter/material.dart';
import 'package:one_ai/features/text_ai/widget/glass_container.dart';

class GlassIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final double? size;
  final Color? color;

  const GlassIconButton({
    Key? key,
    required this.icon,
    required this.onTap,
    this.size,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: GlassContainer(
        padding: const EdgeInsets.all(8),
        borderRadius: BorderRadius.circular(12),
        child: Icon(
          icon,
          color: color ?? Colors.white.withOpacity(0.9),
          size: size ?? 20,
        ),
      ),
    );
  }
}
