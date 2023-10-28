import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_app/src/config/config.dart';
import 'package:rick_and_morty_app/src/presentation/views/characters/widgets/widgets.dart';
import 'package:rick_and_morty_app/src/presentation/widgets/widgets.dart';

/// Characters Screen
///
/// Fetch and search Rick and Morty characters by name and other filtering
class CharactersScreen extends ConsumerWidget {
  ///
  const CharactersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appLocalizations = AppLocalizations.of(context);
    return CustomScaffold(
      body: ColumnWithPadding(
        children: [
          CustomAppBar2(
            title: appLocalizations?.charactersList,
            subtitle: appLocalizations?.charactersListText,
            includeBackArrow: false,
            includeBottomSpacer: true,
          ),
          const Expanded(
            child: CharactersBody(),
          ),
          const SafeSpacer(
            height: 8,
          ),
        ],
      ),
    );
  }
}
