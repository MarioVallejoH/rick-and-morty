import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/src/config/config.dart';
import 'package:rick_and_morty_app/src/domain/entities/episodes.dart';
import 'package:rick_and_morty_app/src/utils/constants/sizes.dart';
import 'package:rick_and_morty_app/src/utils/extensions/extensions.dart';
import 'package:rick_and_morty_app/src/utils/utils/global_locator.dart';

/// Episode Card
///
/// Used to show a preview of an episode data on a list
class EpisodeCard extends StatelessWidget {
  ///
  const EpisodeCard({super.key, required this.data});

  /// Episode data to show
  final Episode data;

  @override
  Widget build(BuildContext context) {
    final responsive = GlobalLocator.responsiveDesign;
    final textTheme = Theme.of(context).textTheme;
    final appLocalizations = AppLocalizations.of(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.genericBorderRadius),
        color: Colors.white,
      ),
      clipBehavior: Clip.hardEdge,
      child: Row(
        children: [
          SizedBox(
            height: 85,
            width: 85,
            //TODO: Search or make a free image for this
            child: Image.asset('assets/images/episodes.jpg'),
          ),
          Expanded(
            child: Container(
              height: 85,
              padding: EdgeInsets.symmetric(
                horizontal: responsive.maxWidthValue(16),
                vertical: responsive.maxHeightValue(5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    data.name,
                    style: textTheme.headlineSmall?.copyWith(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    maxLines: 2,
                  ),
                  _LabeledText(
                    data: data.episode.toUpperCase(),
                    label: appLocalizations?.episode ?? '',
                    textTheme: textTheme,
                  ),
                  _LabeledText(
                    data: data.airDate,
                    label: appLocalizations?.airDate ?? '',
                    textTheme: textTheme,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LabeledText extends StatelessWidget {
  const _LabeledText({
    required this.data,
    required this.textTheme,
    required this.label,
  });

  final String data;
  final String label;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return RichText(
      maxLines: 1,
      text: TextSpan(
        children: [
          TextSpan(
            text: label.capitalize(),
            style: textTheme.bodyMedium?.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          TextSpan(
            text: ': ${data.capitalize()}',
            style: textTheme.bodyMedium?.copyWith(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
