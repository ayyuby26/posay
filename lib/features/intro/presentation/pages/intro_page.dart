import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posay/color.dart';
import 'package:posay/features/intro/data/models/intro_content.dart';
import 'package:posay/features/intro/data/repositories/intro_repository.dart';
import 'package:posay/features/intro/presentation/bloc/intro_bloc.dart';
import 'package:posay/features/intro/presentation/widgets/intro_content_widget.dart';
import 'package:posay/injection.dart' as di;
import 'package:posay/shared/extension.dart';
import 'package:posay/shared/util.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  void dispose() {
    context.read<IntroBloc>().close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          IntroBloc(introRepository: di.locator<IntroRepository>())
            ..add(LoadIntroContents(context: context)),
      child: Scaffold(
        body: BlocBuilder<IntroBloc, IntroState>(
          builder: (context, state) {
            if (state is IntroLoaded || state is IntroIndexChanged) {
              return buildIntroPageView(context, state.introContents);
            } else if (state is IntroError) {
              return Center(
                child: Text('Error: ${state.error.message}'),
              );
            } else {
              return Container();
            }
          },
        ),
        bottomNavigationBar: bottomWidget(),
      ),
    );
  }

  Widget buildIntroPageView(
      BuildContext context, List<IntroContent> introContents) {
    return Column(
      children: [
        Expanded(
          child: PageView(
            onPageChanged: (index) {
              context.read<IntroBloc>().add(ChangeIndexIntro(index: index));
            },
            children: introContents
                .map((content) => IntroContentWidget(
                      icon: content.icon,
                      desc: content.desc,
                    ))
                .toList(),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: indicatorWidget(introContents.length),
        ),
      ],
    );
  }

  List<Widget> indicatorWidget(int count) {
    return List.generate(count, (index) => dot(index, count));
  }

  Widget dot(int index, int count) {
    return BlocBuilder<IntroBloc, IntroState>(
      builder: (context, state) {
        return Container(
          margin: index != count - 1 ? const EdgeInsets.only(right: 8) : null,
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: state is IntroIndexChanged
                ? state.index == index
                    ? color2
                    : color4
                : color4,
            borderRadius: borderRadiusCircular8,
          ),
        );
      },
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
          // Handle button pressed
        },
        child: BlocBuilder<IntroBloc, IntroState>(
          builder: (context, state) {
            return Text(
              state is IntroIndexChanged
                  ? (state.introContents.length - 1) == state.index
                      ? context.tr.finish
                      : context.tr.next
                  : context.tr.next,
            );
          },
        ),
      ),
    );
  }
}
