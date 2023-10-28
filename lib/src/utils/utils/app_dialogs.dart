import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:rick_and_morty_app/src/presentation/widgets/widgets.dart';
import 'package:rick_and_morty_app/src/utils/constants/sizes.dart';
import 'package:rick_and_morty_app/src/utils/utils/global_locator.dart';
import 'package:rick_and_morty_app/src/utils/utils/responsive.dart';

/// Show app dialogs from anywhere without needing to pass
/// context attribute
class AppDialogs {
  static final ResponsiveDesign _responsiveDesign =
      GlobalLocator.responsiveDesign;

  /// Show a generic app dialog with a centered button
  static Future<void> genericDialog({
    required Widget widget,
    required BuildContext context,
    VoidCallback? onTap,
    String buttonText = 'Aceptar',
  }) async {
    final responsiveD = _responsiveDesign;
    final colorsScheme = Theme.of(context).colorScheme;
    await showGeneralDialog(
      context: context,
      barrierLabel: 'Barrier',
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (_, __, ___) {
        return Center(
          child: Container(
            width: responsiveD.maxWidthValue(350),
            margin: responsiveD.appHorizontalPadding,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.circular(AppSizes.genericDialogsBorderRadius),
            ),
            child: ColumnWithPadding(
              padding: responsiveD.appDialogsPadding,
              children: [
                widget,
                const SafeSpacer(),
                GenericRoundedButton(
                  text: buttonText,
                  padding: EdgeInsets.symmetric(
                    horizontal: responsiveD.maxWidthValue(20),
                    vertical: responsiveD.maxHeightValue(16),
                  ),
                  color: colorsScheme.primary,
                  width: responsiveD.maxWidthValue(210),
                  onTap: onTap ?? () => context.pop(),
                ),
              ],
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: const Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: const Offset(1, 0), end: Offset.zero);
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }

  /// Show a generic app dialog with a centered button
  static Future<void> genericConfirmationDialog({
    required String title,
    String resourcePath = 'assets/svg/close_circle.svg',
    String? message,
    VoidCallback? onTap,
    String buttonText = 'Continuar',
  }) async {
    final responsiveD = _responsiveDesign;
    final navigatorKey = GlobalLocator.appNavigator;
    if (navigatorKey.currentContext != null) {
      await showGeneralDialog(
        context: navigatorKey.currentContext!,
        barrierLabel: 'Barrier',
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.5),
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (_, __, ___) {
          final theme = Theme.of(navigatorKey.currentContext!);
          final separator = SizedBox(
            height: responsiveD.maxHeightValue(16),
          );
          return Center(
            child: Container(
              width: responsiveD.maxWidthValue(350),
              margin: responsiveD.appHorizontalPadding,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(AppSizes.genericDialogsBorderRadius),
              ),
              child: ColumnWithPadding(
                padding: responsiveD.appDialogsPadding,
                children: [
                  SizedBox(
                    height: 28.5,
                    child: Image.asset(resourcePath),
                  ),
                  separator,
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.displayMedium,
                  ),
                  separator,
                  if (message != null)
                    Column(
                      children: [
                        Text(
                          message,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyLarge,
                        ),
                        separator,
                      ],
                    ),
                  GenericRoundedButton(
                    width: double.infinity,
                    onTap: onTap ?? () => navigatorKey.currentState?.pop(),
                    text: buttonText,
                  ),
                ],
              ),
            ),
          );
        },
        transitionBuilder: (_, anim, __, child) {
          Tween<Offset> tween;
          if (anim.status == AnimationStatus.reverse) {
            tween = Tween(begin: const Offset(-1, 0), end: Offset.zero);
          } else {
            tween = Tween(begin: const Offset(1, 0), end: Offset.zero);
          }

          return SlideTransition(
            position: tween.animate(anim),
            child: FadeTransition(
              opacity: anim,
              child: child,
            ),
          );
        },
      );
    }
  }
}
