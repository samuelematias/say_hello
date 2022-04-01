import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:widgetbook_challenge/constants/constants.dart';

/// Custom component textfield.
class TextInputWidget extends StatelessWidget {
  /// Creates a new instance of [TextInputWidget].
  const TextInputWidget({
    Key? key,
    required this.controller,
    this.onChanged,
    this.trailing,
    this.hintText = 'Type here',
  }) : super(key: key);

  /// Check the typed string in the Textfield
  final ValueChanged<String>? onChanged;

  /// Receive a widget to be set on suffixIcon
  final Widget? trailing;

  /// Controll the TextField actions/values
  final TextEditingController controller;

  /// Set the helper text inside the TextField
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      // inputFormatters: [
      //   LengthLimitingTextInputFormatter(10),
      //   FilteringTextInputFormatter.allow(
      //     // RegExp(r'^[a-zA-Z]+$'),
      //     RegExp(r'^([^0-9]*)+$'),
      //   ),
      // ],
      controller: controller,
      key: key ?? const Key('textinput_widget'),
      decoration: InputDecoration(
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        prefixIcon: const Icon(Icons.create, color: brandColor),
        suffixIcon: trailing,
        hintText: hintText,
      ),
      textInputAction: TextInputAction.done,
      onChanged: onChanged,
      // onSubmitted: onSubmitted,
    );
  }
}
