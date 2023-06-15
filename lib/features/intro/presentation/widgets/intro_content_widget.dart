import 'package:flutter/material.dart';
import 'package:posay/shared/i_colors.dart';

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
          Icon(icon, size: 140, color: IColor.secondary),
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
    return Text(desc, style: TextStyle(color: IColor.tertiary));
  }

  Widget get _appBrand {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "POS AY",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: IColor.primary,
          ),
        ),
        Text(
          "yuby",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: IColor.tertiary,
          ),
        ),
      ],
    );
  }
}
