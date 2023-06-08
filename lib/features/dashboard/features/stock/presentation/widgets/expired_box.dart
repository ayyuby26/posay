import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:posay/shared/extension.dart';
import 'package:posay/shared/widget_style.dart';
import 'package:posay/shared/constants/const.dart';
import 'package:posay/shared/currency_input_formatter.dart';

class ExpiredBox extends StatelessWidget {
  final TextEditingController dateController;
  final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture;
  const ExpiredBox(this.dateController, this._restorableDatePickerRouteFuture,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Stack(
            children: [
              TextFormField(
                style: const TextStyle(color: Colors.black),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CurrencyInputFormatter(context),
                ],
                controller: dateController,
                decoration: InputDecoration(
                  contentPadding: Const.edgesAll16,
                  labelText: context.tr.expiredDate,
                  focusedBorder: borderStyleLeft,
                  enabledBorder: borderStyleLeft,
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              GestureDetector(
                onTap: () => _restorableDatePickerRouteFuture.present(),
                child: Container(
                  width: double.maxFinite,
                  height: 55,
                  color: Colors.transparent,
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 55,
          child: TextButton(
            style: textBtnStyle,
            onPressed: _restorableDatePickerRouteFuture.present,
            child: const Icon(Icons.date_range_rounded),
          ),
        ),
      ],
    );
  }
}
