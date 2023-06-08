import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:posay/shared/failure.dart';
import 'package:posay/shared/i_colors.dart';

extension TranslateExtension on BuildContext {
  AppLocalizations get tr => AppLocalizations.of(this);

  /// current language
  Locale get localeOf => Localizations.localeOf(this);
  bool get isEn => Localizations.localeOf(this).languageCode == "en";
}

extension Tools on BuildContext {
  double get appBarHeight => MediaQuery.of(this).viewPadding.top;
}

extension Loading on BuildContext {
  get loading {
    showDialog(
      context: this,
      builder: (context) {
        return const AlertDialog(content: CupertinoActivityIndicator());
      },
    );
  }
}

extension ShowDialog on BuildContext {
  okCancel({
    required String title,
    required String content,
    required String titleOk,
    required void Function(BuildContext) onPress,
  }) {
    return (
      showDialog(
        context: this,
        builder: (context1) {
          return AlertDialog(
            title: Center(child: Text(title)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [Text(content)],
            ),
            actions: [
              TextButton(
                onPressed: pop,
                child: Text(tr.cancel),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.red,
                ),
                onPressed: () => onPress(this),
                child: Text(
                  titleOk,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  dialogError(Failure failure) {
    return showDialog(
      context: this,
      builder: (context) {
        return AlertDialog(
          title: const Center(child: Text("Oops")),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [Text(failure.message)],
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            SizedBox(
              width: double.maxFinite,
              child: TextButton(
                  style:
                      TextButton.styleFrom(backgroundColor: IColor.secondary),
                  onPressed: pop,
                  child: const Text(
                    "OK",
                    style: TextStyle(color: Colors.white),
                  )),
            )
          ],
        );
      },
    );
  }
}
