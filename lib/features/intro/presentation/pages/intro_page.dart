import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:posay/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:posay/features/intro/domain/entities/intro.dart';
import 'package:posay/features/intro/presentation/bloc/intro_bloc.dart';
import 'package:posay/features/intro/presentation/widgets/intro_content_widget.dart';
import 'package:posay/shared/constants/const.dart';
import 'package:posay/shared/extension.dart';
import 'package:posay/shared/i_colors.dart';
import 'package:posay/shared/widget_style.dart';

class IntroPage extends StatefulWidget {
  static String get path => "/intro";
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => IntroPageState();
}

class IntroPageState extends State<IntroPage> {
  final _pageController = PageController();
  late IntroBloc _introBloc;

  @override
  void initState() {
    _introBloc = context.read<IntroBloc>();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          background,
          BlocBuilder<IntroBloc, IntroState>(
            builder: (context, state) {
              return Column(children: [
                buildIntro(state.introContents),
                buildIndicator(state.introContents),
              ]);
            },
          ),
        ],
      ),
      bottomNavigationBar: nextButton,
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
              _introBloc.add(IntroChangeIndex(index: i));
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
      margin: i != contentsLength - 1 ? Const.edgesRight8 : null,
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: state.index == i ? IColor.secondary : IColor.tertiary,
        borderRadius: Const.radiusCircular8,
      ),
    );
  }

  Widget get nextButton {
    return Padding(
      padding: Const.edgesAll16,
      child: TextButton(
        style: buttonStylePrimary,
        onPressed: () async {
          final bloc = context.read<IntroBloc>();
          final index = bloc.state.index;
          final contents = bloc.state.introContents;
          final lastIntro = contents.length - 1 == index;

          if (lastIntro) {
            bloc.add(IntroSetAsSeen(contents[index]));
            bloc.stream.listen((state) {
              if (bloc.state.isIntroSeen) {
                context.pushReplacement(DashboardPage.path);
              }
            });
          } else {
            _pageController.animateToPage(
              index + 1,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          }
        },
        child: BlocBuilder<IntroBloc, IntroState>(
          builder: (context, state) {
            return Text(
              state.introContents.length - 1 == state.index
                  ? context.tr.finish
                  : context.tr.next,
              style: textStyle,
            );
          },
        ),
      ),
    );
  }
}
