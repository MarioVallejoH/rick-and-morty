import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_app/src/presentation/state/episodes/episodes_provider.dart';
import 'package:rick_and_morty_app/src/presentation/views/episodes/widgets/episodes_list.dart';
import 'package:rick_and_morty_app/src/presentation/widgets/widgets.dart';
import 'package:rick_and_morty_app/src/utils/utils/utils.dart';

/// Episodes Screen
///
/// Fetch and search Rick and Morty episodes by name and other filtering
class EpisodesScreen extends ConsumerWidget {
  ///
  const EpisodesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScaffold(
      body: ColumnWithPadding(
        children: [
          CustomAppBar(
            title: 'Episodes List',
            onBack: () {
              ref.invalidate(episodesProvider);
              ref.invalidate(episodesFetchProvider);
              Navigation.goBack(context);
            },
          ),
          const Expanded(
            child: EpisodesList(),
          ),
        ],
      ),
    );
  }
}
