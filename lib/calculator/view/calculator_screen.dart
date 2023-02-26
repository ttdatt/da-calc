import 'package:da_calc/calculator/cubit/calculator_cubit.dart';
import 'package:da_calc/calculator/view/calculator_button.dart';
import 'package:da_calc/calculator/view/calculator_display.dart';
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
                  CalculatorButton(
                    text: '( )',
                    textStyle:
                        const TextStyle(fontSize: 32, color: Colors.indigo),
                    onPressed: (cubit) => cubit.addParenthesis(),
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
