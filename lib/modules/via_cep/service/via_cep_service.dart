import 'package:cep_flutter/modules/cep/model/cep_model.dart';
import 'package:cep_flutter/modules/via_cep/repository/via_cep_repository.dart';

class ViaCepService {
   Future<CepModel> obterCep(String cep) async {
    var url = "$cep/json/";
    
    return ViaCepRepositoy.get(url);
  }

}
