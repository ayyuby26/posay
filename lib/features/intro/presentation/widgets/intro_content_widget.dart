import 'package:flutter/material.dart';
import 'package:posay/color.dart';

class IntroContentWidget extends StatelessWidget {
  final IconData icon;
  final String desc;

  const IntroContentWidget({
    Key? key,
    required this.icon,
    required this.desc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(icon, size: 140, color: color2),
          Column(
            children: [
              const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "POS AY",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: color3,
                    ),
                  ),
                  Text(
                    "yuby",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: color4,
                    ),
                  ),
                ],
              ),
              Text(desc, style: const TextStyle(color: color4)),
            ],
          ),
        ],
      ),
    );
  }
}
