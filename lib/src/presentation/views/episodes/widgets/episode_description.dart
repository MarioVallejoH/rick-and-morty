import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/src/config/config.dart';
import 'package:rick_and_morty_app/src/domain/entities/episodes.dart';
import 'package:rick_and_morty_app/src/presentation/widgets/widgets.dart';

/// Episode short description
class EpisodeDescription extends StatelessWidget {
  ///
  const EpisodeDescription({super.key, required this.episode});

  /// Episode data
  final Episode? episode;
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabeledText(
          data: episode?.episode.toUpperCase() ?? '',
          label: appLocalizations?.episode ?? '',
        ),
        const SafeSpacer(
          height: 8,
        ),
        LabeledText(
          data: episode?.airDate ?? '',
          label: appLocalizations?.airDate ?? '',
        ),
      ],
    );
  }
}
