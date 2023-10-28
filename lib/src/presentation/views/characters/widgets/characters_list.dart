import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_app/src/domain/entities/characters.dart';
import 'package:rick_and_morty_app/src/presentation/state/characters/characters_repository.dart';
import 'package:rick_and_morty_app/src/presentation/views/characters/widgets/character_card.dart';
import 'package:rick_and_morty_app/src/presentation/widgets/spacers.dart';
import 'package:rick_and_morty_app/src/utils/utils/utils.dart';

/// Characters list
///
/// Show a [CharacterCard] list for a given list of Characters
class CharactersList extends ConsumerWidget {
  ///
  const CharactersList({
    super.key,
    this.controller,
    required this.characters,
    this.enableNavigation = true,
  });

  /// ListView controller
  final ScrollController? controller;

  /// Data to show
  final List<Character> characters;

  /// To allow characters to be
  final bool enableNavigation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.separated(
      controller: controller,
      padding: const EdgeInsets.only(
        bottom: 20,
      ),
      itemCount: characters.length,
      separatorBuilder: (context, index) => const SafeSpacer(
        height: 16,
      ),
      itemBuilder: (context, index) {
        return CharacterCard(
          data: characters[index],
          onTap: enableNavigation
              ? () {
                  ref
                      .read(characterSelectedProvider.notifier)
                      .update((state) => state = characters[index]);
                  Navigation.goTo(Routes.character, context);
                }
              : null,
        );
      },
    );
  }
}
