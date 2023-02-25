import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:math_expressions/math_expressions.dart';

class MathExpression {
  String expression;
  String result;
  MathExpression(this.expression, this.result);
}

String trimNonNumber(String expression) {
  for (var i = expression.length - 1; i >= 0; i--) {}
  return '';
}

class CalculatorCubit extends Cubit<MathExpression> {
  final Parser p = Parser();
  final ContextModel cm = ContextModel();
  final NumberFormat f = NumberFormat('###.######');

  CalculatorCubit() : super(MathExpression('', ''));

  void clear() => emit(MathExpression('', ''));

  void add(String char) {
    if (char == '%' && state.expression[state.expression.length - 1] == '%') {
      return;
    }
    var newExpression = state.expression + char;
    dynamic result;
    try {
      var finalExpression = newExpression.replaceAll('%', '/100');
      finalExpression = finalExpression.replaceAll('\u00D7', '*');
      finalExpression = finalExpression.replaceAll('\u00F7', '/');
      Expression exp = p.parse(finalExpression);
      result = exp.evaluate(EvaluationType.REAL, cm);
      result = f.format(result);
    } on FormatException catch (e) {
      print(e.toString());
    } catch (e) {}

    emit(MathExpression(newExpression, result ?? state.result));
  }

  void update() {
    var finalState = state.expression.replaceAll('%', '/100');
    finalState = finalState.replaceAll('\u00D7', '*');
    finalState = finalState.replaceAll('\u00F7', '/');
    Expression exp = p.parse(finalState);
    var result = exp.evaluate(EvaluationType.REAL, cm);
    result = f.format(result);
    emit(MathExpression(state.expression, result));
  }

  @override
  void onChange(Change<MathExpression> change) {
    super.onChange(change);

    print(
        'current state: ${change.currentState.expression} ${change.currentState.result}');
    print(
        'next state: ${change.nextState.expression} ${change.nextState.result}');
  }
}
