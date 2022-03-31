import 'package:flutter/widgets.dart';

/// Extension for FocusScope related actions
extension Unfocus on BuildContext {
  /// Method responsable to the TextField UnFocus
  void unfocus() => FocusScope.of(this).unfocus();
}
