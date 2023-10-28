import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_app/src/config/config.dart';
import 'package:rick_and_morty_app/src/presentation/screens.dart';
import 'package:rick_and_morty_app/src/presentation/state/home/home_provider.dart';
import 'package:rick_and_morty_app/src/presentation/views/home/widgets/widgets.dart';
import 'package:rick_and_morty_app/src/presentation/widgets/widgets.dart';
import 'package:rick_and_morty_app/src/utils/utils/utils.dart';

/// APP HomeScreen
///
/// Here we show the different features of app
class HomeScreen extends ConsumerWidget {
  ///
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pages = [
      CustomScaffold(
        backgroundColor: AppColors.backgroundVariant,
        body: ColumnWithPadding(
          children: [
            const HeaderSpacer(),
            IconButton(
              color: Colors.white,
              onPressed: () {
                Navigation.goTo(Routes.episodes, context);
              },
              icon: const Icon(Icons.photo_album_outlined),
            ),
          ],
        ),
      ),
      const CharactersScreen(),
      const CustomScaffold(),
      const EpisodesScreen(),
      const CustomScaffold(),
    ];
    return ref.watch(homeStateProvider).when(
          data: (data) {
            final index = ref.watch(homeBottomBarProvider);
            return CustomScaffold(
              backgroundColor: AppColors.backgroundVariant,
              bottomNavigationBar: const HomeNavBar(),
              body: FadeIn(
                key: UniqueKey(),
                child: pages[index],
              ),
            );
          },
          error: (error, stackTrace) => ErrorWidget(error),
          loading: () => const LoadingScreen(),
        );
  }
}
