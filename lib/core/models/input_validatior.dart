abstract class InputValidator {
  bool notEmpty(String input);
}

class InputValidatorImpl implements InputValidator {
  @override
  bool notEmpty(String input) {
    if (input != null) {
      if (input.trim().isNotEmpty) return true;
    }
    return false;
  }
}
