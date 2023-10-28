import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/src/config/config.dart';
import 'package:rick_and_morty_app/src/domain/entities/characters.dart';
import 'package:rick_and_morty_app/src/presentation/widgets/widgets.dart';
import 'package:rick_and_morty_app/src/utils/constants/sizes.dart';
import 'package:rick_and_morty_app/src/utils/extensions/extensions.dart';
import 'package:rick_and_morty_app/src/utils/utils/global_locator.dart';

/// Character short description
class CharacterDescription extends StatelessWidget {
  ///
  const CharacterDescription({super.key, required this.character});

  /// Character data
  final Character? character;
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    final responsive = GlobalLocator.responsiveDesign;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LabeledText(
                data: character?.name ?? '',
                label: appLocalizations?.name ?? '',
              ),
              const SafeSpacer(
                height: 10,
              ),
              LabeledText(
                maxLines: 2,
                data: character?.status.name.capitalize() ?? '',
                label: appLocalizations?.status ?? '',
              ),
              const SafeSpacer(
                height: 10,
              ),
              LabeledText(
                data: character?.gender.name.capitalize() ?? '',
                label: appLocalizations?.gender ?? '',
              ),
              if ((character?.type ?? '').isNotEmpty) ...[
                const SafeSpacer(
                  height: 10,
                ),
                LabeledText(
                  data: (character?.type ?? ''),
                  label: appLocalizations?.type ?? '',
                ),
              ],
            ],
          ),
        ),
        const HorizontalSpacer(),
        ClipRRect(
          borderRadius: BorderRadius.circular(AppSizes.genericBorderRadius),
          child: CachedNetworkImage(
            imageUrl: character?.image ?? '',
            width: responsive.maxWidthValue(90),
          ),
        ),
      ],
    );
  }
}
