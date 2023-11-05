import 'package:brasil_fields/brasil_fields.dart';
import 'package:cep_flutter/modules/cep/model/cep_model.dart';
import 'package:cep_flutter/modules/cep/service/cep_sevice.dart';
import 'package:cep_flutter/modules/via_cep/service/via_cep_service.dart';
import 'package:flutter/material.dart';

class CepModalPage extends StatefulWidget {
  const CepModalPage({super.key});

  @override
  State createState() => _CepModalPageState();
}

class _CepModalPageState extends State<CepModalPage> {
  late TextEditingController _controllerCep;
  late bool _loading;
  late bool _cadastrar;
  late bool _retornoSave;
  late bool _savepress;
  late bool _encontrado;
  late ViaCepService _viaCepService;
  late CepModel _viacepModel;
  late CepBackFoAppService _cepBackFoAppService;
  late CepModel _backcepModel;

  @override
  void initState() {
    super.initState();

    _viaCepService = ViaCepService();
    _viacepModel = CepModel();
    _cepBackFoAppService = CepBackFoAppService();
    _backcepModel = CepModel();

    _controllerCep = TextEditingController(text: "");
    _loading = false;
    _cadastrar = true;
    _retornoSave = false;
    _savepress = false;
    _encontrado = true;
  }

  @override
  void dispose() {
    _controllerCep.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 10),
            child: const Text("Informe um CEP",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.center),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 20),
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: _controllerCep,
                    keyboardType: TextInputType.number,
                    onChanged: (String value) async {
                      var cep = value.replaceAll(new RegExp(r'[^0-9]'), '');
                      var find = true;
                      if (cep.length == 8) {
                        FocusScope.of(context).unfocus();

                        setState(() {
                          _loading = true;
                        });

                        _backcepModel = await _cepBackFoAppService.obterCep(
                            UtilBrasilFields.obterCep(cep, ponto: false));

                        if (_backcepModel.cep == null) {
                          _viacepModel = await _viaCepService.obterCep(cep);
                        }

                        if (_backcepModel.cep == null &&
                            _viacepModel.cep == null) {
                          find = false;
                        }
                      }

                      setState(() {
                        _encontrado = find;
                        _loading = false;

                        if (_savepress) {
                          _savepress = false;
                          _retornoSave = false;
                          _cadastrar = false;
                        }
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          if (_loading)
            textLine(
              CircularProgressIndicator(),
            ),
          if (!_encontrado &&
              _backcepModel.cep == null &&
              _viacepModel.cep == null)
            textLine(
              Text(
                "Cep não existe ou não encontrado",
                style: TextStyle(fontSize: 18, color: Colors.red),
              ),
            ),
          if (!_loading && _backcepModel.cep != null)
            textLine(
              Text(
                "CEP já cadastrado",
                style: TextStyle(fontSize: 18, color: Colors.green),
              ),
            ),
          if (!_loading && _viacepModel.cep != null)
            textLine(
              Text(
                "${_viacepModel.localidade ?? ""} - ${_viacepModel.uf ?? ""}",
                style: TextStyle(fontSize: 22),
              ),
            ),
          if (!_loading &&
              _backcepModel.cep == null &&
              _viacepModel.cep != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10, left: 10, right: 10, bottom: 10),
                    child: Column(
                      children: [
                        if (_cadastrar)
                          Center(
                            child: Text(
                              "Cep não cadastrado, Deseja cadastrar ?",
                              style: TextStyle(
                                  fontSize: 18, color: Colors.deepOrange),
                            ),
                          ),
                        if (_cadastrar)
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: OutlinedButton(
                              onPressed: () async {
                                var salvou = await _cepBackFoAppService
                                    .criar(_viacepModel);

                                Navigator.pop(context);
                                if (!salvou) {
                                  msgReturn(context, "Erro ao salvar Cep",
                                      Colors.red);
                                }
                              },
                              child: const Text('Cadastrar'),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> msgReturn(
      BuildContext context, String texto, Color cor) {
    return ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Salvo com Sucesso!",
          style: TextStyle(fontSize: 18, color: Colors.green),
        ),
      ),
    );
  }

  Row textLine(Widget text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 20),
            child: Center(
              child: text,
            ),
          ),
        ),
      ],
    );
  }
}
