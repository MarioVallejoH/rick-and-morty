import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_app/src/presentation/state/episodes/episodes_provider.dart';
import 'package:rick_and_morty_app/src/presentation/views/episodes/widgets/episode_card.dart';
import 'package:rick_and_morty_app/src/presentation/widgets/circular_progress_indicator.dart';
import 'package:rick_and_morty_app/src/presentation/widgets/widgets.dart';
import 'package:rick_and_morty_app/src/utils/utils/navigation.dart';

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
  final _controller = ScrollController();

  @override
  void initState() {
    super.initState();

    // Setup the listener.
    _controller.addListener(() {
      if (_controller.position.atEdge) {
        bool isTop = _controller.position.pixels == 0;
        if (!isTop) {
          final episodesData = ref.read(episodesProvider);
          if (episodesData != null) {
            int currentPage = ref.read(episodesPageProvider);
            if (episodesData.info.pages > currentPage &&
                !ref.read(episodesFetchProvider).isLoading) {
              ref
                  .read(episodesPageProvider.notifier)
                  .update((state) => state = (currentPage += 1));
            }
          }
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final episodes = ref.watch(episodesProvider);
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        if (episodes != null)
          Expanded(
            child: ListView.separated(
              controller: _controller,
              separatorBuilder: (context, index) => const SafeSpacer(
                height: 16,
              ),
              padding: EdgeInsets.zero,
              itemCount: episodes.episodes.length,
              itemBuilder: (context, index) {
                return EpisodeCard(
                  data: episodes.episodes[index],
                  onTap: () {
                    ref
                        .read(episodeSelectedProvider.notifier)
                        .update((state) => state = episodes.episodes[index]);
                    Navigation.goTo(Routes.episode, context);
                  },
                );
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
                } else {
                  Future.delayed(
                    Duration.zero,
                    () {
                      final totalEpisodes = episodes.episodes;
                      totalEpisodes.addAll(data.episodes);
                      data.episodes = totalEpisodes;
                      ref
                          .read(episodesProvider.notifier)
                          .update((state) => state = data);
                    },
                  );
                }
                return const SizedBox();
              },
              error: (error, stackTrace) => Container(),
              loading: () => const SizedCustomProgressIndicator2(),
            ),
      ],
    );
  }
}
