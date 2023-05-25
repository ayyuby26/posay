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
              _appBrand,
              _introDescription,
            ],
          ),
        ],
      ),
    );
  }

  Widget get _introDescription {
    return Text(desc, style: const TextStyle(color: color4));
  }

  Widget get _appBrand {
    return const Row(
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
    );
  }
}
