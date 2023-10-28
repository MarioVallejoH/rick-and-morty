import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/src/config/config.dart';
import 'package:rick_and_morty_app/src/domain/entities/locations.dart';
import 'package:rick_and_morty_app/src/presentation/widgets/widgets.dart';
import 'package:rick_and_morty_app/src/utils/constants/sizes.dart';

/// LocationCard
///
/// Used to show a preview of [Location] data
class LocationCard extends StatelessWidget {
  ///
  const LocationCard({super.key, required this.data, this.onTap});

  /// Location data
  final Location data;

  /// Optional widget onTap callback
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Container(
      height: 75,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.genericBorderRadius),
        color: Colors.white,
      ),
      clipBehavior: Clip.hardEdge,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(
              _imageName(data.type ?? ''),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    data.name ?? '',
                    style: textTheme.headlineSmall?.copyWith(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    maxLines: 2,
                  ),
                  LabeledText(
                    data: data.dimension ?? '',
                    label: appLocalizations?.dimension ?? '',
                    textColor: Colors.black87,
                  ),
                  LabeledText(
                    data: data.type ?? '',
                    label: appLocalizations?.type ?? '',
                    textColor: Colors.black87,
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
    );
  }

  String _imageName(String type) {
    switch (type) {
      case 'TV':
        return 'assets/images/tv.png';
      case 'Planet':
        return 'assets/images/jupiter.png';
      case 'Microverse':
        return 'assets/images/galaxy.png';
      case 'Game':
        return 'assets/images/joystick.png';
      case 'Dream':
        return 'assets/images/dream.png';
      case 'Space station':
        return 'assets/images/space-station.png';
      case 'Dimension':
        return 'assets/images/galaxy.png';
      case 'Teenyverse':
        return 'assets/images/galaxy.png';
      case 'Asteroid':
        return 'assets/images/asteroid.png';
      default:
        return 'assets/images/location.png';
    }
  }
}
