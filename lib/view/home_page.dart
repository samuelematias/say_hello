import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widgetbook_challenge/constants/constants.dart';
import 'package:widgetbook_challenge/cubit/widgetbook_api_cubit.dart';
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
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16,
              top: 16,
              right: 16,
            ),
            child: BlocBuilder<WidgetbookApiCubit, WidgetbookApiState>(
              builder: (context, state) {
                final disabledButton = !state.isValueTyped ||
                    state.hasError == ErrorType.invalidEnteredValue;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      const Text('Hello Flutter enthusiast!'),
                      const SizedBox(height: 20),
                      TextInputWidget(
                        controller: controller,
                        onChanged: (String message) => context
                            .read<WidgetbookApiCubit>()
                            .checkIfValueWasTyped(message: message),
                      ),
                      const SizedBox(height: 20),
                      Visibility(
                        visible:
                            state.hasError == ErrorType.invalidEnteredValue,
                        child: const Padding(
                          padding: EdgeInsets.only(bottom: 16),
                          child: Text(
                            'This field just accept letters [A - Z].',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: brandColor),
                        onPressed: disabledButton
                            ? null
                            : () => _getWidgetbook(
                                  context,
                                  controller,
                                  message: controller.text,
                                ),
                        child: const Text('Say, Hello!'),
                      ),
                      const SizedBox(height: 20),
                      const _MessageWidget(),
                      const SizedBox(height: 20),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _getWidgetbook(
    BuildContext context,
    TextEditingController controller, {
    required String message,
  }) {
    context.read<WidgetbookApiCubit>().getWidgetbook(message: message);
    controller.clear();
    FocusManager.instance.primaryFocus?.unfocus();
  }
}

/// The widget responsible for creating the MessageWidget.
class _MessageWidget extends StatelessWidget {
  /// Creates a new instance of [_MessageWidget].
  const _MessageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WidgetbookApiCubit, WidgetbookApiState>(
      listener: (context, state) {
        if (state.hasError == ErrorType.defaultError) {
          const snackBar = SnackBar(
            content: Text('Something is wrong! Try again later.'),
          );
          _showSnackBar(context, snackBar: snackBar);
        } else if (state.hasError == ErrorType.defaultApiError) {
          const snackBar = SnackBar(
            content: Text('Something is wrong! Try again later.'),
          );
          _showSnackBar(context, snackBar: snackBar);
        } else if (state.hasError == ErrorType.timeOut) {
          const snackBar = SnackBar(
            content: Text(
              'Looks like the server is taking to long to respond, '
              'please try again.',
            ),
          );
          _showSnackBar(context, snackBar: snackBar);
        }
      },
      builder: (context, state) {
        if (state.isLoading) {
          return const _LoadingIndicator();
        } else if (state.responseValue.isNotEmpty) {
          return Text(state.responseValue);
        }
        return Container();
      },
    );
  }

  void _showSnackBar(BuildContext context, {required SnackBar snackBar}) =>
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

/// The widget responsible for creating the LoadingIndicator.
class _LoadingIndicator extends StatelessWidget {
  /// Creates a new instance of [_LoadingIndicator].
  const _LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      backgroundColor: Colors.white,
      valueColor: AlwaysStoppedAnimation<Color>(brandColor),
    );
  }
}
