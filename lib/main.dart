import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:math_expressions/math_expressions.dart';

part 'main.g.dart';

@riverpod
class MathExpression extends _$MathExpression {
  final Parser p = Parser();
  final ContextModel cm = ContextModel();

  @override
  String build() => '';

  void add(String char) {
    state = state + char;
  }

  void clear() {
    state = '';
  }

  void calculate() {
    Expression exp = p.parse(state);
    print(exp.evaluate(EvaluationType.REAL, cm));
  }
}

void main() {
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Basic Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomeWidget(),
    );
  }
}

class MyHomeWidget extends ConsumerWidget {
  const MyHomeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String expression = ref.watch(mathExpressionProvider);
    print(expression);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Basic Calculator'),
        ),
        body: Column(
          children: [
            Row(
              children: [
                CalculatorButton(
                  text: 'C',
                  onPressed: () {
                    ref.read(mathExpressionProvider.notifier).clear();
                  },
                  textStyle:
                      const TextStyle(fontSize: 32, color: Colors.indigo),
                ),
                CalculatorButton(
                  text: '()',
                  onPressed: () {},
                  textStyle:
                      const TextStyle(fontSize: 32, color: Colors.indigo),
                ),
                const CalculatorButton(
                  text: '%',
                  char: '%',
                  textStyle: TextStyle(fontSize: 32, color: Colors.indigo),
                ),
                CalculatorButton(
                  text: '\u00F7',
                  char: '/',
                  onPressed: () {},
                  textStyle:
                      const TextStyle(fontSize: 44, color: Colors.indigo),
                ),
              ],
            ),
            Row(
              children: const [
                CalculatorButton(
                  text: '7',
                  textStyle: TextStyle(fontSize: 32, color: Colors.indigo),
                ),
                CalculatorButton(
                  text: '8',
                  textStyle: TextStyle(fontSize: 32, color: Colors.indigo),
                ),
                CalculatorButton(
                  text: '9',
                  textStyle: TextStyle(fontSize: 32, color: Colors.indigo),
                ),
                CalculatorButton(
                  text: '\u00D7',
                  char: '*',
                  textStyle: TextStyle(fontSize: 44, color: Colors.indigo),
                ),
              ],
            ),
            Row(
              children: const [
                CalculatorButton(
                  text: '4',
                  textStyle: TextStyle(fontSize: 32, color: Colors.indigo),
                ),
                CalculatorButton(
                  text: '5',
                  textStyle: TextStyle(fontSize: 32, color: Colors.indigo),
                ),
                CalculatorButton(
                  text: '6',
                  textStyle: TextStyle(fontSize: 32, color: Colors.indigo),
                ),
                CalculatorButton(
                  text: '\u2212',
                  char: '-',
                  textStyle: TextStyle(fontSize: 44, color: Colors.indigo),
                ),
              ],
            ),
            Row(
              children: const [
                CalculatorButton(
                  text: '1',
                  textStyle: TextStyle(fontSize: 32, color: Colors.indigo),
                ),
                CalculatorButton(
                  text: '2',
                  textStyle: TextStyle(fontSize: 32, color: Colors.indigo),
                ),
                CalculatorButton(
                  text: '3',
                  textStyle: TextStyle(fontSize: 32, color: Colors.indigo),
                ),
                CalculatorButton(
                  text: '+',
                  char: '+',
                  textStyle: TextStyle(fontSize: 44, color: Colors.indigo),
                ),
              ],
            ),
            Row(
              children: [
                const CalculatorButton(
                  text: '0',
                  textStyle: TextStyle(fontSize: 32, color: Colors.indigo),
                ),
                const CalculatorButton(
                  text: '00',
                  textStyle: TextStyle(fontSize: 32, color: Colors.indigo),
                ),
                const CalculatorButton(
                  text: ',',
                  char: '.',
                  textStyle: TextStyle(fontSize: 32, color: Colors.indigo),
                ),
                CalculatorButton(
                  text: '=',
                  onPressed: () {
                    ref.read(mathExpressionProvider.notifier).calculate();
                  },
                  textStyle:
                      const TextStyle(fontSize: 44, color: Colors.indigo),
                ),
              ],
            )
          ],
        ));
  }
}

class CalculatorButton extends ConsumerWidget {
  const CalculatorButton(
      {required this.text,
      this.onPressed,
      required this.textStyle,
      this.char,
      super.key});

  final String text;
  final String? char;
  final void Function()? onPressed;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        constraints: const BoxConstraints(minWidth: 85, minHeight: 85),
        child: OutlinedButton(
          style: TextButton.styleFrom(backgroundColor: Colors.white70),
          onPressed: () {
            if (onPressed != null) {
              onPressed?.call();
            } else {
              ref.read(mathExpressionProvider.notifier).add(char ?? text);
            }
          },
          child: Text(text, style: textStyle),
        ));
  }
}
