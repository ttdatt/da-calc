import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorCubit extends Cubit<String> {
  final Parser p = Parser();
  final ContextModel cm = ContextModel();
  final NumberFormat f = NumberFormat('###.######');

  CalculatorCubit() : super('');

  void clear() => emit('');

  void add(String char) {
    if (char == '%' && state[state.length - 1] == '%') return;

    emit(state + char);
  }

  void update() {
    var finalState = state.replaceAll('%', '/100');
    finalState = finalState.replaceAll('\u00D7', '*');
    finalState = finalState.replaceAll('\u00F7', '/');
    Expression exp = p.parse(finalState);
    var result = exp.evaluate(EvaluationType.REAL, cm);
    emit(f.format(result));
  }
}
