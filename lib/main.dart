import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_challenge/app/app.dart';
import 'package:widgetbook_challenge/app/app_bloc_observer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocOverrides.runZoned(
    () => runApp(const App()),
    blocObserver: AppBlocObserver(),
  );
}
