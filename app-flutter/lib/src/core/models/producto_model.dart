class ProductoModel {
  final int id;
  final String nombre;
  final int stock;
  final double precio;

  ProductoModel({
    required this.id,
    required this.nombre,
    required this.stock,
    required this.precio,
  });

  factory ProductoModel.fromMap(Map<String, dynamic> json) {
    return ProductoModel(
      id: json['id'],
      nombre: json['nombre'],
      stock: json['stock'],
      precio: double.tryParse(json['precio'].toString()) ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'stock': stock,
      'precio': precio,
    };
  }
}
