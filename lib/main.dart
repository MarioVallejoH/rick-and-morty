import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:rick_and_morty_app/src/config/config.dart';
import 'package:rick_and_morty_app/src/config/theme/app_theme.dart';
import 'package:rick_and_morty_app/src/presentation/state/main/main_provider.dart';
import 'package:rick_and_morty_app/src/utils/utils/utils.dart';

void main() {
  final getIt = GetIt.instance;
  getIt.registerLazySingleton<Logger>(
    () => Logger(),
  );
  runApp(const ProviderScope(child: MyApp()));
}

/// My app main class
class MyApp extends ConsumerWidget {
  ///
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getIt = GetIt.instance;
    if (!getIt.isRegistered<ResponsiveDesign>()) {
      getIt.registerLazySingleton<ResponsiveDesign>(
        () => ResponsiveDesign(context),
      );
    }
    return MaterialApp(
      title: 'Rick And Morty App',
      debugShowCheckedModeBanner: false,
      theme: globalTheme(),
      initialRoute: Routes.root,
      routes: Routes.getRoutes(),
      locale: ref.watch(localeProvider),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
