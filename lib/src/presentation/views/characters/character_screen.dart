import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_app/src/presentation/state/characters/characters_repository.dart';
import 'package:rick_and_morty_app/src/presentation/views/characters/widgets/widgets.dart';
import 'package:rick_and_morty_app/src/presentation/widgets/widgets.dart';

/// Current character screen
class CharacterScreen extends ConsumerWidget {
  ///
  const CharacterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final character = ref.watch(characterSelectedProvider);
    return CustomScaffold(
      body: ColumnWithPadding(
        children: [
          CustomAppBar2(
            title: character?.name,
            subtitle: character?.species,
          ),
          CharacterDescription(character: character),
          const SafeSpacer(),
          const Expanded(
            child: CharacterDetail(),
          ),
          const BottomSpacer(),
        ],
      ),
    );
  }
}
