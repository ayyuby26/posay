import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:posay/shared/constants/const.dart';
import 'package:posay/shared/i_colors.dart';

extension TranslateExtension on BuildContext {
  AppLocalizations get tr => AppLocalizations.of(this);

  /// current language
  Locale get localeOf => Localizations.localeOf(this);
  bool get isEn => Localizations.localeOf(this).languageCode == "en";
}

extension Tools on BuildContext {
  double get appBarHeight => MediaQuery.of(this).viewPadding.top;
  void get closeSnackBar => ScaffoldMessenger.of(this).removeCurrentSnackBar();
  closeDialog() => ModalRoute.of(this)?.isCurrent != true ? pop() : null;
}

extension Loading on BuildContext {
  Future get loading {
    return showDialog(
      barrierDismissible: false,
      context: this,
      builder: (context) {
        return AlertDialog(
          shape: Const.roundedCircular16,
          content: const SizedBox(
            width: 100,
            height: 100,
            child: CupertinoActivityIndicator(),
          ),
        );
      },
    );
  }
}

extension Ok on BuildContext {
  Future ok({
    required String title,
    required String content,
  }) {
    if (ModalRoute.of(this)?.isCurrent != true) pop();
    return showDialog(
      context: this,
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

extension OkCancel on BuildContext {
  Future okCancel({
    required String title,
    required String content,
    required String titleOk,
    required Color foregroundColorOk,
    void Function()? onPressed,
  }) {
    if (ModalRoute.of(this)?.isCurrent != true) pop();
    return showDialog(
      context: this,
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
}
