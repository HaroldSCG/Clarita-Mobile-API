class UserModel {
  final int id;
  final String nombre;
  final String correo;
  final String rol;
  final bool estado;

  UserModel({
    required this.id,
    required this.nombre,
    required this.correo,
    required this.rol,
    required this.estado,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      nombre: json['nombre'] ?? '',
      correo: json['correo'] ?? '',
      rol: json['rol'] ?? '',
      estado: json['estado'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "correo": correo,
        "rol": rol,
        "estado": estado,
      };
}
