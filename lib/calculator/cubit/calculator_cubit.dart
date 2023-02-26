import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:da_calc/calculator/cubit/utils.dart';

class MathExpression {
  String expression;
  String result;
  MathExpression(this.expression, this.result);
}

class CalculatorCubit extends Cubit<MathExpression> {
  final Parser p = Parser();
  final ContextModel cm = ContextModel();
  final NumberFormat f = NumberFormat('###.######');
  var _openingParentheses = 0;
  var _closedParentheses = 0;

  CalculatorCubit() : super(MathExpression('', ''));

  dynamic _evaluate(String expression) {
    final finalExpression = expression
        .replaceAll('%', '/100')
        .replaceAll('\u00D7', '*')
        .replaceAll('\u00F7', '/');
    try {
      Expression exp = p.parse(finalExpression);
      var result = exp.evaluate(EvaluationType.REAL, cm);
      result = f.format(result);
      return result;
    } on FormatException catch (e) {
      print(e.toString());
    } catch (e) {}
    return state.result;
  }

  String _decideWhichParenthesis(String expression, bool hasOpenParentheses) {
    if (expression.isEmpty) {
      _openingParentheses++;
      return '(';
    }

    if (!hasOpenParentheses) {
      if (isLastCharNumber(expression) ||
          isLastCharPercentSign(expression) ||
          isLastCharCloseParenthesis(expression)) {
        expression += '\u00D7(';
      } else if (isLastCharMathOperator(expression)) {
        expression += '(';
      }
      _openingParentheses++;
    } else {
      if (isLastCharNumber(expression) ||
          isLastCharPercentSign(expression) ||
          isLastCharCloseParenthesis(expression)) {
        expression += ')';
        _closedParentheses++;
      } else if (isLastCharMathOperator(expression) ||
          isLastCharOpenParenthesis(expression)) {
        expression += '(';
        _openingParentheses++;
      }
    }
    return expression;
  }

  void clear() => emit(MathExpression('', ''));

  void add(String char) {
    if (!allowCharacter(state.expression, char)) return;

    final newExpression = state.expression + char;

    emit(MathExpression(
        newExpression, _evaluate(newExpression) ?? state.result));
  }

  void update() {
    final result = _evaluate(state.expression);

    emit(MathExpression(result, result));
  }

  void deleteChar() {
    final finalExpression =
        state.expression.substring(0, state.expression.length - 1);

    emit(MathExpression(finalExpression, _evaluate(finalExpression)));
  }

  void addParenthesis() {
    final hasOpenParentheses = _openingParentheses > _closedParentheses;
    final finalExpression =
        _decideWhichParenthesis(state.expression, hasOpenParentheses);

    final result = _evaluate(finalExpression);
    emit(MathExpression(finalExpression, result));
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
