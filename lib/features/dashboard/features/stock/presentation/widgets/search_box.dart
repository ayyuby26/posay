import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posay/features/dashboard/features/stock/presentation/bloc/stock_bloc.dart';
import 'package:posay/shared/constants/const.dart';
import 'package:posay/shared/extension.dart';
import 'package:posay/shared/i_colors.dart';

class SearchBox extends StatelessWidget {
  final searchController = TextEditingController();
  SearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Const.edgesSymmetricV8H16,
      child: TextField(
        onSubmitted: (value) {
          context.read<StockBloc>().add(StockSearching(value));
        },
        controller: searchController,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: IColor.tertiary,
          ),
          contentPadding: Const.edgesAll8,
          hintText: context.tr.searchByName,
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
          disabledBorder: OutlineInputBorder(
            borderRadius: Const.radiusCircular16,
            borderSide: BorderSide(
              color: IColor.tertiary.withOpacity(.3),
            ),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }
}
