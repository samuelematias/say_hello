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
    this.valueTyped = false,
    this.value = '',
    this.hasError = ErrorType.none,
  });

  /// Initial state of [WidgetbookApiState].
  const WidgetbookApiState.initial()
      : this(
          isLoading: false,
          valueTyped: false,
          value: '',
          hasError: ErrorType.none,
        );

  /// Loading state of [WidgetbookApiState].
  const WidgetbookApiState.loading({
    required String value,
  }) : this(
          isLoading: true,
          valueTyped: false,
          value: value,
          hasError: ErrorType.none,
        );

  /// Fetching the API give an error state of [WidgetbookApiState].
  const WidgetbookApiState.fetchFailure({
    required String value,
    ErrorType hasError = ErrorType.defaultError,
  }) : this(
          isLoading: false,
          valueTyped: false,
          value: value,
          hasError: hasError,
        );

  /// Fetching the API was success state of [WidgetbookApiState].
  const WidgetbookApiState.fetchSuccess({
    required String value,
  }) : this(
          isLoading: false,
          valueTyped: false,
          value: value,
          hasError: ErrorType.none,
        );

  /// The value was typed in the TextField state of [WidgetbookApiState].
  const WidgetbookApiState.valueTyped({
    required String value,
    required bool valueTyped,
  }) : this(
          isLoading: false,
          valueTyped: valueTyped,
          value: value,
          hasError: ErrorType.none,
        );

  /// copyWith method for the [WidgetbookApiState].
  WidgetbookApiState copyWith({
    bool? isLoading,
    bool? valueTyped,
    String? value,
    ErrorType? hasError,
  }) {
    return WidgetbookApiState(
      isLoading: isLoading ?? this.isLoading,
      valueTyped: valueTyped ?? this.valueTyped,
      value: value ?? this.value,
      hasError: hasError ?? this.hasError,
    );
  }

  /// Check the initial state of [WidgetbookApiState].
  bool get isInitial =>
      !isLoading && value.isEmpty && hasError == ErrorType.none;

  /// If is true, indicates that request to API is loading.
  ///
  /// If is false, indicates that request to API was finished.
  final bool isLoading;

  /// If is true, indicates that a value was typed in the TextField.
  ///
  /// If is false, indicates that a value was not typed yet in the TextField.
  final bool valueTyped;

  /// The value that was entered.
  final String value;

  /// If has some error in the process.
  final ErrorType hasError;

  @override
  List<Object> get props => [
        isLoading,
        valueTyped,
        value,
        hasError,
      ];
}
