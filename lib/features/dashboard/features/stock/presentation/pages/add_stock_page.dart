import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:intl/intl.dart';
import 'package:posay/shared/constants/const.dart';
import 'package:posay/shared/extension.dart';
import 'package:posay/shared/i_colors.dart';
import 'package:posay/shared/pop_up.dart';
import 'package:posay/shared/unfocus.dart';

class AddStockPage extends StatefulWidget {
  static String get path => "/addStock";
  const AddStockPage({super.key});

  @override
  State<AddStockPage> createState() => _AddStockPageState();
}

class _AddStockPageState extends State<AddStockPage> with RestorationMixin {
  final codeController = TextEditingController();
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final dateController = TextEditingController();
  final dateFocusNode = FocusNode();
  final noteController = TextEditingController();

  final _selectedDate = RestorableDateTime(DateTime(2021, 7, 25));

  late final _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  @pragma('vm:entry-point')
  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(2021),
          lastDate: DateTime(2022),
        );
      },
    );
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        dateController.text = dateAtur(_selectedDate.value);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Stock/Stock Detail")),
      body: Unfocus(
        child: Padding(
          padding: Const.edgesAll16,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp("[a-zA-Z0-9]"),
                        )
                      ],
                      controller: codeController,
                      decoration: InputDecoration(
                        // prefixIcon: Icon(
                        //   Icons.qr_code_scanner,
                        //   color: IColor.tertiary,
                        // ),
                        contentPadding: Const.edgesAll16,
                        labelText: "Code",
                        focusedBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(8),
                          ),
                          borderSide: BorderSide(
                            color: IColor.tertiary.withOpacity(.3),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(8),
                          ),
                          borderSide: BorderSide(
                            color: IColor.tertiary.withOpacity(.3),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 55,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: IColor.tertiary.withOpacity(.3),
                          ),
                          borderRadius: const BorderRadius.horizontal(
                            right: Radius.circular(8),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        String barcodeScanRes =
                            await FlutterBarcodeScanner.scanBarcode(
                          "#ff6666",
                          context.tr.cancel,
                          true,
                          ScanMode.BARCODE,
                        );
                        codeController.text = barcodeScanRes;
                      },
                      child: const Icon(
                        Icons.qr_code_scanner,
                      ),
                    ),
                  ),
                ],
              ),
              Const.height16,
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  // prefixIcon: Icon(
                  //   Icons.qr_code_scanner,
                  //   color: IColor.tertiary,
                  // ),
                  contentPadding: Const.edgesAll16,
                  labelText: "Name",
                  focusedBorder: OutlineInputBorder(
                    borderRadius: Const.radiusCircular8,
                    borderSide: BorderSide(
                      color: IColor.tertiary.withOpacity(.3),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: Const.radiusCircular8,
                    borderSide: BorderSide(
                      color: IColor.tertiary.withOpacity(.3),
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              Const.height16,
              TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CurrencyInputFormatter(context),
                ],
                controller: priceController,
                decoration: InputDecoration(
                  prefixIcon: SizedBox(
                    width: 1,
                    child: Center(
                      child: Text(context.isEn ? "\$" : "Rp"),
                    ),
                  ),
                  contentPadding: Const.edgesAll16,
                  labelText: "Price",
                  focusedBorder: OutlineInputBorder(
                    borderRadius: Const.radiusCircular8,
                    borderSide: BorderSide(
                      color: IColor.tertiary.withOpacity(.3),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: Const.radiusCircular8,
                    borderSide: BorderSide(
                      color: IColor.tertiary.withOpacity(.3),
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              Const.height16,
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      focusNode: dateFocusNode,
                      onTap: () {
                        dateFocusNode.unfocus();
                        _restorableDatePickerRouteFuture.present();
                      },
                      style: const TextStyle(color: Colors.black),
                      // enabled: false,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CurrencyInputFormatter(context),
                      ],
                      controller: dateController,
                      decoration: InputDecoration(
                        contentPadding: Const.edgesAll16,
                        labelText: "Expired Date",
                        focusedBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(8),
                          ),
                          borderSide: BorderSide(
                            style: BorderStyle.solid,
                            color: IColor.tertiary.withOpacity(.3),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(8),
                          ),
                          borderSide: BorderSide(
                            color: IColor.tertiary.withOpacity(.3),
                          ),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(8),
                          ),
                          borderSide: BorderSide(
                            color: IColor.tertiary.withOpacity(.3),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 55,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: IColor.tertiary.withOpacity(.3),
                          ),
                          borderRadius: const BorderRadius.horizontal(
                            right: Radius.circular(8),
                          ),
                        ),
                      ),
                      onPressed: () {
                        _restorableDatePickerRouteFuture.present();
                      },
                      child: const Icon(
                        Icons.date_range_rounded,
                      ),
                    ),
                  ),
                ],
              ),
              Const.height16,
              SizedBox(
                width: Const.screenSize.width,
                height: 55,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: IColor.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: Const.radiusCircular8,
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "ADD/SAVE",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Const.height16,
              SizedBox(
                width: Const.screenSize.width,
                height: 55,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.red[700],
                    shape: RoundedRectangleBorder(
                      borderRadius: Const.radiusCircular8,
                    ),
                  ),
                  onPressed: () {
                    PopUp.okCancel(
                      foregroundColorOk: Colors.red,
                      context: context,
                      title: "Konfirmasi Hapus",
                      content: "Yakin Ingin Menghapus",
                      titleOk: "Hapus",
                      onPressed: () {
                        // context.read<AuthBloc>().add(AuthLogout(context));
                      },
                    );
                  },
                  child: const Text(
                    "DELETE",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  dateAtur(DateTime dateTime) {
    final DateFormat dateFormat =
        DateFormat.yMMMMEEEEd(context.isEn ? 'en_US' : 'id_ID');

    return dateFormat.format(dateTime);
  }

  @override
  String? get restorationId => "main";

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }
}

class CurrencyInputFormatter extends TextInputFormatter {
  final BuildContext context;

  CurrencyInputFormatter(this.context);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    double value = double.parse(newValue.text);

    final formatter = NumberFormat.currency(
      locale: context.isEn ? 'en_US' : 'id_ID',
      decimalDigits: context.isEn ? 2 : 0,
      symbol: "",
    );

    String newText = formatter.format(context.isEn ? value / 100 : value);

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
