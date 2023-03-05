import 'package:da_calc/calculator/cubit/calculator_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalculatorButton extends StatelessWidget {
  const CalculatorButton({
    required this.text,
    this.onPressed,
    required this.textStyle,
    this.char,
    this.buttonStyle,
    super.key,
  });

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
            style: buttonStyle ?? TextButton.styleFrom(backgroundColor: Colors.white70),
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
