import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_app/src/domain/entities/episodes.dart';
import 'package:rick_and_morty_app/src/presentation/state/episodes/episodes_provider.dart';
import 'package:rick_and_morty_app/src/presentation/views/characters/widgets/character_card.dart';
import 'package:rick_and_morty_app/src/presentation/views/episodes/widgets/widgets.dart';
import 'package:rick_and_morty_app/src/presentation/widgets/spacers.dart';
import 'package:rick_and_morty_app/src/utils/utils/utils.dart';

/// Episodes list
///
/// Show a [CharacterCard] list for a given list of Episodes
class EpisodesList extends ConsumerWidget {
  ///
  const EpisodesList({
    super.key,
    this.controller,
    required this.episodes,
    this.enableNavigation = true,
  });

  /// ListView controller
  final ScrollController? controller;

  /// Data to show
  final List<Episode> episodes;

  /// To allow characters to be
  final bool enableNavigation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.separated(
      controller: controller,
      separatorBuilder: (context, index) => const SafeSpacer(
        height: 30,
      ),
      padding: const EdgeInsets.only(
        bottom: 20,
      ),
      itemCount: episodes.length,
      itemBuilder: (context, index) {
        return EpisodeCard(
          data: episodes[index],
          onTap: enableNavigation
              ? () {
                  ref
                      .read(episodeSelectedProvider.notifier)
                      .update((state) => state = episodes[index]);
                  Navigation.goTo(Routes.episode, context);
                }
              : null,
        );
      },
    );
  }
}
