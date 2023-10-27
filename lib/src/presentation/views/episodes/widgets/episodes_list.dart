import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_app/src/presentation/state/episodes/episodes_provider.dart';
import 'package:rick_and_morty_app/src/presentation/views/episodes/widgets/episode_card.dart';
import 'package:rick_and_morty_app/src/presentation/widgets/circular_progress_indicator.dart';
import 'package:rick_and_morty_app/src/presentation/widgets/widgets.dart';

/// Episodes list
///
/// Shows a list of episodes on [EpisodeCard]
class EpisodesList extends ConsumerStatefulWidget {
  ///
  const EpisodesList({
    super.key,
  });

  @override
  ConsumerState<EpisodesList> createState() => _EpisodesListState();
}

class _EpisodesListState extends ConsumerState<EpisodesList> {
  /// ListView ScrollController
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final episodes = ref.watch(episodesProvider);
    return Column(
      children: [
        if (episodes != null)
          Expanded(
            child: ListView.separated(
              controller: scrollController,
              separatorBuilder: (context, index) => const SafeSpacer(
                height: 16,
              ),
              padding: EdgeInsets.zero,
              itemCount: episodes.episodes.length,
              itemBuilder: (context, index) {
                return EpisodeCard(data: episodes.episodes[index]);
              },
            ),
          ),
        ref.watch(episodesFetchProvider).when(
              data: (data) {
                if (episodes == null) {
                  Future.delayed(
                    Duration.zero,
                    () => ref
                        .read(episodesProvider.notifier)
                        .update((state) => state = data),
                  );
                }
                return const SizedBox();
              },
              error: (error, stackTrace) => Container(),
              loading: () => const SizedCustomProgressIndicator(),
            ),
      ],
    );
  }
}
