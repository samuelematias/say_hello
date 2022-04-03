import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:widgetbook_challenge/constants/constants.dart';
import 'package:widgetbook_challenge/cubit/widgetbook_api_cubit.dart';
import 'package:widgetbook_challenge/view/view.dart';

import '../helpers/helpers.dart';

class MockWidgetbookApiCubit extends MockCubit<WidgetbookApiState>
    implements WidgetbookApiCubit {}

class FakeWidgetbookApiState extends Fake implements WidgetbookApiState {}

void main() {
  group('HomePage', () {
    const message = 'widgetbook';
    const successMessage = 'Hello $message';
    late WidgetbookApiCubit widgetbookApiCubit;

    setUpAll(() {
      registerFallbackValue(FakeWidgetbookApiState());
    });

    setUp(() {
      widgetbookApiCubit = MockWidgetbookApiCubit();
      when(() => widgetbookApiCubit.state)
          .thenReturn(const WidgetbookApiState.initial());
    });

    testWidgets(
      'renders LoadingIndicator when state is loading',
      (tester) async {
        when(() => widgetbookApiCubit.state).thenReturn(
          const WidgetbookApiState.loading(typedValue: message),
        );

        await tester.pumpAppWithBlocProvider(
          const HomePage(),
          widgetbookApiCubit: widgetbookApiCubit,
        );

        expect(
          find.byKey(homePageLoadingIndicatorWidgetKey),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'renders the Response value (Hello + typedValue) '
      'on success case when state is fetchSuccess',
      (tester) async {
        when(() => widgetbookApiCubit.state).thenReturn(
          const WidgetbookApiState.fetchSuccess(
            typedValue: message,
            responseValue: successMessage,
          ),
        );

        await tester.pumpAppWithBlocProvider(
          const HomePage(),
          widgetbookApiCubit: widgetbookApiCubit,
        );

        final findMessageSuccessWidgetByKey =
            find.byKey(messageSuccessWidgetKey);

        expect(
          findMessageSuccessWidgetByKey,
          findsOneWidget,
        );

        await tester.pump();
        final widget = tester.widget<Text>(findMessageSuccessWidgetByKey);

        expect(widget.data, successMessage);
      },
    );

    testWidgets(
      'renders Error message with defaultError '
      'on failure case when state is fetchFailure',
      (tester) async {
        when(() => widgetbookApiCubit.state).thenReturn(
          const WidgetbookApiState.fetchFailure(
            typedValue: message,
          ),
        );

        await tester.pumpAppWithBlocProvider(
          const HomePage(),
          widgetbookApiCubit: widgetbookApiCubit,
        );

        final findSnackBarDefaultErrorByKey = find.byKey(defaultErrorWidgetKey);

        expect(
          findSnackBarDefaultErrorByKey,
          findsOneWidget,
        );

        await tester.pump();

        final widget = tester.widget<Text>(findSnackBarDefaultErrorByKey);

        expect(widget.data, defaultErrorMessage);
      },
    );

    testWidgets(
      'renders Error message with defaultApiError '
      'on failure case when state is fetchFailure',
      (tester) async {
        when(() => widgetbookApiCubit.state).thenReturn(
          const WidgetbookApiState.fetchFailure(
            typedValue: message,
            errorType: ErrorType.defaultApiError,
            errorMessage: defaultApiErrorMessage,
          ),
        );

        await tester.pumpAppWithBlocProvider(
          const HomePage(),
          widgetbookApiCubit: widgetbookApiCubit,
        );

        final findSnackBarDefaultApiErrorWidgetByKey =
            find.byKey(defaultApiErrorWidgetKey);

        expect(
          findSnackBarDefaultApiErrorWidgetByKey,
          findsOneWidget,
        );

        await tester.pump();

        final widget =
            tester.widget<Text>(findSnackBarDefaultApiErrorWidgetByKey);

        expect(widget.data, defaultApiErrorMessage);
      },
    );

    testWidgets(
      'renders no warning or error message '
      'while a value is not entered in the TextField '
      'and state is typedValue',
      (tester) async {
        when(() => widgetbookApiCubit.state).thenReturn(
          const WidgetbookApiState.typedValue(
            typedValue: '',
            isValueTyped: false,
            responseValue: '',

            /// This lint rule was ignore here,
            /// because it is necessary to guarantee
            /// in the test that it is really this value.
            // ignore: avoid_redundant_argument_values
            errorType: ErrorType.none,
          ),
        );

        await tester.pumpAppWithBlocProvider(
          const HomePage(),
          widgetbookApiCubit: widgetbookApiCubit,
        );

        final findInvalidEnteredValueWidgetByKey =
            find.byKey(invalidEnteredValueWidgetKey);

        expect(
          findInvalidEnteredValueWidgetByKey,
          findsNothing,
        );
      },
    );

    testWidgets(
      'renders no warning or error message '
      'while a value is entered in the TextField '
      '(containing only valid entered values) '
      'and state is typedValue',
      (tester) async {
        when(() => widgetbookApiCubit.state).thenReturn(
          const WidgetbookApiState.typedValue(
            typedValue: message,
            isValueTyped: true,
            responseValue: '',

            /// This lint rule was ignore here,
            /// because it is necessary to guarantee
            /// in the test that it is really this value.
            // ignore: avoid_redundant_argument_values
            errorType: ErrorType.none,

            /// This lint rule was ignore here,
            /// because it is necessary to guarantee
            /// in the test that it is really this value.
            // ignore: avoid_redundant_argument_values
            errorMessage: '',
          ),
        );

        await tester.pumpAppWithBlocProvider(
          const HomePage(),
          widgetbookApiCubit: widgetbookApiCubit,
        );

        final findInvalidEnteredValueWidgetByKey =
            find.byKey(invalidEnteredValueWidgetKey);

        expect(
          findInvalidEnteredValueWidgetByKey,
          findsNothing,
        );
      },
    );

    testWidgets(
      'renders a Warning message with invalidEnteredValue '
      'while a value is entered in the TextField (containing numbers) '
      'and state is typedValue',
      (tester) async {
        when(() => widgetbookApiCubit.state).thenReturn(
          const WidgetbookApiState.typedValue(
            typedValue: '$message 34',
            isValueTyped: true,
            responseValue: '',
            errorType: ErrorType.invalidEnteredValue,
            errorMessage: invalidEnteredValueMessage,
          ),
        );

        await tester.pumpAppWithBlocProvider(
          const HomePage(),
          widgetbookApiCubit: widgetbookApiCubit,
        );

        final findInvalidEnteredValueWidgetByKey =
            find.byKey(invalidEnteredValueWidgetKey);

        expect(
          findInvalidEnteredValueWidgetByKey,
          findsOneWidget,
        );

        await tester.pump();

        final widget = tester.widget<Text>(findInvalidEnteredValueWidgetByKey);

        expect(widget.data, invalidEnteredValueMessage);
      },
    );

    testWidgets(
      'renders a Warning message with invalidEnteredValue '
      'while a value is entered in the TextField '
      '(containing special characters) '
      'and state is typedValue',
      (tester) async {
        when(() => widgetbookApiCubit.state).thenReturn(
          const WidgetbookApiState.typedValue(
            typedValue: '$message /_,.?',
            isValueTyped: true,
            responseValue: '',
            errorType: ErrorType.invalidEnteredValue,
            errorMessage: invalidEnteredValueMessage,
          ),
        );

        await tester.pumpAppWithBlocProvider(
          const HomePage(),
          widgetbookApiCubit: widgetbookApiCubit,
        );

        final findInvalidEnteredValueWidgetByKey =
            find.byKey(invalidEnteredValueWidgetKey);

        expect(
          findInvalidEnteredValueWidgetByKey,
          findsOneWidget,
        );

        await tester.pump();

        final widget = tester.widget<Text>(findInvalidEnteredValueWidgetByKey);

        expect(widget.data, invalidEnteredValueMessage);
      },
    );

    testWidgets(
      'renders a Warning message with invalidEnteredValue '
      'while a value is entered in the TextField '
      '(containing only blank spaces) '
      'and state is typedValue',
      (tester) async {
        when(() => widgetbookApiCubit.state).thenReturn(
          const WidgetbookApiState.typedValue(
            typedValue: '   ',
            isValueTyped: true,
            responseValue: '',
            errorType: ErrorType.invalidEnteredValue,
            errorMessage: invalidEnteredValueMessage,
          ),
        );

        await tester.pumpAppWithBlocProvider(
          const HomePage(),
          widgetbookApiCubit: widgetbookApiCubit,
        );

        final findInvalidEnteredValueWidgetByKey =
            find.byKey(invalidEnteredValueWidgetKey);

        expect(
          findInvalidEnteredValueWidgetByKey,
          findsOneWidget,
        );

        await tester.pump();

        final widget = tester.widget<Text>(findInvalidEnteredValueWidgetByKey);

        expect(widget.data, invalidEnteredValueMessage);
      },
    );
  });
}
