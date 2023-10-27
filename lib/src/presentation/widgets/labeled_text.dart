import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/src/utils/extensions/extensions.dart';

/// Text with a label and data
class LabeledText extends StatelessWidget {
  ///
  const LabeledText({
    super.key,
    required this.data,
    required this.label,
    this.textColor,
  });

  /// Data labeled
  final String data;

  /// Label
  final String label;

  /// Color to use on text
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return RichText(
      maxLines: 1,
      text: TextSpan(
        children: [
          TextSpan(
            text: label.capitalize(),
            style: textTheme.bodyMedium?.copyWith(
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          TextSpan(
            text: ': ${data.capitalize()}',
            style: textTheme.bodyMedium?.copyWith(
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
