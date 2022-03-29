import 'package:flutter/material.dart';

/// The widget responsible for creating the HomePage.
class HomePage extends StatelessWidget {
  /// Creates a new instance of [HomePage].
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Interview Challenge'),
      ),
      body: const Text('Hello Flutter enthusiast!'),
    );
  }
}
