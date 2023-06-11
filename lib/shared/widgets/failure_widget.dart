import 'package:flutter/material.dart';
import 'package:posay/shared/constants/const.dart';
import 'package:posay/shared/failure.dart';

class FailureWidget extends StatelessWidget {
  final Failure failure;
  const FailureWidget({
    required this.failure,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: Const.edgesAll16,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [Text(failure.message)],
        ),
      ),
    );
  }
}
