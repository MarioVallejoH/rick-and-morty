import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:rick_and_morty_app/src/config/config.dart';
import 'package:rick_and_morty_app/src/presentation/state/main/main_provider.dart';
import 'package:rick_and_morty_app/src/presentation/views/settings/widgets/widgets.dart';
import 'package:rick_and_morty_app/src/presentation/widgets/widgets.dart';
import 'package:rick_and_morty_app/src/utils/utils/utils.dart';

/// Settings screen
///
/// Set here app settings
class SettingsScreen extends ConsumerWidget {
  /// Widget Constructor
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final appLocalizations = AppLocalizations.of(context);
    return CustomScaffold(
      body: ColumnWithPadding(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomAppBar2(
            title: appLocalizations?.settings,
            subtitle: appLocalizations?.settingsText,
            includeBackArrow: false,
          ),
          Expanded(
            child: SettingSection(
              headerPadding: EdgeInsets.zero,
              items: [
                SettingItemWidget(
                  title: appLocalizations!.language,
                  titleTextStyle: theme.textTheme.bodyLarge,
                  leading: const Icon(
                    Icons.translate_rounded,
                    color: Colors.white,
                  ),
                  trailing: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: theme.colorScheme.onPrimary,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          (appLocalizations.localeName).toUpperCase(),
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const HorizontalSpacer(),
                      const Icon(
                        Icons.keyboard_arrow_right_rounded,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  onTap: () async {
                    final localeSelection = StateProvider<Locale>(
                      (ref) => Locale(
                        appLocalizations.localeName,
                      ),
                    );
                    await AppDialogs.genericDialog(
                      buttonText: appLocalizations.accept,
                      context: context,
                      widget: ChangeLocaleWidget(state: localeSelection),
                    );
                    if (ref.read(localeSelection).languageCode !=
                        appLocalizations.localeName) {
                      if (AppLocalizations.delegate
                          .isSupported(ref.read(localeSelection))) {
                        ref
                            .read(localeProvider.notifier)
                            .update((state) => ref.read(localeSelection));
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
