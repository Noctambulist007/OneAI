import 'package:flutter/material.dart';
import 'package:one_ai/features/text_ai/widget/glass_container.dart';

class GlassTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int? maxLines;
  final double? height;
  final ValueChanged<String>? onChanged;
  final bool readOnly;

  const GlassTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.maxLines,
    this.height,
    this.onChanged,
    this.readOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      child: SizedBox(
        height: height,
        child: TextField(
          controller: controller,
          style: TextStyle(
            color: Colors.white.withOpacity(0.9),
            fontSize: 16,
            height: 1.5,
          ),
          maxLines: maxLines,
          readOnly: readOnly,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.white.withOpacity(0.3),
              fontSize: 16,
            ),
            contentPadding: const EdgeInsets.all(20),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
