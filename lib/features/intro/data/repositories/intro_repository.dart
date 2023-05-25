import 'package:flutter/material.dart';
import 'package:posay/features/intro/data/datasources/intro_contents_data_source.dart';
import 'package:posay/features/intro/data/models/intro_content.dart';

abstract class IntroRepository {
  List<IntroContent> getIntroContents(BuildContext context);
}

class IntroRepositoryImpl implements IntroRepository {
  final IntroContentsDataSource dataSource;

  IntroRepositoryImpl({required this.dataSource});

  @override
  List<IntroContent> getIntroContents(BuildContext context) {
    return dataSource.getIntroContents(context);
  }
}
