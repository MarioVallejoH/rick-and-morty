import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/src/config/config.dart';
import 'package:rick_and_morty_app/src/domain/entities/episodes.dart';
import 'package:rick_and_morty_app/src/presentation/widgets/widgets.dart';
import 'package:rick_and_morty_app/src/utils/constants/sizes.dart';
import 'package:rick_and_morty_app/src/utils/utils/global_locator.dart';

/// Episode Card
///
/// Used to show a preview of an episode data on a list
class EpisodeCard extends StatelessWidget {
  ///
  const EpisodeCard({super.key, required this.data, this.onTap});

  /// Episode data to show
  final Episode data;

  /// Callback on card tap
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final responsive = GlobalLocator.responsiveDesign;
    final textTheme = Theme.of(context).textTheme;
    final appLocalizations = AppLocalizations.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.genericBorderRadius),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              blurRadius: 0.05,
              spreadRadius: 0.05,
              blurStyle: BlurStyle.outer,
            ),
          ],
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
            const VerticalDivider(
              width: 2,
              thickness: 1,
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
                    LabeledText(
                      data: data.episode.toUpperCase(),
                      label: appLocalizations?.episode ?? '',
                      textColor: Colors.black,
                    ),
                    LabeledText(
                      data: data.airDate,
                      label: appLocalizations?.airDate ?? '',
                      textColor: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
            if (onTap != null) const Icon(Icons.keyboard_arrow_right_rounded),
            const HorizontalSpacer(
              width: 16,
            ),
          ],
        ),
      ),
    );
  }
}
