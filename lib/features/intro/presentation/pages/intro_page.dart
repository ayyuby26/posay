import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:posay/features/intro/domain/entities/intro.dart';
import 'package:posay/features/intro/domain/repositories/intro_repository.dart';
import 'package:posay/features/intro/presentation/bloc/intro_bloc.dart';
import 'package:posay/features/intro/presentation/widgets/intro_content_widget.dart';
import 'package:posay/features/language/presentation/pages/language_switch.dart';
import 'package:posay/injection.dart';
import 'package:posay/shared/constants/constants.dart';
import 'package:posay/shared/extension.dart';
import 'package:posay/shared/i_colors.dart';

class IntroPage extends StatelessWidget {
  static String get path => "/intro";
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          Injection().locator<IntroBloc>()..add(GetIntroListEvent(context.tr)),
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
  final Constants _constant = Injection().locator<Constants>();
  final _pageController = PageController();
  final _introRepository = Injection().locator<IntroRepository>();

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
      height: _constant.screenSize.height / 1.8,
      foregroundDecoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Injection().locator<IColor>().background.withOpacity(.0),
            Injection().locator<IColor>().background.withOpacity(.9),
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
      margin: i != contentsLength - 1 ? _constant.edgesRight8 : null,
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: state.index == i ? IColor().secondary : IColor().tertiary,
        borderRadius: _constant.radiusCircular8,
      ),
    );
  }

  Widget get nextButton {
    return Padding(
      padding: _constant.edgesAll16,
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: _constant.radiusCircular8,
          ),
        ),
        onPressed: () async {
          final currIndex = context.read<IntroBloc>().state.index;

          final contents = _introRepository.getIntroContents(context.tr);
          if ((contents.length - 1) == currIndex) {
            Injection()
                .locator<IntroRepository>()
                .saveIntro(contents.first.toModel);
            context.replace(IntroPage.path);
          } else {
            _pageController.animateToPage(
              currIndex + 1,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          }
        },
        child:
            // const Text("data")
            BlocBuilder<IntroBloc, IntroState>(
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
