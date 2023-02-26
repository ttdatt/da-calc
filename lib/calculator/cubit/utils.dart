enum CharacterType {
  number(1 << 1),
  percentSign(1 << 2),
  mathOperator(1 << 3),
  openParenthesis(1 << 4),
  closeParenthesis(1 << 5);

  const CharacterType(this.value);
  final int value;
}

bool isLastCharMathOperator(String expression) {
  if (expression.isEmpty) return false;

  var lastChar = expression[expression.length - 1];
  final result = lastChar == '-' ||
      lastChar == '+' ||
      lastChar == '\u00F7' ||
      lastChar == '\u00D7';
  return result;
}

bool isLastCharPercentSign(String expression) {
  if (expression.isEmpty) return false;

  return expression[expression.length - 1] == '%';
}

bool isLastCharNumber(String expression) {
  if (expression.isEmpty) return false;

  var lastChar = expression[expression.length - 1];
  try {
    return num.parse(lastChar) is int;
  } catch (e) {
    return false;
  }
}

bool isLastCharOpenParenthesis(String expression) {
  if (expression.isEmpty) return false;
  return expression[expression.length - 1] == '(';
}

bool isLastCharCloseParenthesis(String expression) {
  if (expression.isEmpty) return false;
  return expression[expression.length - 1] == ')';
}

bool isLastCharParenthesis(String expression) {
  return isLastCharOpenParenthesis(expression) ||
      isLastCharCloseParenthesis(expression);
}

int allowNextCharacter(String expression) {
  var result = 0;
  if (expression.isEmpty ||
      isLastCharNumber(expression) ||
      isLastCharMathOperator(expression) ||
      isLastCharParenthesis(expression)) {
    result |= CharacterType.number.value;
  }
  if (isLastCharNumber(expression) ||
      isLastCharPercentSign(expression) ||
      isLastCharCloseParenthesis(expression)) {
    result |= CharacterType.mathOperator.value;
  }
  if (isLastCharNumber(expression) || isLastCharCloseParenthesis(expression)) {
    result |= CharacterType.percentSign.value;
  }
  return result;
}

bool allowCharacter(String expression, String char) {
  final result = allowNextCharacter(expression);
  return ((result & CharacterType.number.value) > 0 &&
          isLastCharNumber(char)) ||
      ((result & CharacterType.percentSign.value) > 0 &&
          isLastCharPercentSign(char)) ||
      ((result & CharacterType.mathOperator.value) > 0 &&
          isLastCharMathOperator(char));
}
