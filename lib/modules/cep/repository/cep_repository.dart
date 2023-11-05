import 'package:cep_flutter/modules/cep/model/cep_model.dart';
import 'package:cep_flutter/service/http_service.dart';


class CepRepositoy {
 static final _dio = httpService().getDio();

  static Future<Map<String, dynamic>> get(String url) async {

    var result = await _dio.get(url);

    Map<String, dynamic> retorno = result.data;

    return retorno;
  }

  static Future<void> create(CepModel cepModel) async {
    try {
      await _dio.post("cep", data: cepModel.toJson());
    } catch (e) {
      throw e;
    }
  }

  static Future<void> update(CepModel cepModel) async {
    try {
      await _dio.put(
          "cep/${cepModel.id}",
          data: cepModel.toJson());
    } catch (e) {
      throw e;
    }
  }

  static Future<void> remove(String id) async {
    try {
       await _dio.delete(
        "cep/$id",
      );
    } catch (e) {
      throw e;
    }
  }
}
