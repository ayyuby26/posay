import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posay/features/dashboard/features/stock/domain/entities/stock.dart';
import 'package:posay/features/dashboard/features/stock/presentation/bloc/stock_bloc.dart';
import 'package:posay/features/dashboard/features/stock/presentation/widgets/code_box.dart';
import 'package:posay/features/dashboard/features/stock/presentation/widgets/expired_box.dart';
import 'package:posay/features/dashboard/features/stock/presentation/widgets/name_box.dart';
import 'package:posay/features/dashboard/features/stock/presentation/widgets/price_box.dart';
import 'package:posay/features/dashboard/features/stock/presentation/widgets/total_box.dart';
import 'package:posay/features/dashboard/features/stock/presentation/widgets/unit_box.dart';
import 'package:posay/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:posay/shared/action.dart';
import 'package:posay/shared/helper.dart';
import 'package:posay/shared/widget_style.dart';
import 'package:posay/shared/constants/const.dart';
import 'package:posay/shared/extension.dart';
import 'package:posay/shared/unfocus.dart';

class StockManagerPage extends StatefulWidget {
  static String get _path => "/stockManager";
  static String get pathEmpty => "$_path/-";
  static String pathParam(String param) => "$_path/$param";
  static String get pathForGoRouter => "$_path/:documentId";

  const StockManagerPage(this.documentId, {super.key});
  final String documentId;

  @override
  State<StockManagerPage> createState() => _StockManagerPageState();
}

class _StockManagerPageState extends State<StockManagerPage>
    with RestorationMixin {
  late StockBloc _stockBloc;

  @override
  void initState() {
    _stockBloc = context.read<StockBloc>();
    if (!widget.documentId.isPathEmpty) {
      _stockBloc.add(StockFillEvent(widget.documentId));
    }
    super.initState();
  }

  @override
  void dispose() {
    _stockBloc.add(StockManagerResetEvent());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.documentId.isPathEmpty
            ? context.tr.stockAdd
            : context.tr.stockDetail),
      ),
      body: BlocListener<StockBloc, StockState>(
        listener: (context, state) {
          if (state.statusManagerStock.isSuccess) {
            context.untilPop(DashboardPage.path);
            context.snackBar(message(state.action));
          }

          if (state.statusManagerStock.isLoading) context.loading;
          if (state.statusManagerStock.isFail) {
            context.failure(content: state.failure.message);
          }
        },
        child: Unfocus(
          child: Padding(
            padding: Const.edgesSymmetricHorizontal16,
            child: SingleChildScrollView(
              child: _MainContent(_restorable, widget.documentId),
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
    final expiredDate = context.read<StockBloc>().state.stock?.expired;
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: expiredDate ?? DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 99999)),
        );
      },
    );
  }

  void _selectDate(DateTime? newSelectedDate) {
    final bloc = context.read<StockBloc>();
    final stock = bloc.state.stock;
    if (newSelectedDate != null) {
      if (stock != null) {
        final ss = Stock(
          documentId: stock.documentId,
          name: stock.name,
          code: stock.code,
          total: stock.total,
          unit: stock.unit,
          price: stock.price,
          stockIn: stock.stockIn,
          currency: stock.currency,
          expired: newSelectedDate,
        );
        bloc.add(StockUpdateEvent2(stock: ss));
      }
    }
  }

  @override
  String? get restorationId => "main";

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(RestorableDateTime(DateTime.now()), 'selected_date');
    registerForRestoration(_restorable, 'date_picker_route_future');
  }

  String message(ActionDo action) {
    switch (action) {
      case ActionDo.add:
        return context.tr.successAddData;
      case ActionDo.edit:
        return context.tr.successEditData;
      case ActionDo.delete:
        return context.tr.successDeleteData;
      default:
        return "";
    }
  }
}

class _MainContent extends StatelessWidget {
  final String documentId;
  final _codeController = TextEditingController();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _totalController = TextEditingController();
  final _unitController = TextEditingController();
  final _dateController = TextEditingController();
  final _dateController2 = TextEditingController();

  final RestorableRouteFuture<DateTime?> _restorable;
  _MainContent(this._restorable, this.documentId);

  @override
  Widget build(BuildContext context) {
    return BlocListener<StockBloc, StockState>(
      listener: listen,
      child: Column(
        children: [
          Const.height16,
          CodeBox(_codeController),
          Const.height16,
          NameBox(_nameController),
          Const.height16,
          BlocBuilder<StockBloc, StockState>(
            builder: (context, state) {
              return PriceBox(
                _priceController,
                currency(state, context),
                state.stock?.currency ?? "",
              );
            },
          ),
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
          _mainBtn(context),
          Const.height16,
          if (documentId.length != 1)
            Column(
              children: [
                _deleteBtn(context),
                Const.height16,
              ],
            )
        ],
      ),
    );
  }

  void listen(BuildContext context, StockState state) {
    final expired = state.stock?.expired; 
    if (expired == null) {
      _dateController.text = "";
    } else {
      _dateController.text = context.dateStringify(expired);
      _dateController2.text = expired.toIso8601String();
    }

    final stock = state.stock;
    if (stock != null) {
      _codeController.text = stock.code;
      _nameController.text = stock.name;
      _priceController.text =
          Helper.currencyDoubleToStr("${stock.price}", stock.currency);
      _totalController.text = "${stock.total}";
      _unitController.text = stock.unit;
      if (stock.expired != null) {
        _dateController.text = context.dateStringify(stock.expired!);
      }
    }
  }

  Widget _mainBtn(BuildContext context) {
    return TextButton(
      style: buttonStylePrimary,
      onPressed: () {
        if (documentId.length == 1) {
          context.read<StockBloc>().add(
                StockAddData(
                  code: _codeController.text,
                  currency: context.languageCode,
                  name: _nameController.text,
                  price: Helper.parseCurrencyByLang(
                      _priceController.text, context),
                  total: int.parse(_totalController.text),
                  unit: _unitController.text,
                ),
              );
        } else {
          final bloc = context.read<StockBloc>();
          final stock = bloc.state.stock;
          if (stock != null) {
            context.read<StockBloc>().add(
                  StockUpdateEvent(
                    expired: DateTime.parse(_dateController2.text),
                    documentId: documentId,
                    code: _codeController.text,
                    currency: stock.currency,
                    name: _nameController.text,
                    price: Helper.parseCurrency(
                      _priceController.text,
                      stock.currency,
                    ),
                    total: int.parse(_totalController.text),
                    unit: _unitController.text,
                  ),
                );
          }
        }
      },
      child: Text(
        documentId.isPathEmpty
            ? context.tr.add.toUpperCase()
            : context.tr.save.toUpperCase(),
        style: textStyle,
      ),
    );
  }

  Widget _deleteBtn(BuildContext context) {
    return TextButton(
      style: buttonStyleCancel,
      onPressed: () {
        context.okCancel(
          foregroundColorOk: Colors.red,
          title: context.tr.deleteConfirmation,
          content: context.tr.areYouSureYouWantToDelete,
          titleOk: context.tr.delete,
          onPressed: () {
            context.read<StockBloc>().add(StockDelete(documentId));
          },
        );
      },
      child: Text(
        context.tr.delete.toUpperCase(),
        style: textStyle,
      ),
    );
  }

  String currency(StockState state, BuildContext context) {
    if (documentId.length == 1) {
      return context.isEn ? "\$  " : "Rp  ";
    } else {
      final currency = adaptif(state.stock?.currency);
      return currency;
    }
  }

  adaptif(String? currency) {
    if (currency == null) return "";
    return currency == "usd" ? "\$  " : "Rp  ";
  }
}
