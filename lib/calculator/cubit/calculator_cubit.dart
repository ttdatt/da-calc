import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:math_expressions/math_expressions.dart';
import './utils.dart';

class MathExpression {
  String expression;
  String result;
  MathExpression(this.expression, this.result);
}

class CalculatorCubit extends Cubit<MathExpression> {
  final Parser _p = Parser();
  final ContextModel _cm = ContextModel();
  final NumberFormat _numberFormatter = NumberFormat('###.######');
  var _openingParentheses = 0;
  var _closedParentheses = 0;

  CalculatorCubit() : super(MathExpression('', ''));

  dynamic _evaluate(String expression) {
    final finalExpression =
        expression.replaceAll('%', '/100').replaceAll('\u00D7', '*').replaceAll('\u00F7', '/');
    try {
      Expression exp = _p.parse(finalExpression);
      var result = exp.evaluate(EvaluationType.REAL, _cm);
      result = _numberFormatter.format(result);
      return result;
    } on FormatException catch (e) {
      debugPrint(e.toString());
    } catch (e) {
      debugPrint('something went wrong ${e.toString()}');
    }
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
      } else if (isLastCharMathOperator(expression) || isLastCharOpenParenthesis(expression)) {
        expression += '(';
        _openingParentheses++;
      }
    }
    return expression;
  }

  void clear() {
    _openingParentheses = 0;
    _closedParentheses = 0;
    emit(MathExpression('', ''));
  }

  void add(String char) {
    if (!allowCharacter(state.expression, char)) return;

    final newExpression = state.expression + char;

    emit(MathExpression(newExpression, _evaluate(newExpression) ?? state.result));
  }

  void update() {
    final result = _evaluate(state.expression);

    emit(MathExpression(result, result));
  }

  void deleteChar() {
    if (state.expression.isEmpty) return;

    final lastChar = state.expression[state.expression.length - 1];
    if (isLastCharCloseParenthesis(lastChar)) {
      _closedParentheses--;
    } else if (isLastCharOpenParenthesis(lastChar)) {
      _openingParentheses--;
    }
    final finalExpression = state.expression.substring(0, state.expression.length - 1);

    emit(
        MathExpression(finalExpression, finalExpression.isEmpty ? '' : _evaluate(finalExpression)));
  }

  void addParenthesis() {
    final hasOpenParentheses = _openingParentheses > _closedParentheses;
    final finalExpression = _decideWhichParenthesis(state.expression, hasOpenParentheses);

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
