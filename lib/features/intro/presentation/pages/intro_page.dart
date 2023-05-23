import 'package:posay/color.dart';
import 'package:posay/features/intro/presentation/widgets/content.dart';
import 'package:posay/shared/extension.dart';
import 'package:posay/shared/util.dart';
import 'package:flutter/material.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final pageController = PageController();
  int currPage = 0;

  List<Content> data(BuildContext context) { 
    return [
      Content(
        icon: Icons.storefront,
        desc: context.tr.introScreen1,
      ),
      Content(
        icon: Icons.calculate_outlined,
        desc: context.tr.introScreen2,
      ),
      Content(
        icon: Icons.analytics_outlined,
        desc: context.tr.introScreen3,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              onPageChanged: (val) => setState(() => currPage = val),
              controller: pageController,
              children: data(context),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: data(context).asMap().entries.map((e) => dot(e)).toList(),
          )
        ],
      ),
      bottomNavigationBar: bottomWidget(),
    );
  }

  Widget dot(MapEntry<int, Content> e) {
    return Container(
      margin: e.key != data(context).length - 1
          ? const EdgeInsets.only(right: 8)
          : null,
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: currPage == e.key ? color2 : color4,
        borderRadius: borderRadiusCircular8,
      ),
    );
  }

  Widget bottomWidget() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextButton(
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () {
            pageController.animateToPage(
              pageController.page!.toInt() + 1,
              duration: const Duration(milliseconds: 500),
              curve: Curves.ease,
            );
          },
          child: Text(
            (data(context).length - 1) == currPage
                ? context.tr.finish
                : context.tr.next,
            style: const TextStyle(fontFamily: 'Lato'),
          )
          // .tr(),
          ),
    );
  }
}
