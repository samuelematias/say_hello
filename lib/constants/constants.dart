import 'package:flutter/widgets.dart';

/// Color that representing widgets with our brand in the app
const brandColor = Color(0xFF772CE8);

/// Color that representing widgets with errors in the app
const errorColor = Color(0xFFD21F3C);

/// Color that representing widgets with warning in the app
const warningColor = Color(0xFFEED202);

/// Color that representing widgets disabled in the app
const disabledColor = Color(0xFFA9A9A9);

/// Default padding value used in app
const defaultPaddingValue = 16.0;

/// Default error message used in app
const defaultErrorMessage = 'Something is wrong! Please, Try again later.';

/// Default API error message used in app
const defaultApiErrorMessage =
    'We had a Unexpected error. Please, Try again later.';

/// Invalid entered value message
const invalidEnteredValueMessage = 'This field just accept letters [A - Z].';

/// LoadingIndicator widget - identification key
const homePageLoadingIndicatorWidgetKey = Key('loading_indicator');

/// Showing the Response value (Hello + typedValue) on success case
/// - identification key
const messageSuccessWidgetKey = Key('message_success');

/// Showing default error message - identification key
const defaultErrorWidgetKey = Key('default_error');

/// Showing default API error message - identification key
const defaultApiErrorWidgetKey = Key('default_api_error');

/// Invalid entered value - identification key
const invalidEnteredValueWidgetKey = Key('invalid_entered_value');

/// "Say, Hello!" button identification - key
const confirmButtonWidgetKey = Key('confirm_button');
