class CombustibleModel {
  final int id;
  final int camionId;
  final double litros;
  final String fecha;

  CombustibleModel({
    required this.id,
    required this.camionId,
    required this.litros,
    required this.fecha,
  });

  factory CombustibleModel.fromMap(Map<String, dynamic> json) {
    return CombustibleModel(
      id: json['id'],
      camionId: json['camionId'],
      litros: double.tryParse(json['litros'].toString()) ?? 0,
      fecha: json['fecha'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'camionId': camionId,
      'litros': litros,
      'fecha': fecha,
    };
  }
}
