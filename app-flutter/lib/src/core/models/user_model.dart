class UserModel {
  final int id;
  final String nombre;
  final String correo;
  final String rol;

  UserModel({
    required this.id,
    required this.nombre,
    required this.correo,
    required this.rol,
  });

  factory UserModel.fromMap(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      nombre: json['nombre'],
      correo: json['correo'],
      rol: json['rol'] ?? '',
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'nombre': nombre,
        'correo': correo,
        'rol': rol,
      };
}
