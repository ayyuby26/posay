import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:posay/features/dashboard/features/stock/presentation/pages/add_stock_page.dart';
import 'package:posay/shared/constants/const.dart';
import 'package:posay/shared/i_colors.dart';

class StockItem extends StatelessWidget {
  const StockItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            context.push(AddStockPage.path);
          },
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "Jahe Kencur",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Text(
                    "3 pcs",
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Rp 3.000"),
                  Text(
                    "EXP: 28 Jan 2020",
                    style: TextStyle(
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
