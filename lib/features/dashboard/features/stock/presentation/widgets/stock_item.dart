import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:posay/features/dashboard/features/stock/domain/entities/stock.dart';
import 'package:posay/features/dashboard/features/stock/presentation/bloc/stock_bloc.dart';
import 'package:posay/features/dashboard/features/stock/presentation/pages/stock_manager_page.dart';
import 'package:posay/shared/constants/const.dart';
import 'package:posay/shared/extension.dart';
import 'package:posay/shared/i_colors.dart';

class StockItem extends StatelessWidget {
  final Stock stock;
  const StockItem(this.stock, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: SizedBox(
            width: double.maxFinite,
            child: TextButton(
              style: TextButton.styleFrom(
                padding: Const.edgesAll16,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: IColor.tertiary.withOpacity(.3),
                    ),
                    borderRadius: Const.radiusCircular8),
              ),
              onPressed: () {
                context.push(StockManagerPage.path);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          stock.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Text("${stock.total} ${stock.unit}"),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${currencyFormatter(stock.price, stock.currency)}"),
                      Text(
                        "EXP: ${dateStringify(stock.expired, context)}",
                        style: TextStyle(
                          color: expiredColor(stock.expired),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        BlocBuilder<StockBloc, StockState>(
          builder: (context, state) {
            if (state.stockList.last == stock) {
              if (state is StockLastPage) {
                return const SizedBox(
                  height: 77,
                );
              }
              return const Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: CupertinoActivityIndicator(),
              );
            }
            return const SizedBox();
          },
        ),
      ],
    );
  }

  Color expiredColor(DateTime? expired) {
    if (expired == null) return Colors.white;
    final now = DateTime.now();

    final today = now.isAtSameMomentAs(expired);
    final yesterday = now.isAfter(expired);
    final future = now.isBefore(expired);

    if (today) {
      return Colors.orange;
    } else if (yesterday) {
      return Colors.red;
    } else if (future) {
      return Colors.green;
    }
    return Colors.white;
  }

  currencyFormatter(double price, String currency) {
    final currencyFormatter = NumberFormat.currency(
      locale: currency == "usd" ? 'en_US' : 'ID',
      symbol: currency == "usd" ? "\$" : 'Rp',
      decimalDigits: currency == "usd" ? 2 : 0,
    );
    return currencyFormatter.format(price);
  }

  String? dateStringify(DateTime? dateTime, BuildContext context) {
    final dateFormat = DateFormat.yMMMd(context.isEn ? 'en_US' : 'id_ID');
    return dateTime == null ? "" : dateFormat.format(dateTime);
  }
}
