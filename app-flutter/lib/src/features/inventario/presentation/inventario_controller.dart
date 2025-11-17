import 'package:flutter/material.dart';
import '../../../core/models/producto_model.dart';
import '../data/inventario_api.dart';

class InventarioController extends ChangeNotifier {
  List<ProductoModel> items = [];
  bool loading = false;
  String? error;

  Future<void> load() async {
    try {
      loading = true;
      notifyListeners();
      error = null;

      final data = await inventarioAPI.getAll();
      items = data.map((e) => ProductoModel.fromJson(e)).toList();

      loading = false;
      notifyListeners();
    } catch (e) {
      error = e.toString();
      loading = false;
      notifyListeners();
    }
  }
}

final inventarioController = InventarioController();