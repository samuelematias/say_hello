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
    });

    tearDown(() {
      widgetbookApiCubit.close();
    });

    testWidgets(
      'renders LoadingIndicator when state is loading',
      (tester) async {
        whenListen(
          widgetbookApiCubit,
          Stream.value(
            const WidgetbookApiState.loading(typedValue: message),
          ),
          initialState: const WidgetbookApiState.initial(),
        );

        await tester.pumpAppWithBlocProvider(
          const HomePage(),
          widgetbookApiCubit: widgetbookApiCubit,
        );

        await tester.pump();

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
        whenListen(
          widgetbookApiCubit,
          Stream.value(
            const WidgetbookApiState.fetchSuccess(
              typedValue: message,
              responseValue: successMessage,
            ),
          ),
          initialState: const WidgetbookApiState.initial(),
        );

        await tester.pumpAppWithBlocProvider(
          const HomePage(),
          widgetbookApiCubit: widgetbookApiCubit,
        );

        await tester.pump();

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
        whenListen(
          widgetbookApiCubit,
          Stream.value(
            const WidgetbookApiState.fetchFailure(
              typedValue: message,
            ),
          ),
          initialState: const WidgetbookApiState.initial(),
        );

        await tester.pumpAppWithBlocProvider(
          const HomePage(),
          widgetbookApiCubit: widgetbookApiCubit,
        );

        await tester.pump();

        final findDefaultErrorByKey = find.byKey(defaultErrorWidgetKey);

        expect(
          findDefaultErrorByKey,
          findsOneWidget,
        );

        await tester.pump();

        final widget = tester.widget<Text>(findDefaultErrorByKey);

        expect(widget.data, defaultErrorMessage);
      },
    );

    testWidgets(
      'renders Error message with defaultApiError '
      'on failure case when state is fetchFailure',
      (tester) async {
        whenListen(
          widgetbookApiCubit,
          Stream.value(
            const WidgetbookApiState.fetchFailure(
              typedValue: message,
              errorType: ErrorType.defaultApiError,
              errorMessage: defaultApiErrorMessage,
            ),
          ),
          initialState: const WidgetbookApiState.initial(),
        );

        await tester.pumpAppWithBlocProvider(
          const HomePage(),
          widgetbookApiCubit: widgetbookApiCubit,
        );

        await tester.pump();

        final findDefaultApiErrorWidgetByKey =
            find.byKey(defaultApiErrorWidgetKey);

        expect(
          findDefaultApiErrorWidgetByKey,
          findsOneWidget,
        );

        await tester.pump();

        final widget = tester.widget<Text>(findDefaultApiErrorWidgetByKey);

        expect(widget.data, defaultApiErrorMessage);
      },
    );

    testWidgets(
      'renders no warning or error message '
      'while a value is not entered in the TextField '
      'and state is typedValue',
      (tester) async {
        whenListen(
          widgetbookApiCubit,
          Stream.value(
            const WidgetbookApiState.typedValue(
              typedValue: '',
              isValueTyped: false,
              responseValue: '',
            ),
          ),
          initialState: const WidgetbookApiState.initial(),
        );

        await tester.pumpAppWithBlocProvider(
          const HomePage(),
          widgetbookApiCubit: widgetbookApiCubit,
        );

        await tester.pump();

        final findInvalidEnteredValueWidgetByKey =
            find.byKey(invalidEnteredValueWidgetKey);

        expect(
          findInvalidEnteredValueWidgetByKey,
          findsNothing,
        );

        final findDefaultErrorByKey = find.byKey(defaultErrorWidgetKey);

        expect(
          findDefaultErrorByKey,
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
        whenListen(
          widgetbookApiCubit,
          Stream.value(
            const WidgetbookApiState.typedValue(
              typedValue: message,
              isValueTyped: true,
              responseValue: '',
            ),
          ),
          initialState: const WidgetbookApiState.initial(),
        );

        await tester.pumpAppWithBlocProvider(
          const HomePage(),
          widgetbookApiCubit: widgetbookApiCubit,
        );

        await tester.pump();

        final findInvalidEnteredValueWidgetByKey =
            find.byKey(invalidEnteredValueWidgetKey);

        expect(
          findInvalidEnteredValueWidgetByKey,
          findsNothing,
        );

        final findDefaultErrorByKey = find.byKey(defaultErrorWidgetKey);

        expect(
          findDefaultErrorByKey,
          findsNothing,
        );
      },
    );

    testWidgets(
      'renders a Warning message with invalidEnteredValue '
      'while a value is entered in the TextField (containing numbers) '
      'and state is typedValue',
      (tester) async {
        whenListen(
          widgetbookApiCubit,
          Stream.value(
            const WidgetbookApiState.typedValue(
              typedValue: '$message 34',
              isValueTyped: true,
              responseValue: '',
              errorType: ErrorType.invalidEnteredValue,
              errorMessage: invalidEnteredValueMessage,
            ),
          ),
          initialState: const WidgetbookApiState.initial(),
        );

        await tester.pumpAppWithBlocProvider(
          const HomePage(),
          widgetbookApiCubit: widgetbookApiCubit,
        );

        await tester.pump();

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
        whenListen(
          widgetbookApiCubit,
          Stream.value(
            const WidgetbookApiState.typedValue(
              typedValue: '$message /_,.?',
              isValueTyped: true,
              responseValue: '',
              errorType: ErrorType.invalidEnteredValue,
              errorMessage: invalidEnteredValueMessage,
            ),
          ),
          initialState: const WidgetbookApiState.initial(),
        );

        await tester.pumpAppWithBlocProvider(
          const HomePage(),
          widgetbookApiCubit: widgetbookApiCubit,
        );

        await tester.pump();

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
        whenListen(
          widgetbookApiCubit,
          Stream.value(
            const WidgetbookApiState.typedValue(
              typedValue: '   ',
              isValueTyped: true,
              responseValue: '',
              errorType: ErrorType.invalidEnteredValue,
              errorMessage: invalidEnteredValueMessage,
            ),
          ),
          initialState: const WidgetbookApiState.initial(),
        );

        await tester.pumpAppWithBlocProvider(
          const HomePage(),
          widgetbookApiCubit: widgetbookApiCubit,
        );

        await tester.pump();

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
