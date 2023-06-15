import 'package:flutter/widgets.dart';
import 'package:posay/shared/i_colors.dart';

class Unfocus extends StatelessWidget {
  final Widget child;
  const Unfocus({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Stack(
        children: [
          Container(
            width: double.maxFinite,
            height: double.maxFinite,
            color: IColor.background,
          ),
          child,
        ],
      ),
    );
  }
}
