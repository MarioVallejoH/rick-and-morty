import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/src/domain/entities/characters.dart';
import 'package:rick_and_morty_app/src/presentation/views/characters/widgets/character_card.dart';
import 'package:rick_and_morty_app/src/presentation/widgets/spacers.dart';

/// Characters list
///
/// Show a [CharacterCard] list for a given list of Characters
class CharactersList extends StatelessWidget {
  ///
  const CharactersList({super.key, this.controller, required this.characters});

  /// ListView controller
  final ScrollController? controller;

  /// Data to show
  final List<Character> characters;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      itemCount: characters.length,
      separatorBuilder: (context, index) => const SafeSpacer(
        height: 16,
      ),
      itemBuilder: (context, index) {
        return CharacterCard(data: characters[index]);
      },
    );
  }
}
