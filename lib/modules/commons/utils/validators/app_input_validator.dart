class AppInputValidator {
  AppInputValidator._();

  static String? empty(String? value, {String? message}) {
    if (value == null || value.trim().isEmpty) {
      return message ?? "Este campo é obrigatório";
    }
    return null;
  }

  static String? email(String? value, {String? message}) {
    final emailRegex = RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    );
    final isEmpty = empty(value, message: message);

    if (isEmpty != null) {
      return isEmpty;
    }

    if (!emailRegex.hasMatch(value!)) {
      return message ?? "Digite um e-mail válido";
    }

    return null;
  }

  static String? password(String? value, {String? message, int minLength = 8}) {
    final hasLetterRegex = RegExp(r"[a-zA-Z]");
    final hasNumberRegex = RegExp(r"[0-9]");
    final isEmpty = empty(value, message: message);

    if (isEmpty != null) {
      return isEmpty;
    }

    if (value!.length < minLength) {
      return message ?? "A senha deve ter no mínimo $minLength caracteres";
    }

    if (!hasLetterRegex.hasMatch(value)) {
      return message ?? "A senha deve conter ao menos uma letra";
    }

    if (!hasNumberRegex.hasMatch(value)) {
      return message ?? "A senha deve conter ao menos um número";
    }

    return null;
  }

  static String? Function(String?) confirmPassword(
    String Function() getPassword, {
    String? message,
  }) {
    return (String? value) {
      final isEmpty = empty(value, message: message);

      if (isEmpty != null) {
        return isEmpty;
      }

      if (value != getPassword()) {
        return message ?? "As senhas não coincidem";
      }

      return null;
    };
  }
}
