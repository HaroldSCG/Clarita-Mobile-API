class Validators {
  static String? required(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Campo obligatorio";
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.isEmpty) return "Correo obligatorio";

    final regex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
    if (!regex.hasMatch(value)) return "Correo inválido";

    return null;
  }

  static String? minLength(String? value, int min) {
    if (value == null || value.length < min) {
      return "Mínimo $min caracteres";
    }
    return null;
  }
}
