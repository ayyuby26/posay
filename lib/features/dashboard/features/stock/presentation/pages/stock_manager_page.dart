import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:posay/features/dashboard/features/stock/presentation/bloc/stock_bloc.dart';
import 'package:posay/features/dashboard/features/stock/presentation/widgets/code_box.dart';
import 'package:posay/features/dashboard/features/stock/presentation/widgets/expired_box.dart';
import 'package:posay/features/dashboard/features/stock/presentation/widgets/name_box.dart';
import 'package:posay/features/dashboard/features/stock/presentation/widgets/price_box.dart';
import 'package:posay/features/dashboard/features/stock/presentation/widgets/total_box.dart';
import 'package:posay/features/dashboard/features/stock/presentation/widgets/unit_box.dart';
import 'package:posay/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:posay/shared/helper.dart';
import 'package:posay/shared/widget_style.dart';
import 'package:posay/shared/constants/const.dart';
import 'package:posay/shared/extension.dart';
import 'package:posay/shared/unfocus.dart';

class StockManagerPage extends StatefulWidget {
  static String get path => "/stockManager";
  const StockManagerPage({super.key});

  @override
  State<StockManagerPage> createState() => _StockManagerPageState();
}

class _StockManagerPageState extends State<StockManagerPage>
    with RestorationMixin {
  final _codeController = TextEditingController();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _dateController = TextEditingController();
  final _totalController = TextEditingController();
  final _unitController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<StockBloc, StockState>(
      listener: (context, state) {
        if (state is StockAddSuccess) {
          context.pop();

          while (GoRouter.of(context).location != DashboardPage.path) {
            debugPrint(GoRouter.of(context)
                .location
                .toString()); //to get the routes in between
            GoRouter.of(context).pop(true);
          }

          const snackBar = SnackBar(
            content: Text('Yay! Berhasil Tambah Stock'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }

        if (state is StockDataLoading) context.loading;
      },
      child: WillPopScope(
        onWillPop: () {
          context
              .read<StockBloc>()
              .add(const StockUpdateExpired(expired: null));
          return Future.value(true);
        },
        child: Scaffold(
          appBar: AppBar(title: Text(context.tr.stockAdd)),
          body: Unfocus(
            child: Padding(
              padding: Const.edgesAll16,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CodeBox(_codeController),
                    Const.height16,
                    NameBox(_nameController),
                    Const.height16,
                    PriceBox(_priceController),
                    Const.height16,
                    Row(
                      children: [
                        Expanded(child: TotalBox(_totalController)),
                        Const.width16,
                        Expanded(child: UnitBox(_unitController)),
                      ],
                    ),
                    Const.height16,
                    ExpiredBox(_dateController, _restorable),
                    Const.height16,
                    TextButton(
                      style: buttonStylePrimary,
                      onPressed: () {
                        context.read<StockBloc>().add(
                              StockAddData(
                                code: _codeController.text,
                                currency: context.isEn ? "usd" : 'rp',
                                name: _nameController.text,
                                price: Helper.dotRemover(
                                  _priceController.text,
                                  context.isEn ? "usd" : 'rp',
                                ),
                                total: int.parse(_totalController.text),
                                unit: _unitController.text,
                              ),
                            );
                      },
                      child: Text(
                        context.tr.add.toUpperCase(),
                        style: textStyle,
                      ),
                    ),
                    Const.height16,
                    TextButton(
                      style: buttonStyleCancel,
                      onPressed: () {
                        context.okCancel(
                          foregroundColorOk: Colors.red,
                          title: context.tr.deleteConfirmation,
                          content: context.tr.areYouSureYouWantToDelete,
                          titleOk: context.tr.delete,
                          onPressed: () {
                            // context.read<AuthBloc>().add(AuthLogout(context));
                          },
                        );
                      },
                      child: Text(
                        context.tr.delete.toUpperCase(),
                        style: textStyle,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  late final _restorable = RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(_datePickerRoute);
    },
  );

  @pragma('vm:entry-point')
  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    final expired = context.read<StockBloc>().state.expired;
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate:
              DateTime.fromMillisecondsSinceEpoch(expired) ?? DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 99999)),
        );
      },
    );
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      context
          .read<StockBloc>()
          .add(StockUpdateExpired(expired: newSelectedDate));
      _dateController.text = dateStringify(newSelectedDate);
    }
  }

  String dateStringify(DateTime dateTime) {
    final dateFormat = DateFormat.yMMMMEEEEd(context.isEn ? 'en_US' : 'id_ID');
    return dateFormat.format(dateTime);
  }

  @override
  String? get restorationId => "main";

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(RestorableDateTime(DateTime.now()), 'selected_date');
    registerForRestoration(_restorable, 'date_picker_route_future');
  }
}
