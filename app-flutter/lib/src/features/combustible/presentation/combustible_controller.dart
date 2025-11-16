import '../../combustible/data/combustible_api.dart';
import '../../../core/storage/dao/combustible_dao.dart';
import '../../../core/models/combustible_model.dart';

class CombustibleController {
  bool loading = false;
  String? error;
  List<CombustibleModel> lista = [];

  Future<void> cargar() async {
    loading = true;
    error = null;

    try {
      final data = await combustibleAPI.getRegistros();

      lista = data
          .map((e) => CombustibleModel.fromMap(e as Map<String, dynamic>))
          .toList();

      await CombustibleDao().replaceAll(lista);

    } catch (e) {
      error = e.toString();
    }

    loading = false;
  }
}

final combustibleController = CombustibleController();
