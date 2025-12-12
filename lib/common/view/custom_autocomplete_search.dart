import 'package:flutter/material.dart';
import 'dart:async';

class CustomAutocompleteSearch<T extends Object> extends StatefulWidget {
  final Future<Iterable<T>> Function(TextEditingValue) optionsBuilder;
  final String Function(T option) displayStringForOption;
  final void Function(T selection) onSelected;
  final String? hintText;
  final Widget Function(T option)? optionBuilder;
  final int debounceDuration;

  const CustomAutocompleteSearch({
    super.key,
    required this.optionsBuilder,
    required this.displayStringForOption,
    required this.onSelected,
    this.hintText,
    this.optionBuilder,
    this.debounceDuration = 300,
  });

  @override
  State<CustomAutocompleteSearch<T>> createState() =>
      _CustomAutocompleteSearchState<T>();
}

class _CustomAutocompleteSearchState<T extends Object>
    extends State<CustomAutocompleteSearch<T>> {
  Timer? _debounceTimer;
  String _lastQuery = '';
  List<T> _options = [];
  bool _isLoading = false;

  Future<Iterable<T>> _debouncedOptionsBuilder(
    TextEditingValue textEditingValue,
  ) async {
    final query = textEditingValue.text;
    if (query.isEmpty) {
      setState(() {
        _isLoading = false;
        _options = [];
      });
      return Iterable<T>.empty();
    }
    if (query == _lastQuery) {
      return _options;
    }
    if (_isLoading) {
      _isLoading = true;
    }

    _debounceTimer?.cancel();

    final completer = Completer<Iterable<T>>();
    _debounceTimer = Timer(
      Duration(milliseconds: widget.debounceDuration),
      () async {
        try {
          final result = await widget.optionsBuilder(textEditingValue);
          setState(() {
            _lastQuery = query;
            _isLoading = false;
            _options = result.toList();
          });
          completer.complete(result);
        } catch (e) {
          setState(() {
            _isLoading = false;
            _options = [];
          });
          completer.completeError(e);
        }
      },
    );
    return completer.future;
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Autocomplete<T>(
      displayStringForOption: widget.displayStringForOption,
      optionsBuilder: _debouncedOptionsBuilder,
      onSelected: widget.onSelected,
      fieldViewBuilder: 
          (context, textEditingController, focusNode, onFieldSubmitted) {
            return TextField(
              controller: textEditingController,
              focusNode: focusNode,
              decoration: InputDecoration(
                hintText: widget.hintText,
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
