import 'package:flutter/material.dart';
import '../../../core/models/combustible_model.dart';
import '../data/combustible_api.dart';

class CombustibleController extends ChangeNotifier {
  List<CombustibleModel> items = [];
  bool loading = false;
  String? error;

  Future<void> load() async {
    try {
      loading = true;
      error = null;
      notifyListeners();

      final data = await combustibleAPI.getAll();

      items = data.map((e) => CombustibleModel.fromJson(e)).toList();

      loading = false;
      notifyListeners();
    } catch (e) {
      loading = false;
      error = e.toString();
      notifyListeners();
    }
  }

  Future<bool> registrar(CombustibleModel model) async {
    try {
      final resp = await combustibleAPI.create(model.toJson());
      if (resp["ok"] == true) {
        await load();
        return true;
      }
      return false;
    } catch (_) {
      return false;
    }
  }
}

final combustibleController = CombustibleController();