import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_app/src/config/config.dart';
import 'package:rick_and_morty_app/src/presentation/state/home/home_provider.dart';
import 'package:rick_and_morty_app/src/presentation/widgets/widgets.dart';

/// APP HomeScreen
///
/// Here we show the different features of app
class HomeScreen extends ConsumerWidget {
  ///
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScaffold(
      backgroundColor: AppColors.backgroundVariant,
      body: ref.watch(homeStateProvider).when(
            data: (data) => FadeIn(child: const CustomScaffold()),
            error: (error, stackTrace) => ErrorWidget(error),
            loading: () => const LoadingScreen(),
          ),
    );
  }
}
