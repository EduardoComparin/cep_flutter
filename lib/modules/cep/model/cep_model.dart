class CepModel {

  List<CepModel> listaCep = [];

  String? id = "";
  String? cep = "";
  String? logradouro = "";
  String? complemento = "";
  String? bairro = "";
  String? localidade = "";
  String? uf = "";
  String? ibge = "";
  String? ddd = "";


  CepModel(
      {
      this.id,
       this.cep,
       this.logradouro,
       this.complemento,
       this.bairro,
       this.localidade,
       this.uf,
       this.ibge,
       this.ddd});

  CepModel.fromJson(Map<String, dynamic> json) {
    id = json['objectId'];
    cep = json['cep'];
    logradouro = json['logradouro'];
    complemento = json['complemento'];
    bairro = json['bairro'];
    localidade = json['localidade'];
    uf = json['uf'];
    ibge = json['ibge'];
    ddd = json['ddd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = id;
    data['cep'] = cep;
    data['logradouro'] = logradouro;
    data['complemento'] = complemento;
    data['bairro'] = bairro;
    data['localidade'] = localidade;
    data['uf'] = uf;
    data['ibge'] = ibge;
    data['ddd'] = ddd;
    return data;
  }

  mapFromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      listaCep = <CepModel>[];
      json['results'].forEach((v) {
        listaCep.add(CepModel.fromJson(v));
      });
    }
    return listaCep;
  }

  Map<String, dynamic> mapToJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = listaCep.map((v) => v.toJson()).toList();
    return data;
  }

}


