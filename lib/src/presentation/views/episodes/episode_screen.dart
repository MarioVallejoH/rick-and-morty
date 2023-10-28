import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_app/src/presentation/state/episodes/episodes_provider.dart';
import 'package:rick_and_morty_app/src/presentation/views/episodes/widgets/widgets.dart';
import 'package:rick_and_morty_app/src/presentation/widgets/app_bars.dart';
import 'package:rick_and_morty_app/src/presentation/widgets/column_with_padding.dart';
import 'package:rick_and_morty_app/src/presentation/widgets/custom_scaffold.dart';
import 'package:rick_and_morty_app/src/presentation/widgets/spacers.dart';
import 'package:rick_and_morty_app/src/utils/utils/utils.dart';

/// Episode detailed screen
class EpisodeScreen extends ConsumerWidget {
  ///
  const EpisodeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final episode = ref.watch(episodeSelectedProvider);
    return CustomScaffold(
      body: ColumnWithPadding(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppBar2(
            title: episode?.name,
            onBack: () {
              Navigation.goBack(context);
              Future.delayed(Duration.zero, () {
                ref.invalidate(episodeSelectedProvider);
                ref.invalidate(episodeFetchProvider);
              });
            },
          ),
          EpisodeDescription(episode: episode),
          const SafeSpacer(),
          const Expanded(child: EpisodeCharacters()),
        ],
      ),
    );
  }
}
