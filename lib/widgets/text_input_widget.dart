import 'package:flutter/material.dart';
import 'package:widgetbook_challenge/constants/constants.dart';

/// Custom component textfield.
class TextInputWidget extends StatelessWidget {
  /// Creates a new instance of [TextInputWidget].
  const TextInputWidget({
    Key? key,
    required this.controller,
    required this.enabled,
    this.onChanged,
    this.trailing,
    this.hintText = 'Type here',
  }) : super(key: key);

  /// Check the typed string in the Textfield.
  final ValueChanged<String>? onChanged;

  /// Flag to activate/deactivate  the TextField.
  final bool enabled;

  /// Receive a widget to be set on suffixIcon.
  final Widget? trailing;

  /// Controll the TextField actions/values
  final TextEditingController controller;

  /// Set the helper text inside the TextField.
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    final _disabledColor = enabled ? brandColor : disabledColor;
    return TextField(
      controller: controller,
      key: key ?? const Key('textinput_widget'),
      decoration: InputDecoration(
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        prefixIcon: Icon(Icons.create, color: _disabledColor),
        suffixIcon: trailing,
        hintText: hintText,
      ),
      textInputAction: TextInputAction.done,
      onChanged: onChanged,
      enabled: enabled,
    );
  }
}
