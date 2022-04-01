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
              left: defaultPaddingValue,
              top: defaultPaddingValue,
              right: defaultPaddingValue,
            ),
            child: SingleChildScrollView(
              child: BlocConsumer<WidgetbookApiCubit, WidgetbookApiState>(
                listener: (context, state) {
                  if (state.errorType == ErrorType.defaultError) {
                    const snackBar = SnackBar(
                      content: Text(defaultErrorMessage),
                    );
                    _showSnackBar(context, snackBar: snackBar);
                  } else if (state.errorType == ErrorType.defaultApiError) {
                    const snackBar = SnackBar(
                      content: Text(defaultErrorMessage),
                    );
                    _showSnackBar(context, snackBar: snackBar);
                  } else if (state.errorType == ErrorType.timeOut) {
                    const snackBar = SnackBar(
                      content: Text(defaultTimeOutErrorMessage),
                    );
                    _showSnackBar(context, snackBar: snackBar);
                  }
                },
                builder: (context, state) {
                  final disabledButton = !state.isValueTyped ||
                      state.errorType == ErrorType.invalidEnteredValue;
                  return Column(
                    children: [
                      const Text('Hello Flutter enthusiast!'),
                      const _VerticalSpacing(),
                      TextInputWidget(
                        controller: controller,
                        onChanged: (String message) => context
                            .read<WidgetbookApiCubit>()
                            .checkIfValueWasTyped(message: message),
                      ),
                      const _VerticalSpacing(),
                      Visibility(
                        visible:
                            state.errorType == ErrorType.invalidEnteredValue,
                        child: const Padding(
                          padding: EdgeInsets.only(bottom: 16),
                          child: Text(
                            invalidEnteredValueMessage,
                            style: TextStyle(color: errorColor),
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
                      const _VerticalSpacing(),
                      _MessageWidget(state: state),
                      const _VerticalSpacing(),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, {required SnackBar snackBar}) =>
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

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
  const _MessageWidget({
    Key? key,
    required this.state,
  }) : super(key: key);

  final WidgetbookApiState state;
  @override
  Widget build(BuildContext context) {
    if (state.isLoading) {
      return const _LoadingIndicator();
    } else if (state.responseValue.isNotEmpty) {
      return Text(state.responseValue);
    }
    return Container();
  }
}

/// Widget responsible for creating the spaces between the widgets
class _VerticalSpacing extends StatelessWidget {
  /// Creates a new instance of [_VerticalSpacing].
  const _VerticalSpacing({
    Key? key,
    this.height = 20.0,
  }) : super(key: key);

  final double height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
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
