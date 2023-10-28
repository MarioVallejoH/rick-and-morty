import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_app/src/config/config.dart';
import 'package:rick_and_morty_app/src/presentation/state/home/home_provider.dart';
import 'package:rick_and_morty_app/src/utils/constants/sizes.dart';
import 'package:rick_and_morty_app/src/utils/utils/utils.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

/// Home screen bottom navigation bar
///
/// Manage its state through Riperpod providers
class HomeNavBar extends ConsumerWidget {
  ///
  const HomeNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final appLocations = AppLocalizations.of(context);
    final responsive = GlobalLocator.responsiveDesign;
    return SalomonBottomBar(
      backgroundColor: colors.onPrimary,
      selectedColorOpacity: 0.1,
      margin: EdgeInsets.symmetric(
        horizontal: responsive.width(AppSizes.bodyDefaultHPadding),
        vertical: responsive.maxHeightValue(16),
      ),
      currentIndex: ref.watch(homeBottomBarProvider),
      onTap: (i) =>
          ref.read(homeBottomBarProvider.notifier).update((state) => state = i),
      items: [
        /// Search
        SalomonBottomBarItem(
          icon: const Icon(Icons.people_alt_rounded),
          title: Text(appLocations?.characters ?? 'Characters'),
          selectedColor: const Color.fromARGB(255, 187, 78, 44),
        ),

        /// Likes
        SalomonBottomBarItem(
          icon: const Icon(Icons.location_on_rounded),
          title: Text(appLocations?.locations ?? 'Locations'),
          selectedColor: const Color.fromARGB(255, 46, 104, 48),
        ),

        /// Likes
        SalomonBottomBarItem(
          icon: const Icon(Icons.bookmarks_rounded),
          title: Text(appLocations?.episodes ?? 'Episodes'),
          selectedColor: const Color.fromARGB(255, 24, 106, 173),
        ),

        /// Likes
        SalomonBottomBarItem(
          icon: const Icon(Icons.settings_rounded),
          title: Text(appLocations?.settings ?? 'Settings'),
          selectedColor: const Color.fromARGB(255, 123, 31, 139),
        ),
      ],
    );
  }
}
