import 'package:cep_flutter/enum/base_url_enum.dart';
import 'package:cep_flutter/modules/cep/model/cep_model.dart';
import 'package:cep_flutter/service/http_service.dart';

class ViaCepRepositoy {

 static final _dio = httpService(baseUrl: BaseUrlEnum.VIACEP,).getDio();

  static Future<CepModel> get(String url) async {
   
    final result = await _dio.get(url);

    if(result.statusCode == 200) {
      return CepModel.fromJson(result.data);
    }
    return  CepModel();
  }

}
