import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_app/src/presentation/state/locations/locations_provider.dart';
import 'package:rick_and_morty_app/src/presentation/views/locations/widgets/location_residents.dart';
import 'package:rick_and_morty_app/src/presentation/views/locations/widgets/widgets.dart';
import 'package:rick_and_morty_app/src/presentation/widgets/widgets.dart';
import 'package:rick_and_morty_app/src/utils/utils/utils.dart';

/// Location Screen
///
/// Shows selected location data
class LocationScreen extends ConsumerWidget {
  ///
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedLocation = ref.watch(locationSelectedProvider);
    return CustomScaffold(
      body: ColumnWithPadding(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppBar2(
            title: selectedLocation?.name,
            subtitle: selectedLocation?.type,
            onBack: () {
              Navigation.goBack(context);
              Future.delayed(Duration.zero, () {
                ref.invalidate(locationSelectedProvider);
                ref.invalidate(locationFetchProvider);
              });
            },
          ),
          LocationDescription(
            location: selectedLocation,
          ),
          const SafeSpacer(),
          const Expanded(child: LocationCharacters()),
        ],
      ),
    );
  }
}
