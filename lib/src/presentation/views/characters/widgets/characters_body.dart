import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_app/src/presentation/state/characters/characters_repository.dart';
import 'package:rick_and_morty_app/src/presentation/views/characters/widgets/characters_list.dart';
import 'package:rick_and_morty_app/src/presentation/widgets/widgets.dart';

/// Characters list
///
/// Shows a list of episodes on [CharacterCard]
class CharactersBody extends ConsumerStatefulWidget {
  ///
  const CharactersBody({
    super.key,
  });

  @override
  ConsumerState<CharactersBody> createState() => _CharactersBodyState();
}

class _CharactersBodyState extends ConsumerState<CharactersBody> {
  /// ListView ScrollController
  final _controller = ScrollController();

  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Setup the listener.
    _controller.addListener(() {
      if (_controller.position.atEdge) {
        bool isTop = _controller.position.pixels == 0;
        if (!isTop) {
          final charactersData = ref.read(charactersProvider);
          if (charactersData != null) {
            int currentPage = ref.read(charactersPageProvider);
            if (charactersData.info.pages > currentPage &&
                !ref.read(charactersFetchProvider).isLoading) {
              ref
                  .read(charactersPageProvider.notifier)
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
          controller: _searchController,
          onChanged: (String value) {
            ref.read(charactersFilterProvider.notifier).update(
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
              final characters = ref.watch(charactersProvider);
              return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  if (characters != null)
                    Expanded(
                      child: CharactersList(
                        key: UniqueKey(),
                        characters: characters.characters,
                        controller: _controller,
                      ),
                    ),
                  ref.watch(charactersFetchProvider).when(
                        data: (data) {
                          if (characters == null) {
                            Future.delayed(
                              Duration.zero,
                              () => ref
                                  .read(charactersProvider.notifier)
                                  .update((state) => state = data),
                            );
                          } else {
                            Future.delayed(
                              Duration.zero,
                              () {
                                final totalCharacters = characters.characters;
                                totalCharacters.addAll(data.characters);
                                data.characters = totalCharacters;
                                ref
                                    .read(charactersProvider.notifier)
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
