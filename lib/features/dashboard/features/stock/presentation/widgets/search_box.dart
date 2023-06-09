import 'package:flutter/material.dart';
import 'package:posay/shared/constants/const.dart';
import 'package:posay/shared/extension.dart';
import 'package:posay/shared/i_colors.dart';

class SearchBox extends StatelessWidget {
  final bool enabled;
  final searchController = TextEditingController();
  SearchBox({this.enabled = true, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Const.edgesSymmetricV8H16,
      child: TextFormField(
        enabled: enabled,
        controller: searchController,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: IColor.tertiary,
          ),
          contentPadding: Const.edgesAll16,
          hintText: context.tr.search,
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
