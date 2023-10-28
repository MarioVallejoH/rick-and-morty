import 'package:flutter/material.dart';

/// Text with a label and data
class LabeledText extends StatelessWidget {
  ///
  const LabeledText({
    super.key,
    required this.data,
    required this.label,
    this.textColor,
    this.maxLines = 1,
  });

  /// Data labeled
  final String data;

  /// Label
  final String label;

  /// Color to use on text
  final Color? textColor;

  /// Text maxLines
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return RichText(
      maxLines: 1,
      text: TextSpan(
        children: [
          TextSpan(
            text: label,
            style: textTheme.bodyMedium?.copyWith(
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          TextSpan(
            text: ': $data',
            style: textTheme.bodyMedium?.copyWith(
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
