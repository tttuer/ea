import 'package:flutter/material.dart';
import 'dart:async';

class CustomAutocompleteSearch<T extends Object> extends StatelessWidget {
  final Future<Iterable<T>> Function(TextEditingValue) optionsBuilder;
  final String Function(T option) displayStringForOption;
  final void Function(T selection) onSelected;
  final String? hintText;
  final Widget Function(T option)? optionBuilder;

  const CustomAutocompleteSearch({
    super.key,
    required this.optionsBuilder,
    required this.displayStringForOption,
    required this.onSelected,
    this.hintText,
    this.optionBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Autocomplete<T>(
      displayStringForOption: displayStringForOption,
      optionsBuilder: optionsBuilder,
      onSelected: (T selection) {
        onSelected(selection);
      },
      fieldViewBuilder:
          (context, textEditingController, focusNode, onFieldSubmitted) {
            return TextField(
              controller: textEditingController,
              focusNode: focusNode,
              decoration: InputDecoration(
                hintText: hintText,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          },
    );
  }
}
