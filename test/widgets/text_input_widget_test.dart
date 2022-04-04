import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook_challenge/constants/constants.dart';
import 'package:widgetbook_challenge/widgets/widgets.dart';
import '../helpers/helpers.dart';

void main() {
  final controller = TextEditingController();
  const widgetKey = Key('textinput_widget');
  const textInputWidgetValue = 'Widgetbook';
  group('TextInputWidget', () {
    testWidgets('build the active widget', (tester) async {
      await tester.pumpApp(
        TextInputWidget(
          controller: controller,
          enabled: true,
        ),
      );

      await tester.pump();
      final findWidgetByType = find.byType(TextInputWidget);
      final widget = tester.widget<TextInputWidget>(findWidgetByType);

      final descendantWidgetFinder = find.descendant(
        of: findWidgetByType,
        matching: find.byType(Icon),
      );

      final descendantWidget = tester.widget<Icon>(
        descendantWidgetFinder,
      );

      final ancestorWidgetFinder = find.descendant(
        of: findWidgetByType,
        matching: find.byType(TextField),
      );

      final ancestorWidget = tester.widget<TextField>(
        ancestorWidgetFinder,
      );

      expect(findWidgetByType, findsOneWidget);
      expect(find.byKey(widgetKey), findsOneWidget);
      expect(widget.enabled, true);
      expect(descendantWidgetFinder, findsOneWidget);
      expect(descendantWidget.icon, Icons.create);
      expect(descendantWidget.color, brandColor);
      expect(ancestorWidgetFinder, findsOneWidget);
      expect(ancestorWidget.enabled, true);
    });

    testWidgets('build the inactive widget', (tester) async {
      await tester.pumpApp(
        TextInputWidget(
          controller: controller,
          enabled: false,
        ),
      );

      await tester.pump();
      final findWidgetByType = find.byType(TextInputWidget);
      final widget = tester.widget<TextInputWidget>(findWidgetByType);

      final descendantWidgetFinder = find.descendant(
        of: findWidgetByType,
        matching: find.byType(Icon),
      );

      final descendantWidget = tester.widget<Icon>(
        descendantWidgetFinder,
      );

      final ancestorWidgetFinder = find.descendant(
        of: findWidgetByType,
        matching: find.byType(TextField),
      );

      final ancestorWidget = tester.widget<TextField>(
        ancestorWidgetFinder,
      );

      expect(findWidgetByType, findsOneWidget);
      expect(find.byKey(widgetKey), findsOneWidget);
      expect(widget.enabled, false);
      expect(descendantWidgetFinder, findsOneWidget);
      expect(descendantWidget.icon, Icons.create);
      expect(descendantWidget.color, disabledColor);
      expect(ancestorWidgetFinder, findsOneWidget);
      expect(ancestorWidget.enabled, false);
    });

    testWidgets('type a value', (tester) async {
      await tester.pumpApp(
        TextInputWidget(
          controller: controller,
          enabled: true,
        ),
      );

      await tester.pump();
      final textInputWidget = find.byType(TextInputWidget);

      expect(textInputWidget, findsOneWidget);

      await tester.enterText(textInputWidget, textInputWidgetValue);

      expect(find.text(textInputWidgetValue), findsOneWidget);
    });

    testWidgets('type and clean the value', (tester) async {
      await tester.pumpApp(
        TextInputWidget(
          controller: controller,
          enabled: true,
        ),
      );

      await tester.pump();
      final textInputWidget = find.byType(TextInputWidget);

      expect(textInputWidget, findsOneWidget);

      await tester.enterText(textInputWidget, textInputWidgetValue);

      expect(find.text(textInputWidgetValue), findsOneWidget);

      controller.clear();

      expect(find.text(textInputWidgetValue), findsNothing);
    });

    testWidgets('hintText appears without having a value typed',
        (tester) async {
      await tester.pumpApp(
        TextInputWidget(
          controller: controller,
          enabled: true,
        ),
      );

      await tester.pump();
      final textInputWidget = find.byType(TextInputWidget);

      expect(textInputWidget, findsOneWidget);

      expect(find.text('Type here'), findsOneWidget);
    });

    testWidgets('assign a value in onChanged', (tester) async {
      late String value;
      await tester.pumpApp(
        TextInputWidget(
          controller: controller,
          enabled: true,
          onChanged: (String v) => value = v,
        ),
      );

      await tester.pump();
      final textInputWidget = find.byType(TextInputWidget);

      expect(textInputWidget, findsOneWidget);

      await tester.enterText(textInputWidget, textInputWidgetValue);

      expect(find.text(textInputWidgetValue), findsOneWidget);

      expect(value, textInputWidgetValue);
    });

    testWidgets('add a trailing (suffixIcon)', (tester) async {
      const trailingIcon = Icon(Icons.close, color: Colors.amberAccent);
      await tester.pumpApp(
        TextInputWidget(
          controller: controller,
          enabled: true,
          trailing: trailingIcon,
        ),
      );

      await tester.pump();
      final textInputWidget = find.byType(TextInputWidget);

      final descendantWidget = tester.widget<Icon>(
        find.descendant(
          of: textInputWidget,
          matching: find.byWidget(trailingIcon),
        ),
      );

      expect(textInputWidget, findsOneWidget);
      expect(find.byWidget(trailingIcon), findsOneWidget);
      expect(descendantWidget.icon, Icons.close);
      expect(descendantWidget.color, Colors.amberAccent);
    });
  });
}
