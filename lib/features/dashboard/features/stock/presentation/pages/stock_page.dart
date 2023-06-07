import 'package:flutter/material.dart';
import 'package:posay/shared/constants/const.dart';
import 'package:posay/shared/extension.dart';
import 'package:posay/shared/i_colors.dart';
import 'package:posay/shared/unfocus.dart';

class StockPage extends StatefulWidget {
  const StockPage({super.key});

  @override
  State<StockPage> createState() => StockPageState();
}

class StockPageState extends State<StockPage> {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: Unfocus(
        child: Column(
          children: [
            SizedBox(height: context.appBarHeight),
            Padding(
              padding: Const.edgesSymmetricV8H16,
              child: TextFormField(
                controller: searchController,
                decoration: InputDecoration(
                  contentPadding: Const.edgesAll16,
                  labelText: context.tr.finish,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: Const.radiusCircular16,
                    borderSide:
                        BorderSide(color: IColor.tertiary.withOpacity(.3)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: Const.radiusCircular16,
                    borderSide:
                        BorderSide(color: IColor.tertiary.withOpacity(.3)),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            const Center(
              child: Text("Stock Page"),
            ),
          ],
        ),
      ),
    );
  }
}
