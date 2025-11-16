class PedidoModel {
  final int id;
  final String cliente;
  final double total;

  PedidoModel({
    required this.id,
    required this.cliente,
    required this.total,
  });

  factory PedidoModel.fromMap(Map<String, dynamic> map) {
    return PedidoModel(
      id: map['id'],
      cliente: map['cliente'],
      total: double.tryParse(map['total'].toString()) ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cliente': cliente,
      'total': total,
    };
  }
}
