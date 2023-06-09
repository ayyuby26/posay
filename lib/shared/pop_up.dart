import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:posay/shared/constants/const.dart';
import 'package:posay/shared/extension.dart';
import 'package:posay/shared/i_colors.dart';

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
    required Color foregroundColorOk,
    void Function()? onPressed,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: Const.roundedCircular16,
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
              style: TextButton.styleFrom(foregroundColor: foregroundColorOk),
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

  static Future ok({
    required String title,
    required String content,
    required BuildContext context,
  }) {
    if (context.canPop()) context.pop();
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: Const.roundedCircular16,
          title: Center(child: Text(title)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [Text(content)],
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: IColor.primary,
                ),
                onPressed: context.pop,
                child: const Text(
                  "OK",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        );
      },
    );
  }
}
