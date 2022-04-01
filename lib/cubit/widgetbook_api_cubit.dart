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
      emit(WidgetbookApiState.loading(value: message));
      final response =
          await _widgetbookApi.welcomeToWidgetbook(message: message);
      emit(WidgetbookApiState.fetchSuccess(value: response));
      emit(state.copyWith(value: ''));
    } on UnexpectedException catch (_) {
      emit(
        WidgetbookApiState.fetchFailure(
          value: message,
          hasError: ErrorType.defaultApiError,
        ),
      );
    } catch (_) {
      emit(WidgetbookApiState.fetchFailure(value: message));
    }
  }

  /// Check is the value/message was typed on the TextField
  void checkIfValueWasTyped({required String message}) {
    if (message.isEmpty) {
      emit(
        WidgetbookApiState.valueTyped(
          value: state.value,
          valueTyped: false,
        ),
      );
    } else {
      emit(
        WidgetbookApiState.valueTyped(
          value: state.value,
          valueTyped: true,
        ),
      );
    }
  }
}
