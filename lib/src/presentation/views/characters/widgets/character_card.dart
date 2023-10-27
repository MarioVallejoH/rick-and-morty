import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/src/config/config.dart';
import 'package:rick_and_morty_app/src/domain/entities/characters.dart';
import 'package:rick_and_morty_app/src/presentation/widgets/widgets.dart';
import 'package:rick_and_morty_app/src/utils/constants/sizes.dart';
import 'package:rick_and_morty_app/src/utils/utils/global_locator.dart';

/// Character preview card
///
/// Used on character list
class CharacterCard extends StatelessWidget {
  ///
  const CharacterCard({super.key, required this.data, this.onTap});

  /// Data to show
  final Character data;

  /// Callback on widget tap
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
        ),
        clipBehavior: Clip.hardEdge,
        child: Row(
          children: [
            SizedBox(
              height: 85,
              width: 85,
              child: CachedNetworkImage(imageUrl: data.image),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: LabeledText(
                            data: data.status.name,
                            label: appLocalizations?.status ?? '',
                            textColor: Colors.black,
                          ),
                        ),
                        Expanded(
                          child: LabeledText(
                            data: data.gender.name,
                            label: appLocalizations?.gender ?? '',
                            textColor: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: LabeledText(
                            data: data.species,
                            label: appLocalizations?.specie ?? '',
                            textColor: Colors.black,
                          ),
                        ),
                        if (data.type.isNotEmpty)
                          Expanded(
                            child: LabeledText(
                              data: data.type,
                              label: appLocalizations?.type ?? '',
                              textColor: Colors.black,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Icon(Icons.keyboard_arrow_right_rounded),
            const HorizontalSpacer(
              width: 16,
            ),
          ],
        ),
      ),
    );
  }
}
