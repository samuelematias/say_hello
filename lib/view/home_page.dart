import 'package:flutter/material.dart';
import 'package:widgetbook_challenge/constants/constants.dart';
import 'package:widgetbook_challenge/extensions/extensions.dart';
import 'package:widgetbook_challenge/widgets/widgets.dart';

/// The widget responsible for creating the HomePage.
class HomePage extends StatelessWidget {
  /// Creates a new instance of [HomePage].
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const HomeView();
  }
}

/// The widget responsible HomePage body.
class HomeView extends StatelessWidget {
  /// Creates a new instance of [HomeView].
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Interview Challenge'),
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => context.unfocus(),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16,
              top: 16,
              right: 16,
            ),
            child: Column(
              children: [
                const Text('Hello Flutter enthusiast!'),
                const SizedBox(height: 20),
                TextInputWidget(
                  controller: controller,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: brandColor),
                  onPressed: () {},
                  child: const Text('Say, Hello!'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
