import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posay/color.dart';
import 'package:posay/features/intro/domain/entities/intro.dart'; 
import 'package:posay/features/intro/domain/repositories/intro_repository.dart';
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
      create: (context) => di.locator<IntroBloc>(),
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
  final _pageController = PageController();
  final _introRepository = di.locator<IntroRepository>();

  @override
  Widget build(BuildContext context) {
    final contents = _introRepository.getIntroContents(context.tr);
    return Scaffold(
      body: Stack(
        children: [
          background,
          Column(children: [
            buildIntro(contents),
            buildIndicator(contents),
          ]),
          Align(
            alignment: Alignment.topRight,
            child: LanguageSwitch(),
          ),
        ],
      ),
      bottomNavigationBar: nextButton,
    );
  }

  Widget get background {
    return Container(
      height: screenHeight / 1.8,
      foregroundDecoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            color1.withOpacity(.0),
            color1.withOpacity(.9),
          ],
        ),
      ),
      child: Image.asset(
        "assets/background.png",
        fit: BoxFit.cover,
      ),
    );
  }

  Widget buildIntro(List<Intro> contents) {
    final introList = contents
        .map((content) => IntroContentWidget(
              icon: content.icon,
              desc: content.desc,
            ))
        .toList();

    return Expanded(
      child: BlocBuilder<IntroBloc, IntroState>(
        builder: (context, state) {
          return PageView(
            controller: _pageController,
            onPageChanged: (i) {
              context.read<IntroBloc>().add(ChangeIndexIntro(index: i));
            },
            children: introList,
          );
        },
      ),
    );
  }

  Widget buildIndicator(List<Intro> contents) {
    return BlocBuilder<IntroBloc, IntroState>(
      builder: (context, state) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: indicatorWidget(state, contents.length),
        );
      },
    );
  }

  List<Widget> indicatorWidget(IntroState state, int contentsLength) {
    return List.generate(
      contentsLength,
      (i) => dot(i, state, contentsLength),
    );
  }

  Widget dot(int i, IntroState state, int contentsLength) {
    return Container(
      margin: i != contentsLength - 1 ? edgesRight8 : null,
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: state.index == i ? color2 : color4,
        borderRadius: radiusCircular8,
      ),
    );
  }

  Widget get nextButton {
    return Padding(
      padding: edgesAll16,
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: radiusCircular8,
          ),
        ),
        onPressed: () {
          _pageController.animateToPage(
            context.read<IntroBloc>().state.index + 1,
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
