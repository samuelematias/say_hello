import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:widgetbook_challenge/api/widgetbook_api.dart';

part 'widgetbook_api_state.dart';

/// Responsible to handle the business logic, [WidgetbookApiCubit].
class WidgetbookApiCubit extends Cubit<WidgetbookApiState> {
  /// Creates a new instance of [WidgetbookApiCubit].
  WidgetbookApiCubit(this._widgetbookApi)
      : super(const WidgetbookApiState.initial());

  /// The API, [WidgetbookApi]
  final WidgetbookApi _widgetbookApi;

  /// Send the value/message to the API, and get/return the Hello message.
  Future<void> getWidgetbook({required String message}) async {
    try {
      emit(
        WidgetbookApiState.loading(
          typedValue: message,
          responseValue: state.responseValue,
        ),
      );
      final response =
          await _widgetbookApi.welcomeToWidgetbook(message: message);
      emit(
        WidgetbookApiState.fetchSuccess(
          typedValue: state.typedValue,
          responseValue: response,
        ),
      );
      emit(state.copyWith(typedValue: ''));
    } on UnexpectedException catch (_) {
      emit(
        WidgetbookApiState.fetchFailure(
          typedValue: state.typedValue,
          responseValue: state.responseValue,
          hasError: ErrorType.defaultApiError,
        ),
      );
    } catch (_) {
      emit(
        WidgetbookApiState.fetchFailure(
          typedValue: state.typedValue,
          responseValue: state.responseValue,
        ),
      );
    }
  }

  /// Check is the value/message was typed on the TextField
  void checkIfValueWasTyped({required String message}) {
    if (message.isEmpty) {
      emit(
        WidgetbookApiState.typedValue(
          typedValue: message,
          responseValue: state.responseValue,
          isValueTyped: false,
        ),
      );
    } else {
      emit(
        WidgetbookApiState.typedValue(
          typedValue: message,
          responseValue: state.responseValue,
          isValueTyped: true,
        ),
      );
    }
  }
}
