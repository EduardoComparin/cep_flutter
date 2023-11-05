import 'package:cep_flutter/modules/cep/model/cep_model.dart';
import 'package:cep_flutter/modules/cep/repository/cep_repository.dart';

class CepBackFoAppService {
  Future<List<CepModel>> obterTodosCep() async {
    var url = "/cep";
    try {
      Map<String, dynamic> retorno = await CepRepositoy.get(url);

      return CepModel().mapFromJson(retorno);
    } catch (e) {
      throw e;
    }
  }

  Future<CepModel> obterCep(String cep) async {
    var url = "/cep?where={\"cep\":\"$cep\"}";

    try {
      Map<String, dynamic> retorno = await CepRepositoy.get(url);

      List<CepModel> conversao = CepModel().mapFromJson(retorno);

      if (conversao.length > 0) {
        return conversao[0];
      }

      return CepModel();
    } catch (e) {
      throw e;
    }
  }

  Future<bool> criar(CepModel cepModel) async {
    try {
      await CepRepositoy.create(cepModel);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> atualizar(CepModel cepModel) async {
    try {
      await CepRepositoy.update(cepModel);
    } catch (e) {
      throw e;
    }
  }

  Future<void> remover(String id) async {
    try {
      await CepRepositoy.remove(id);
    } catch (e) {
      throw e;
    }
  }
}
