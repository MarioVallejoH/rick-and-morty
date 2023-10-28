import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_app/src/presentation/state/locations/locations_provider.dart';
import 'package:rick_and_morty_app/src/presentation/views/locations/widgets/locations_list.dart';
import 'package:rick_and_morty_app/src/presentation/widgets/widgets.dart';

/// Locations list
///
/// Shows a list of locations on [LocationCard]
class LocationsBody extends ConsumerStatefulWidget {
  ///
  const LocationsBody({
    super.key,
  });

  @override
  ConsumerState<LocationsBody> createState() => _LocationsBodyState();
}

class _LocationsBodyState extends ConsumerState<LocationsBody> {
  /// ListView ScrollController
  final _controller = ScrollController();

  @override
  void initState() {
    super.initState();

    // Setup the listener.
    _controller.addListener(() {
      if (_controller.position.atEdge) {
        bool isTop = _controller.position.pixels == 0;
        if (!isTop) {
          final locationsData = ref.read(locationsProvider);
          if (locationsData != null) {
            int currentPage = ref.read(locationsPageProvider);
            if (locationsData.info.pages > currentPage &&
                !ref.read(locationsFetchProvider).isLoading) {
              ref
                  .read(locationsPageProvider.notifier)
                  .update((state) => state = (currentPage += 1));
            }
          }
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchField(
          onChanged: (String value) {
            ref.read(locationsFilterProvider.notifier).update(
                  (state) => state = {
                    'name': value,
                  },
                );
          },
        ),
        const SafeSpacer(),
        Expanded(
          child: Builder(
            builder: (context) {
              final locations = ref.watch(locationsProvider);

              return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  if (locations != null)
                    LocationsList(
                      locations: locations.locations,
                      controller: _controller,
                    ),
                  ref.watch(locationsFetchProvider).when(
                        data: (data) {
                          if (locations == null) {
                            Future.delayed(
                              Duration.zero,
                              () => ref
                                  .read(locationsProvider.notifier)
                                  .update((state) => state = data),
                            );
                          } else {
                            Future.delayed(
                              Duration.zero,
                              () {
                                final totalLocations = locations.locations;
                                totalLocations.addAll(data.locations);
                                data.locations = totalLocations;
                                ref
                                    .read(locationsProvider.notifier)
                                    .update((state) => state = data);
                              },
                            );
                          }
                          return const SizedBox();
                        },
                        error: (error, stackTrace) => Container(),
                        loading: () => const SizedCustomProgressIndicator2(),
                      ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
