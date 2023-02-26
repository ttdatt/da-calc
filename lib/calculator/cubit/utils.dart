enum CharacterType {
  number(1 << 1),
  percentSign(1 << 2),
  operator(1 << 3);

  const CharacterType(this.value);
  final int value;
}

bool isLastCharacterOperator(String expression) {
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

int allowNextCharacter(String expression) {
  var result = 0;
  if (expression.isEmpty ||
      isLastCharNumber(expression) ||
      isLastCharacterOperator(expression)) {
    result |= CharacterType.number.value;
  }
  if (isLastCharNumber(expression) || isLastCharacterPercentSign(expression)) {
    result |= CharacterType.operator.value;
  }
  if (isLastCharNumber(expression)) {
    result |= CharacterType.percentSign.value;
  }
  return result;
}

bool allowCharacter(String expression, String char) {
  final result = allowNextCharacter(expression);
  return ((result & CharacterType.number.value) > 0 &&
          isLastCharNumber(char)) ||
      ((result & CharacterType.percentSign.value) > 0 &&
          isLastCharacterPercentSign(char)) ||
      ((result & CharacterType.operator.value) > 0 &&
          isLastCharacterOperator(char));
}
