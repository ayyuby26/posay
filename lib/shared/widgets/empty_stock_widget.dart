import 'package:flutter/material.dart';
import 'package:posay/shared/extension.dart';

class EmptyStockWidget extends StatelessWidget {
  const EmptyStockWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(context.tr.stocksEmpty);
  }
}
