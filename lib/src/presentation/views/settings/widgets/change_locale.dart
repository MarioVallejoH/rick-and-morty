import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_app/src/config/config.dart';
import 'package:rick_and_morty_app/src/presentation/widgets/spacers.dart';
import 'package:rick_and_morty_app/src/utils/constants/sizes.dart';
import 'package:rick_and_morty_app/src/utils/utils/global_locator.dart';

/// Change locale dialog body
class ChangeLocaleWidget extends ConsumerWidget {
  ///
  const ChangeLocaleWidget({
    super.key,
    required this.state,
  });

  /// Widget selection state
  final StateProvider<Locale> state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appLocalizations = AppLocalizations.of(context);
    final responsive = GlobalLocator.responsiveDesign;
    final theme = Theme.of(context);
    final height = (60.0 * AppLocalizations.supportedLocales.length);
    return Container(
      padding: responsive.appHInnerPadding,
      height: (height > 280 ? 280 : height) + 30,
      width: double.infinity,
      child: Column(
        children: [
          const SafeSpacer(
            height: 10,
          ),
          Text(
            'Set application language',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: theme.colorScheme.secondary,
              fontSize: 18,
            ),
          ),
          const SafeSpacer(),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: AppLocalizations.supportedLocales.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final e = AppLocalizations.supportedLocales[index];
                return GestureDetector(
                  onTap: () {
                    ref.read(state.notifier).update((state) => state = e);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 8,
                    ),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(AppSizes.genericBorderRadius),
                      border: ref.watch(state) == e
                          ? Border.all(
                              color: theme.primaryColor,
                            )
                          : null,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            (e.languageCode == 'en'
                                    ? appLocalizations?.en
                                    : appLocalizations?.es) ??
                                '',
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: theme.colorScheme.secondary,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black54,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            (e.languageCode).toUpperCase(),
                            style: theme.textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: theme.colorScheme.secondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
