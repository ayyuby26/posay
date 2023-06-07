import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:posay/shared/extension.dart';

class PopUp {
  static PopUp? _instance;

  factory PopUp() {
    _instance ??= PopUp._();
    return _instance!;
  }

  PopUp._();

  static Future okCancel({
    required String title,
    required String content,
    required String titleOk,
    required BuildContext context,
    required Color ForegroundColorOk,
    void Function()? onPressed,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(child: Text(title)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [Text(content)],
          ),
          actions: [
            TextButton(
              onPressed: context.pop,
              child: Text(context.tr.cancel),
            ),
            TextButton(
              style: TextButton.styleFrom(foregroundColor: ForegroundColorOk),
              onPressed: onPressed,
              child: Text(
                titleOk,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
