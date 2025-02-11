import 'package:flutter/material.dart';
import 'package:glowy_borders/glowy_borders.dart';

class GenerateCard extends StatefulWidget {
  final IconData icon;
  final String text;

  const GenerateCard({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  State<GenerateCard> createState() => _GenerateCardState();
}

class _GenerateCardState extends State<GenerateCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xff0F826B), Color(0xff014348)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        children: [
          Flexible(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  widget.text,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w300,
                      fontFamily: 'RobotoMono'),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10.0, right: 12),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Icon(
                  widget.icon,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
