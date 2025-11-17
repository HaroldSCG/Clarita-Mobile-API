class CombustibleModel {
  final int id;
  final int camionId;
  final String gasolinera;
  final double litros;
  final double precio;
  final String fechaCarga;
  final int kilometrajeInicial;
  final int kilometrajeFinal;

  CombustibleModel({
    required this.id,
    required this.camionId,
    required this.gasolinera,
    required this.litros,
    required this.precio,
    required this.fechaCarga,
    required this.kilometrajeInicial,
    required this.kilometrajeFinal,
  });

  factory CombustibleModel.fromJson(Map<String, dynamic> json) {
    return CombustibleModel(
      id: json['id'] ?? 0,
      camionId: json['camionId'] ?? 0,
      gasolinera: json['gasolinera'] ?? "",
      litros: (json['litros'] ?? 0).toDouble(),
      precio: (json['precio'] ?? 0).toDouble(),
      fechaCarga: json['fechaCarga'] ?? "",
      kilometrajeInicial: json['kilometrajeInicial'] ?? 0,
      kilometrajeFinal: json['kilometrajeFinal'] ?? 0,
    );
  }

  /// NECESARIO PARA REGISTRAR COMBUSTIBLE
  Map<String, dynamic> toJson() {
    return {
      "camionId": camionId,
      "gasolinera": gasolinera,
      "litros": litros,
      "precio": precio,
      "fechaCarga": fechaCarga,
      "kilometrajeInicial": kilometrajeInicial,
      "kilometrajeFinal": kilometrajeFinal,
    };
  }
}