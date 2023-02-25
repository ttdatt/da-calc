import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:math_expressions/math_expressions.dart';

class MathExpression {
  String expression;
  String result;
  MathExpression(this.expression, this.result);
}

bool isLastCharacterNaN(String expression) {
  if (expression.isEmpty) return false;

  var lastChar = expression[expression.length - 1];
  if (lastChar == '%') return false;

  try {
    return num.parse(lastChar) is! int;
  } catch (e) {
    return true;
  }
}

bool isLastCharacterPercentSign(String expression) {
  if (expression.isEmpty) return false;
  var lastChar = expression[expression.length - 1];
  return lastChar == '%';
}

class CalculatorCubit extends Cubit<MathExpression> {
  final Parser p = Parser();
  final ContextModel cm = ContextModel();
  final NumberFormat f = NumberFormat('###.######');

  CalculatorCubit() : super(MathExpression('', ''));

  void clear() => emit(MathExpression('', ''));

  void add(String char) {
    if (isLastCharacterNaN(state.expression) && isLastCharacterNaN(char)) {
      return;
    }
    if (isLastCharacterPercentSign(state.expression) &&
        isLastCharacterPercentSign(char)) return;

    var newExpression = state.expression + char;

    if (newExpression.length == 1) {
      emit(MathExpression(newExpression, ''));
      return;
    }

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
    emit(MathExpression(result, ''));
  }

  // @override
  // void onChange(Change<MathExpression> change) {
  //   super.onChange(change);
  //   print(
  //       'current state: ${change.currentState.expression} ${change.currentState.result}');
  //   print(
  //       'next state: ${change.nextState.expression} ${change.nextState.result}');
  // }
}
