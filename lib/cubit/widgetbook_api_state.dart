part of 'widgetbook_api_cubit.dart';

/// Enum with possible errors types.
enum ErrorType {
  /// For an unexpected error.
  defaultError,

  /// Enter a invalidValue (e.g. numbers).
  invalidEnteredValue,

  /// For an unexpected error from API.
  defaultApiError,

  /// Timeout from API.
  timeOut,

  /// If no error occurs.
  none,
}

/// Responsible to create and handle the [WidgetbookApiState] on the Cubit.
class WidgetbookApiState extends Equatable {
  /// Creates a new instance of [WidgetbookApiState].
  const WidgetbookApiState({
    this.isLoading = false,
    this.isValueTyped = false,
    this.typedValue = '',
    this.responseValue = '',
    this.hasError = ErrorType.none,
  });

  /// Initial state of [WidgetbookApiState].
  const WidgetbookApiState.initial()
      : this(
          isLoading: false,
          isValueTyped: false,
          typedValue: '',
          responseValue: '',
          hasError: ErrorType.none,
        );

  /// Loading state of [WidgetbookApiState].
  const WidgetbookApiState.loading({
    required String typedValue,
    required String responseValue,
  }) : this(
          isLoading: true,
          isValueTyped: false,
          typedValue: typedValue,
          responseValue: responseValue,
          hasError: ErrorType.none,
        );

  /// Fetching the API give an error state of [WidgetbookApiState].
  const WidgetbookApiState.fetchFailure({
    required String typedValue,
    required String responseValue,
    ErrorType hasError = ErrorType.defaultError,
  }) : this(
          isLoading: false,
          isValueTyped: false,
          typedValue: typedValue,
          responseValue: responseValue,
          hasError: hasError,
        );

  /// Fetching the API was success state of [WidgetbookApiState].
  const WidgetbookApiState.fetchSuccess({
    required String typedValue,
    required String responseValue,
  }) : this(
          isLoading: false,
          isValueTyped: false,
          typedValue: typedValue,
          responseValue: responseValue,
          hasError: ErrorType.none,
        );

  /// The value was typed in the TextField state of [WidgetbookApiState].
  const WidgetbookApiState.typedValue({
    required bool isValueTyped,
    required String typedValue,
    required String responseValue,
    ErrorType hasError = ErrorType.none,
  }) : this(
          isLoading: false,
          isValueTyped: isValueTyped,
          typedValue: typedValue,
          responseValue: responseValue,
          hasError: hasError,
        );

  /// copyWith method for the [WidgetbookApiState].
  WidgetbookApiState copyWith({
    bool? isLoading,
    bool? isValueTyped,
    String? typedValue,
    String? responseValue,
    ErrorType? hasError,
  }) {
    return WidgetbookApiState(
      isLoading: isLoading ?? this.isLoading,
      isValueTyped: isValueTyped ?? this.isValueTyped,
      typedValue: typedValue ?? this.typedValue,
      responseValue: responseValue ?? this.responseValue,
      hasError: hasError ?? this.hasError,
    );
  }

  /// Check the initial state of [WidgetbookApiState].
  bool get isInitial =>
      !isLoading && responseValue.isEmpty && hasError == ErrorType.none;

  /// Validate if the value/message typed has numbers.
  bool get messageHasNumber => typedValue.contains(RegExp('[0-9]'));

  ///
  bool get disabledButton =>
      !isValueTyped && hasError == ErrorType.invalidEnteredValue;

  /// If is true, indicates that request to API is loading.
  ///
  /// If is false, indicates that request to API was finished.
  final bool isLoading;

  /// If is true, indicates that a value was typed in the TextField.
  ///
  /// If is false, indicates that a value was not typed yet in the TextField.
  final bool isValueTyped;

  /// The value that was typed.
  final String typedValue;

  /// The value that was received from the API response.
  final String responseValue;

  /// If has some error in the process.
  final ErrorType hasError;

  @override
  List<Object> get props => [
        isLoading,
        isValueTyped,
        typedValue,
        responseValue,
        hasError,
      ];
}