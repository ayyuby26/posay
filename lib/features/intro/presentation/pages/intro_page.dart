import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posay/color.dart';
import 'package:posay/features/intro/data/repositories/intro_repository.dart';
import 'package:posay/features/intro/presentation/bloc/intro_bloc.dart';
import 'package:posay/features/intro/presentation/widgets/intro_content_widget.dart';
import 'package:posay/features/language/presentation/pages/language_switch.dart';
import 'package:posay/injection.dart' as di;
import 'package:posay/shared/extension.dart';
import 'package:posay/shared/util.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return di.locator<IntroBloc>()
            // ..add(LoadIntroContents(appLocalizations: context.tr))
            ;
      },
      child: const _IntroPage(),
    );
  }
}

class _IntroPage extends StatefulWidget {
  const _IntroPage();

  @override
  State<_IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<_IntroPage> {
  // late IntroBloc _intro;
  final _pageController = PageController();
  final contents = di.locator<IntroRepository>();

  @override
  void initState() {
    // _intro = context.read<IntroBloc>();
    super.initState();
  }

  @override
  void dispose() {
    // _intro.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(children: [buildIntro, buildIndicator]),
            const Align(
              alignment: Alignment.topRight,
              child: LanguageSwitch(),
            )
          ],
        ),
      ),
      bottomNavigationBar: bottomBtn,
    );
  }

  Widget get buildIntro {
    return Expanded(
      child: BlocBuilder<IntroBloc, IntroState>(
        builder: (context, state) {
          return PageView(
            controller: _pageController,
            onPageChanged: (index) {
              context
                  .read<IntroBloc>()
                  .
                  // _intro.
                  add(ChangeIndexIntro(index: index));
            },
            children: contents
                .getIntroContents(context.tr)
                .map((content) => IntroContentWidget(
                      icon: content.icon,
                      desc: content.desc,
                    ))
                .toList(),
          );
        },
      ),
    );
  }

  Widget get buildIndicator {
    return BlocBuilder<IntroBloc, IntroState>(
      builder: (context, state) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: indicatorWidget(state),
        );
      },
    );
  }

  List<Widget> indicatorWidget(IntroState state) {
    return List.generate(contents.getIntroContents(context.tr).length,
        (index) => dot(index, state));
  }

  Widget dot(int index, IntroState state) {
    final count = contents.getIntroContents(context.tr).length;
    return Container(
      margin: index != count - 1 ? const EdgeInsets.only(right: 8) : null,
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: state.index == index ? color2 : color4,
        borderRadius: borderRadiusCircular8,
      ),
    );
  }

  Widget get bottomBtn {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () {
          _pageController.animateToPage(
            context
                    .read<IntroBloc>()
                    // _intro
                    .state
                    .index +
                1,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        },
        child: BlocBuilder<IntroBloc, IntroState>(
          builder: (context, state) {
            return Text(
              state.introContents.length - 1 == state.index
                  ? context.tr.finish
                  : context.tr.next,
            );
          },
        ),
      ),
    );
  }
}
