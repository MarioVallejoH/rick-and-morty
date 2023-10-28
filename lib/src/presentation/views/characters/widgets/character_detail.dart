import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_app/src/config/config.dart';
import 'package:rick_and_morty_app/src/presentation/state/characters/characters_repository.dart';
import 'package:rick_and_morty_app/src/presentation/views/episodes/widgets/episodes_list.dart';
import 'package:rick_and_morty_app/src/presentation/views/locations/widgets/widgets.dart';
import 'package:rick_and_morty_app/src/presentation/widgets/widgets.dart';
import 'package:rick_and_morty_app/src/utils/constants/sizes.dart';
import 'package:rick_and_morty_app/src/utils/utils/utils.dart';

/// Character detail information
class CharacterDetail extends ConsumerWidget {
  ///
  const CharacterDetail({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final appLocalizations = AppLocalizations.of(context);
    final colors = Theme.of(context).colorScheme;
    final responsive = GlobalLocator.responsiveDesign;
    return ref.watch(characterFetchProvider).when(
          data: (data) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appLocalizations?.origin ?? '',
                  style: textTheme.headlineSmall?.copyWith(
                    fontSize: 18,
                  ),
                ),
                const SafeSpacer(
                  height: 16,
                ),
                LocationCard(data: data!.location!),
                const SafeSpacer(),
                Text(
                  appLocalizations?.location ?? '',
                  style: textTheme.headlineSmall?.copyWith(
                    fontSize: 18,
                  ),
                ),
                const SafeSpacer(
                  height: 16,
                ),
                LocationCard(data: data.location!),
                const SafeSpacer(),
                Text(
                  appLocalizations?.episodes ?? '',
                  style: textTheme.headlineSmall?.copyWith(
                    fontSize: 18,
                  ),
                ),
                const SafeSpacer(
                  height: 16,
                ),
                GenericRoundedButton(
                  width: 200,
                  height: 70,
                  text: appLocalizations?.viewEpisodes ?? '',
                  color: colors.primary,
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      showDragHandle: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft:
                              Radius.circular(AppSizes.bodyContainersRadius),
                          topRight:
                              Radius.circular(AppSizes.bodyContainersRadius),
                        ),
                      ),
                      builder: (context) {
                        return Container(
                          padding: responsive.appHorizontalPadding.copyWith(
                            top: 8,
                          ),
                          height: responsive.screenHeight * 0.8,
                          child: EpisodesList(
                            episodes: data.episode ?? [],
                            enableNavigation: false,
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            );
          },
          error: (error, stackTrace) => ErrorWidget(error),
          loading: () => const Center(
            child: SizedCustomProgressIndicator2(),
          ),
        );
  }
}
