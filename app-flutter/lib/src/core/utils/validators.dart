class Validators {
  static String? required(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Este campo es obligatorio";
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) return "Correo requerido";
    if (!value.contains("@")) return "Correo inválido";
    return null;
  }

  static String? number(String? value) {
    if (value == null || value.isEmpty) return "Campo requerido";
    if (double.tryParse(value) == null) return "Debe ser un número";
    return null;
  }
}