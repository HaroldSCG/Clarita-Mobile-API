class ProductoModel {
  final int id;
  final String codigo;
  final String nombre;
  final String descripcion;
  final double precioVenta;
  final int stockActual;
  final int stockMinimo;
  final String unidadMedida;
  final String? categoria;
  final String? proveedor;

  ProductoModel({
    required this.id,
    required this.codigo,
    required this.nombre,
    required this.descripcion,
    required this.precioVenta,
    required this.stockActual,
    required this.stockMinimo,
    required this.unidadMedida,
    this.categoria,
    this.proveedor,
  });

  factory ProductoModel.fromJson(Map<String, dynamic> json) {
    return ProductoModel(
      id: json['id'] ?? 0,
      codigo: json['codigo'] ?? "",
      nombre: json['nombre'] ?? "",
      descripcion: json['descripcion'] ?? "",
      precioVenta: (json['precioVenta'] ?? 0).toDouble(),
      stockActual: json['stockActual'] ?? 0,
      stockMinimo: json['stockMinimo'] ?? 0,
      unidadMedida: json['unidadMedida'] ?? "",
      categoria: json['categoria']?['nombre'],
      proveedor: json['proveedor']?['nombre'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'codigo': codigo,
      'nombre': nombre,
      'descripcion': descripcion,
      'precioVenta': precioVenta,
      'stockActual': stockActual,
      'stockMinimo': stockMinimo,
      'unidadMedida': unidadMedida,
      'categoria': categoria,
      'proveedor': proveedor,
    };
  }
}