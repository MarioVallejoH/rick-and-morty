import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_app/src/config/config.dart';
import 'package:rick_and_morty_app/src/presentation/views/locations/widgets/widgets.dart';
import 'package:rick_and_morty_app/src/presentation/widgets/widgets.dart';

/// Locations Screen
///
/// Fetch and search Rick and Morty episodes by name and other filtering
class LocationsScreen extends ConsumerWidget {
  ///
  const LocationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appLocalizations = AppLocalizations.of(context);
    return CustomScaffold(
      body: ColumnWithPadding(
        children: [
          CustomAppBar2(
            title: appLocalizations?.locationsList,
            subtitle: appLocalizations?.locationsListText,
            includeBackArrow: false,
            includeBottomSpacer: true,
          ),
          const Expanded(
            child: LocationsBody(),
          ),
          const SafeSpacer(
            height: 8,
          ),
        ],
      ),
    );
  }
}
