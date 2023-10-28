import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/src/presentation/widgets/widgets.dart';

/// Loading screen
///
/// Shows a loading element on its center
class LoadingScreen extends StatelessWidget {
  /// Widget constructor
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return CustomScaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const HeaderSpacer(),

          /// TODO: Find a free usage asset to put here or make a cool looking widget for it
          Center(
            child: Image.asset('assets/images/rick-sanchez.gif'),
          ),
          const SafeSpacer(
            height: 65,
          ),
          SizedCustomProgressIndicator(
            color: colors.onPrimary,
          ),
        ],
      ),
    );
  }
}
