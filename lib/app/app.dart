import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widgetbook_challenge/api/widgetbook_api.dart';
import 'package:widgetbook_challenge/cubit/widgetbook_api_cubit.dart';
import 'package:widgetbook_challenge/view/view.dart';

/// The widget responsible for creating the app
class App extends StatelessWidget {
  /// Creates a new instance of [App].
  const App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WidgetbookApiCubit(WidgetbookApi()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Say, Hello!',
        theme: ThemeData.dark(),
        home: const HomePage(),
      ),
    );
  }
}
