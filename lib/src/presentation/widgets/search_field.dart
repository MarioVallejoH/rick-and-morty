import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/src/config/config.dart';

/// Custom search field
class SearchField extends StatelessWidget {
  ///
  const SearchField({
    super.key,
    this.controller,
    required this.onChanged,
  });

  /// Search field controller
  final TextEditingController? controller;

  /// Callback on text field value change
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    return TextField(
      controller: controller,
      onChanged: onChanged,
      style: textTheme.bodyLarge?.copyWith(
        fontSize: 16,
        color: AppColors.secondary_500,
      ),
      decoration: InputDecoration(
        hintText: appLocalizations?.search ?? 'Search',
        suffixIcon: const Icon(Icons.search_rounded),
      ),
    );
  }
}
