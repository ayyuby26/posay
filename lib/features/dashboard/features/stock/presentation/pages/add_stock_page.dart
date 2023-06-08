import 'package:flutter/material.dart';
import 'package:posay/shared/constants/const.dart';
import 'package:posay/shared/i_colors.dart';
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

  final RestorableDateTime _selectedDate =
      RestorableDateTime(DateTime(2021, 7, 25));
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
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
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Selected: ${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}'),
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Stock")),
      body: Unfocus(
        child: Padding(
          padding: Const.edgesAll16,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: Const.edgesRight16,
                      child: TextFormField(
                        controller: codeController,
                        decoration: InputDecoration(
                          // prefixIcon: Icon(
                          //   Icons.qr_code_scanner,
                          //   color: IColor.tertiary,
                          // ),
                          contentPadding: Const.edgesAll16,
                          labelText: "Code",
                          focusedBorder: OutlineInputBorder(
                            borderRadius: Const.radiusCircular16,
                            borderSide: BorderSide(
                              color: IColor.tertiary.withOpacity(.3),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: Const.radiusCircular16,
                            borderSide: BorderSide(
                              color: IColor.tertiary.withOpacity(.3),
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
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
                          borderRadius: Const.radiusCircular16,
                        ),
                      ),
                      onPressed: () {},
                      child: const Icon(
                        Icons.qr_code_scanner,
                      ),
                    ),
                  ),
                ],
              ),
              Const.sizedBoxHeight16,
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
                    borderRadius: Const.radiusCircular16,
                    borderSide: BorderSide(
                      color: IColor.tertiary.withOpacity(.3),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: Const.radiusCircular16,
                    borderSide: BorderSide(
                      color: IColor.tertiary.withOpacity(.3),
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              Const.sizedBoxHeight16,
              TextFormField(
                controller: priceController,
                decoration: InputDecoration(
                  prefixIcon: const SizedBox(
                    width: 10,
                    child: Center(
                      child: Text("Rp"),
                    ),
                  ),
                  contentPadding: Const.edgesAll16,
                  labelText: "Price",
                  focusedBorder: OutlineInputBorder(
                    borderRadius: Const.radiusCircular16,
                    borderSide: BorderSide(
                      color: IColor.tertiary.withOpacity(.3),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: Const.radiusCircular16,
                    borderSide: BorderSide(
                      color: IColor.tertiary.withOpacity(.3),
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              Const.sizedBoxHeight16,
              SizedBox(
                height: 55,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: IColor.tertiary.withOpacity(.3),
                      ),
                      borderRadius: Const.radiusCircular16,
                    ),
                  ),
                  onPressed: () {
                    _restorableDatePickerRouteFuture.present();
                  },
                  child: const Text("Expired"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
