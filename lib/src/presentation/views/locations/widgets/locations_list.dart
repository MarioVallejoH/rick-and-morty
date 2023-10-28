import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_app/src/domain/entities/locations.dart';
import 'package:rick_and_morty_app/src/presentation/state/locations/locations_provider.dart';
import 'package:rick_and_morty_app/src/presentation/views/locations/widgets/widgets.dart';
import 'package:rick_and_morty_app/src/presentation/widgets/spacers.dart';
import 'package:rick_and_morty_app/src/utils/utils/utils.dart';

/// Locations list
///
/// Show a [LocationCard] list for a given list of Locations
class LocationsList extends ConsumerWidget {
  ///
  const LocationsList({
    super.key,
    this.controller,
    required this.locations,
    this.enableNavigation = true,
  });

  /// ListView controller
  final ScrollController? controller;

  /// Data to show
  final List<Location> locations;

  /// To allow characters to be
  final bool enableNavigation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.separated(
      controller: controller,
      padding: const EdgeInsets.only(
        bottom: 20,
      ),
      separatorBuilder: (context, index) => const SafeSpacer(
        height: 16,
      ),
      itemCount: locations.length,
      itemBuilder: (context, index) {
        return LocationCard(
          data: locations[index],
          onTap: enableNavigation
              ? () {
                  ref
                      .read(locationSelectedProvider.notifier)
                      .update((state) => state = locations[index]);
                  Navigation.goTo(Routes.location, context);
                }
              : null,
        );
      },
    );
  }
}
