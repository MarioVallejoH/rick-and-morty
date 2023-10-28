import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/src/config/config.dart';
import 'package:rick_and_morty_app/src/domain/entities/locations.dart';
import 'package:rick_and_morty_app/src/presentation/widgets/widgets.dart';

/// Shows location data
class LocationDescription extends StatelessWidget {
  ///
  const LocationDescription({super.key, this.location});

  /// Location data to show
  final Location? location;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabeledText(
          data: location?.dimension ?? '',
          label: appLocalizations?.dimension ?? 'Dimension',
        ),
        const SafeSpacer(
          height: 8,
        ),
        LabeledText(
          data: location?.type ?? '',
          label: appLocalizations?.type ?? 'Type',
        ),
      ],
    );
  }
}
