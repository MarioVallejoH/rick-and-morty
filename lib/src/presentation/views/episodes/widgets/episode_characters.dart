import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_app/src/config/config.dart';
import 'package:rick_and_morty_app/src/presentation/state/episodes/episodes_provider.dart';
import 'package:rick_and_morty_app/src/presentation/views/characters/widgets/characters_list.dart';
import 'package:rick_and_morty_app/src/presentation/widgets/circular_progress_indicator.dart';
import 'package:rick_and_morty_app/src/presentation/widgets/spacers.dart';

/// Episode characters list
class EpisodeCharacters extends ConsumerWidget {
  ///
  const EpisodeCharacters({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final appLocalizations = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          appLocalizations?.charactersList ?? '',
          style: textTheme.headlineSmall?.copyWith(
            fontSize: 18,
          ),
        ),
        const SafeSpacer(),
        ref.watch(episodeFetchProvider).when(
              data: (data) {
                return Expanded(
                  child: CharactersList(characters: data!.characters!),
                );
              },
              error: (error, stackTrace) => ErrorWidget(error),
              loading: () =>
                  const Center(child: SizedCustomProgressIndicator2()),
            ),
      ],
    );
  }
}
