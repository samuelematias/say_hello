import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:widgetbook_challenge/api/widgetbook_api.dart';
import 'package:widgetbook_challenge/constants/constants.dart';
import 'package:widgetbook_challenge/cubit/widgetbook_api_cubit.dart';

class MockWidgetbookApi extends Mock implements WidgetbookApi {}

void main() {
  group('WidgetbookApiCubit', () {
    late WidgetbookApi widgetbookApi;
    setUp(() {
      widgetbookApi = MockWidgetbookApi();
    });

    test('initial state is WidgetbookApiState.initial', () {
      final widgetbookApiCubit = WidgetbookApiCubit(widgetbookApi);
      expect(widgetbookApiCubit.state, const WidgetbookApiState.initial());

      widgetbookApiCubit.close();
    });

    group('getWidgetbook', () {
      const message = 'widgetbook';

      setUp(() {
        when(
          () => widgetbookApi.welcomeToWidgetbook(
            message: any(named: 'message'),
          ),
        ).thenAnswer((_) async => Future<String>.value(''));
      });

      blocTest<WidgetbookApiCubit, WidgetbookApiState>(
        'invokes getWidgetbook on widgetbookApi',
        build: () => WidgetbookApiCubit(widgetbookApi),
        act: (cubit) => cubit.getWidgetbook(message: message),
        verify: (_) {
          verify(() => widgetbookApi.welcomeToWidgetbook(message: message))
              .called(1);
        },
      );

      blocTest<WidgetbookApiCubit, WidgetbookApiState>(
        'emits [loading, success] when widgetbookApi succeeds',
        build: () {
          when(
            () => widgetbookApi.welcomeToWidgetbook(
              message: any(named: 'message'),
            ),
          ).thenAnswer((_) async => Future<String>.value('Hello $message'));
          return WidgetbookApiCubit(widgetbookApi);
        },
        act: (cubit) => cubit.getWidgetbook(message: message),
        expect: () => const <WidgetbookApiState>[
          WidgetbookApiState.loading(typedValue: message),
          WidgetbookApiState.fetchSuccess(
            typedValue: message,
            responseValue: 'Hello $message',
          ),
        ],
      );

      blocTest<WidgetbookApiCubit, WidgetbookApiState>(
        'emits [loading, failure] when widgetbookApi throws (defaultError)',
        build: () {
          when(
            () => widgetbookApi.welcomeToWidgetbook(
              message: any(named: 'message'),
            ),
          ).thenThrow(Exception());
          return WidgetbookApiCubit(widgetbookApi);
        },
        act: (cubit) => cubit.getWidgetbook(message: message),
        expect: () => const <WidgetbookApiState>[
          WidgetbookApiState.loading(typedValue: message),
          WidgetbookApiState.fetchFailure(
            typedValue: message,

            /// This lint rule was ignore here,
            /// because it is necessary to guarantee
            /// in the test that it is really this value.
            // ignore: avoid_redundant_argument_values
            errorMessage: defaultErrorMessage,
          ),
        ],
      );

      blocTest<WidgetbookApiCubit, WidgetbookApiState>(
        'emits [loading, failure] when widgetbookApi throws (defaultApiError)',
        build: () {
          when(
            () => widgetbookApi.welcomeToWidgetbook(
              message: any(named: 'message'),
            ),
          ).thenThrow(UnexpectedException());
          return WidgetbookApiCubit(widgetbookApi);
        },
        act: (cubit) => cubit.getWidgetbook(message: message),
        expect: () => const <WidgetbookApiState>[
          WidgetbookApiState.loading(typedValue: message),
          WidgetbookApiState.fetchFailure(
            typedValue: message,
            errorType: ErrorType.defaultApiError,
            errorMessage: defaultApiErrorMessage,
          ),
        ],
      );

      blocTest<WidgetbookApiCubit, WidgetbookApiState>(
        'emits [typedValue] with isValueTyped = false '
        'while a value is not entered in the TextField',
        build: () => WidgetbookApiCubit(widgetbookApi),
        act: (cubit) => cubit.checkIfValueWasTyped(message: ''),
        expect: () => <WidgetbookApiState>[
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
        ],
      );

      blocTest<WidgetbookApiCubit, WidgetbookApiState>(
        'emits [typedValue] with isValueTyped = true '
        'while a value is entered in the TextField '
        '(containing only valid entered values)',
        build: () => WidgetbookApiCubit(widgetbookApi),
        act: (cubit) => cubit.checkIfValueWasTyped(message: message),
        expect: () => <WidgetbookApiState>[
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
        ],
      );

      blocTest<WidgetbookApiCubit, WidgetbookApiState>(
        'emits [typedValue] with isValueTyped = true '
        'while a value is entered in the TextField (containing numbers)',
        build: () => WidgetbookApiCubit(widgetbookApi),
        act: (cubit) => cubit.checkIfValueWasTyped(message: '$message 34'),
        expect: () => <WidgetbookApiState>[
          const WidgetbookApiState.typedValue(
            typedValue: '$message 34',
            isValueTyped: true,
            responseValue: '',
            errorType: ErrorType.invalidEnteredValue,
            errorMessage: invalidEnteredValueMessage,
          ),
        ],
      );

      blocTest<WidgetbookApiCubit, WidgetbookApiState>(
        'emits [typedValue] with isValueTyped = true '
        'while a value is entered in the TextField '
        '(containing special characters)',
        build: () => WidgetbookApiCubit(widgetbookApi),
        act: (cubit) => cubit.checkIfValueWasTyped(message: '$message /_,.?'),
        expect: () => <WidgetbookApiState>[
          const WidgetbookApiState.typedValue(
            typedValue: '$message /_,.?',
            isValueTyped: true,
            responseValue: '',
            errorType: ErrorType.invalidEnteredValue,
            errorMessage: invalidEnteredValueMessage,
          ),
        ],
      );

      blocTest<WidgetbookApiCubit, WidgetbookApiState>(
        'emits [typedValue] with isValueTyped = true '
        'while a value is entered in the TextField '
        '(containing only blank spaces)',
        build: () => WidgetbookApiCubit(widgetbookApi),
        act: (cubit) => cubit.checkIfValueWasTyped(message: '   '),
        expect: () => <WidgetbookApiState>[
          const WidgetbookApiState.typedValue(
            typedValue: '   ',
            isValueTyped: true,
            responseValue: '',
            errorType: ErrorType.invalidEnteredValue,
            errorMessage: invalidEnteredValueMessage,
          ),
        ],
      );
    });
  });
}
