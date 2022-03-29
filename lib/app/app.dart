import 'package:flutter/material.dart';
import 'package:widgetbook_challenge/view/view.dart';

/// The widget responsible for creating the app
class App extends StatelessWidget {
  /// Creates a new instance of [App].
  const App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Say, Hello!',
      theme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}
