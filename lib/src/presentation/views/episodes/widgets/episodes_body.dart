import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_app/src/presentation/state/episodes/episodes_provider.dart';
import 'package:rick_and_morty_app/src/presentation/views/episodes/widgets/episode_card.dart';
import 'package:rick_and_morty_app/src/presentation/views/episodes/widgets/episodes_list.dart';
import 'package:rick_and_morty_app/src/presentation/widgets/widgets.dart';

/// Episodes list
///
/// Shows a list of episodes on [EpisodeCard]
class EpisodesBody extends ConsumerStatefulWidget {
  ///
  const EpisodesBody({
    super.key,
  });

  @override
  ConsumerState<EpisodesBody> createState() => _EpisodesBodyState();
}

class _EpisodesBodyState extends ConsumerState<EpisodesBody> {
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
    return Column(
      children: [
        SearchField(
          onChanged: (String value) {
            ref.read(episodesFilterProvider.notifier).update(
                  (state) => state = {
                    'name': value,
                  },
                );
          },
        ),
        const SafeSpacer(),
        Expanded(
          child: Builder(
            builder: (context) {
              final episodes = ref.watch(episodesProvider);
              return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  if (episodes != null)
                    EpisodesList(
                      episodes: episodes.episodes,
                      controller: _controller,
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
            },
          ),
        ),
      ],
    );
  }
}
