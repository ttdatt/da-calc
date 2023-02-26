import 'package:da_calc/calculator/cubit/calculator_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const spacing = 4.0;

class CalculatorWidget extends StatelessWidget {
  const CalculatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CalculatorCubit(),
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Basic Calculator'),
          ),
          body: Column(
            children: [
              const ExpressionDisplay(),
              const SizedBox(height: spacing),
              Row(
                children: [
                  const SizedBox(width: spacing),
                  CalculatorButton(
                    text: 'C',
                    onPressed: (cubit) => cubit.clear(),
                    textStyle:
                        const TextStyle(fontSize: 32, color: Colors.indigo),
                  ),
                  const SizedBox(width: spacing),
                  const CalculatorButton(
                    text: '()',
                    textStyle: TextStyle(fontSize: 32, color: Colors.indigo),
                  ),
                  const SizedBox(width: spacing),
                  const CalculatorButton(
                    text: '%',
                    textStyle: TextStyle(fontSize: 32, color: Colors.indigo),
                  ),
                  const SizedBox(width: spacing),
                  const CalculatorButton(
                    text: '\u00F7',
                    textStyle: TextStyle(fontSize: 44, color: Colors.indigo),
                  ),
                  const SizedBox(width: spacing),
                ],
              ),
              const SizedBox(height: spacing),
              Row(
                children: const [
                  SizedBox(width: spacing),
                  CalculatorButton(
                    text: '7',
                    textStyle: TextStyle(fontSize: 32, color: Colors.black),
                  ),
                  SizedBox(width: spacing),
                  CalculatorButton(
                    text: '8',
                    textStyle: TextStyle(fontSize: 32, color: Colors.black),
                  ),
                  SizedBox(width: spacing),
                  CalculatorButton(
                    text: '9',
                    textStyle: TextStyle(fontSize: 32, color: Colors.black),
                  ),
                  SizedBox(width: spacing),
                  CalculatorButton(
                    text: '\u00D7',
                    textStyle: TextStyle(fontSize: 44, color: Colors.indigo),
                  ),
                  SizedBox(width: spacing),
                ],
              ),
              const SizedBox(height: spacing),
              Row(
                children: const [
                  SizedBox(width: spacing),
                  CalculatorButton(
                    text: '4',
                    textStyle: TextStyle(fontSize: 32, color: Colors.black),
                  ),
                  SizedBox(width: spacing),
                  CalculatorButton(
                    text: '5',
                    textStyle: TextStyle(fontSize: 32, color: Colors.black),
                  ),
                  SizedBox(width: spacing),
                  CalculatorButton(
                    text: '6',
                    textStyle: TextStyle(fontSize: 32, color: Colors.black),
                  ),
                  SizedBox(width: spacing),
                  CalculatorButton(
                    text: '\u2212',
                    char: '-',
                    textStyle: TextStyle(fontSize: 44, color: Colors.indigo),
                  ),
                  SizedBox(width: spacing),
                ],
              ),
              const SizedBox(height: spacing),
              Row(
                children: const [
                  SizedBox(width: spacing),
                  CalculatorButton(
                    text: '1',
                    textStyle: TextStyle(fontSize: 32, color: Colors.black),
                  ),
                  SizedBox(width: spacing),
                  CalculatorButton(
                    text: '2',
                    textStyle: TextStyle(fontSize: 32, color: Colors.black),
                  ),
                  SizedBox(width: spacing),
                  CalculatorButton(
                    text: '3',
                    textStyle: TextStyle(fontSize: 32, color: Colors.black),
                  ),
                  SizedBox(width: spacing),
                  CalculatorButton(
                    text: '+',
                    textStyle: TextStyle(fontSize: 44, color: Colors.indigo),
                  ),
                  SizedBox(width: spacing),
                ],
              ),
              const SizedBox(height: spacing),
              Row(
                children: [
                  const SizedBox(width: spacing),
                  const CalculatorButton(
                    text: '0',
                    textStyle: TextStyle(fontSize: 32, color: Colors.black),
                  ),
                  const SizedBox(width: spacing),
                  const CalculatorButton(
                    text: '00',
                    textStyle: TextStyle(fontSize: 32, color: Colors.black),
                  ),
                  const SizedBox(width: spacing),
                  const CalculatorButton(
                    text: ',',
                    char: '.',
                    textStyle: TextStyle(fontSize: 32, color: Colors.indigo),
                  ),
                  const SizedBox(width: spacing),
                  CalculatorButton(
                    text: '=',
                    onPressed: (cubit) => cubit.update(),
                    buttonStyle:
                        TextButton.styleFrom(backgroundColor: Colors.indigo),
                    textStyle:
                        const TextStyle(fontSize: 44, color: Colors.white),
                  ),
                  const SizedBox(width: spacing),
                ],
              )
            ],
          )),
    );
  }
}

class ExpressionDisplay extends StatelessWidget {
  const ExpressionDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final expressionController = TextEditingController();

    expressionController.text =
        context.read<CalculatorCubit>().state.expression;
    return Card(
      child: BlocListener<CalculatorCubit, MathExpression>(
        listener: ((context, state) {
          expressionController.text =
              context.read<CalculatorCubit>().state.expression;
        }),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                autofocus: true,
                maxLines: 1,
                textAlign: TextAlign.right,
                style: const TextStyle(fontSize: 40),
                controller: expressionController,
                decoration: const InputDecoration(
                    border: InputBorder.none, hintText: ''),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
              child: BlocBuilder<CalculatorCubit, MathExpression>(
                  builder: (ctx, state) {
                return Text(
                  state.result,
                  style: const TextStyle(fontSize: 30, color: Colors.grey),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}

class CalculatorButton extends StatelessWidget {
  const CalculatorButton(
      {required this.text,
      this.onPressed,
      required this.textStyle,
      this.char,
      this.buttonStyle,
      super.key});

  final String text;
  final String? char;
  final void Function(CalculatorCubit cubit)? onPressed;
  final TextStyle textStyle;
  final ButtonStyle? buttonStyle;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
          constraints: const BoxConstraints(minWidth: 85, minHeight: 85),
          child: OutlinedButton(
            style: buttonStyle ??
                TextButton.styleFrom(backgroundColor: Colors.white70),
            onPressed: () {
              if (onPressed != null) {
                onPressed?.call(context.read<CalculatorCubit>());
              } else {
                context.read<CalculatorCubit>().add(char ?? text);
              }
            },
            child: Text(text, style: textStyle),
          )),
    );
  }
}
