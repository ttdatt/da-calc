import 'package:da_calc/calculator/cubit/calculator_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                },
              ),
            ),
            Row(children: [
              Expanded(child: Container()),
              Expanded(child: Container()),
              Expanded(
                child: OutlinedButton(
                  onPressed: () => context.read<CalculatorCubit>().add('^'),
                  style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.transparent)),
                  child: const Text('^',
                      style: TextStyle(fontSize: 30, color: Colors.indigo)),
                ),
              ),
              Expanded(
                  child: IconButton(
                      iconSize: 30,
                      onPressed: () =>
                          context.read<CalculatorCubit>().deleteChar(),
                      icon: const Icon(Icons.backspace, color: Colors.indigo)))
            ])
          ],
        ),
      ),
    );
  }
}
