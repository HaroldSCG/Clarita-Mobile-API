class PedidoModel {
  final int id;
  final String codigo;
  final String clienteNombre;
  final String direccion;
  final String nit;
  final String estado;
  final String fecha;

  PedidoModel({
    required this.id,
    required this.codigo,
    required this.clienteNombre,
    required this.direccion,
    required this.nit,
    required this.estado,
    required this.fecha,
  });

  factory PedidoModel.fromJson(Map<String, dynamic> json) {
    return PedidoModel(
      id: json['id'] ?? 0,
      codigo: json['codigo'] ?? "",
      clienteNombre: json['clienteNombre'] ?? "",
      direccion: json['direccion'] ?? "",
      nit: json['nit'] ?? "",
      estado: json['estado'] ?? "",
      fecha: json['fecha'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "codigo": codigo,
      "clienteNombre": clienteNombre,
      "direccion": direccion,
      "nit": nit,
      "estado": estado,
      "fecha": fecha,
    };
  }
}
