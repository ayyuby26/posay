import 'package:flutter/material.dart';
import 'package:posay/features/intro/data/models/intro_content.dart'; 
import 'package:posay/shared/extension.dart';

abstract class IntroContentsDataSource {
  List<IntroContent> getIntroContents(BuildContext context);
}

class IntroContentsDataSourceImpl implements IntroContentsDataSource {
  @override
  List<IntroContent> getIntroContents(BuildContext context) {
    return [
      IntroContent(
        icon: Icons.storefront,
        desc: context.tr.introDesc1,
      ),
      IntroContent(
        icon: Icons.calculate_outlined,
        desc: context.tr.introDesc2,
      ),
      IntroContent(
        icon: Icons.analytics_outlined,
        desc: context.tr.introDesc3,
      ),
    ];
  }
}
