import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook_challenge/cubit/widgetbook_api_cubit.dart';

class MockWidgetbookApiCubit extends MockCubit<WidgetbookApiState>
    implements WidgetbookApiCubit {}

extension PumpApp on WidgetTester {
  Future<void> pumpApp(Widget widget) {
    return pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: widget,
        ),
      ),
    );
  }

  Future<void> pumpAppWithBlocProvider(
    Widget widget, {
    WidgetbookApiCubit? widgetbookApiCubit,
  }) {
    return pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: widgetbookApiCubit ?? MockWidgetbookApiCubit(),
          ),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: widget,
          ),
        ),
      ),
    );
  }
}
