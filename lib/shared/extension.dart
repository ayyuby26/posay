import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:posay/shared/constants/const.dart';
import 'package:posay/shared/i_colors.dart';
import 'package:posay/shared/status.dart';

extension TranslateExtension on BuildContext {
  AppLocalizations get tr => AppLocalizations.of(this);

  /// current language
  Locale get localeOf => Localizations.localeOf(this);
  bool get isEn => Localizations.localeOf(this).languageCode == "en";
  String get languageCode => isEn ? 'usd' : 'rp';
}

extension Path on String {
  bool get isPathEmpty => this == "-";
}

extension HelperNeedContext on BuildContext {
  String dateStringify(DateTime dateTime) {
    final dateFormat = DateFormat.yMMMMEEEEd(isEn ? 'en_US' : 'id_ID');
    return dateFormat.format(dateTime);
  }
}

extension Snackbar on BuildContext {
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBar(
    String content,
  ) {
    final snackBar = SnackBar(content: Text(content));
    return ScaffoldMessenger.of(this).showSnackBar(snackBar);
  }
}

extension Tools on BuildContext {
  Widget get appBarHeight =>
      SizedBox(height: MediaQuery.of(this).viewPadding.top);

  void get closeSnackBar => ScaffoldMessenger.of(this).removeCurrentSnackBar();

  closeDialog() => ModalRoute.of(this)?.isCurrent != true ? pop() : null;

  void untilPop(String path) {
    if (ModalRoute.of(this)?.isCurrent != true) pop();
    while (GoRouter.of(this).location != path) {
      GoRouter.of(this).pop(true);
    }
  }
}

extension ProcessStatus on Status {
  bool get isLoading => this == Status.loading;
  bool get isFail => this == Status.error;
  bool get isSuccess => this == Status.success;
}

extension Loading on BuildContext {
  Future get loading {
    closeDialog();
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

extension Dialog on BuildContext {
  Future failure({required String content}) {
    closeDialog();
    return showDialog(
      context: this,
      builder: (context) {
        return AlertDialog(
          shape: Const.roundedCircular16,
          title: const Center(child: Text("Gagal")),
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
