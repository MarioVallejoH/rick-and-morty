import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_app/src/config/config.dart';
import 'package:rick_and_morty_app/src/presentation/views/episodes/widgets/episodes_body.dart';
import 'package:rick_and_morty_app/src/presentation/widgets/widgets.dart';

/// Episodes Screen
///
/// Fetch and search Rick and Morty episodes by name and other filtering
class EpisodesScreen extends ConsumerWidget {
  ///
  const EpisodesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appLocalizations = AppLocalizations.of(context);
    return CustomScaffold(
      body: ColumnWithPadding(
        children: [
          CustomAppBar2(
            title: appLocalizations?.episodesList,
            subtitle: appLocalizations?.episodesListText,
            includeBackArrow: false,
            includeBottomSpacer: true,
          ),
          const Expanded(
            child: EpisodesBody(),
          ),
          const SafeSpacer(
            height: 8,
          ),
        ],
      ),
    );
  }
}
