import 'package:cep_flutter/modules/cep/model/cep_model.dart';
import 'package:cep_flutter/modules/cep/service/cep_sevice.dart';
import 'package:flutter/material.dart';

class CepEditPage extends StatefulWidget {
  final CepModel cepEdit;
  const CepEditPage({Key? key, required this.cepEdit}) : super(key: key);

  @override
  State<CepEditPage> createState() => _CepEditPageState();
}

class _CepEditPageState extends State<CepEditPage> {
  late TextEditingController _controllerCep;
  late TextEditingController _controllerLogradouro;
  late TextEditingController _controlleComplemento;
  late TextEditingController _controllerBairro;
  late TextEditingController _controllerLocalidade;
  late TextEditingController _controllerUf;
  late TextEditingController _controllerIbge;
  late TextEditingController _controllerDdd;
  late CepBackFoAppService _cepBackFoAppService;

  @override
  void initState() {
    _cepBackFoAppService = CepBackFoAppService();
    super.initState();

    _controllerCep =
        TextEditingController(text: widget.cepEdit.cep.toString());
    _controllerLogradouro =
        TextEditingController(text: widget.cepEdit.logradouro.toString());
    _controlleComplemento =
        TextEditingController(text: widget.cepEdit.complemento.toString());
    _controllerBairro =
        TextEditingController(text: widget.cepEdit.bairro.toString());
    _controllerLocalidade =
        TextEditingController(text: widget.cepEdit.localidade.toString());
    _controllerUf = TextEditingController(text: widget.cepEdit.uf.toString());
    _controllerIbge =
        TextEditingController(text: widget.cepEdit.ibge.toString());
    _controllerDdd = TextEditingController(text: widget.cepEdit.ddd.toString());
  }

  @override
  void dispose() {
    _controllerCep.dispose();
    _controllerLogradouro.dispose();
    _controlleComplemento.dispose();
    _controllerBairro.dispose();
    _controllerLocalidade.dispose();
    _controllerUf.dispose();
    _controllerIbge.dispose();
    _controllerDdd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Editando Cep'),
      ),
      body: Container(
        child: ListView(
          padding: EdgeInsets.only(top: 10),
          children: [
            inputText("Cep", _controllerCep, true),
            inputText("Logradouro", _controllerLogradouro, false),
            inputText("Complemento", _controlleComplemento, false),
            inputText("Bairro", _controllerBairro, false),
            inputText("Localidade", _controllerLocalidade, true),
            inputText("UF", _controllerUf, true),
            inputText("IBGE", _controllerIbge, true),
            inputText("DDD", _controllerDdd, true),
            Container(
              margin: EdgeInsets.only(top: 10, right: 10, left: 10),
              child: Padding(
                padding: EdgeInsets.only(right: 50, left: 50),
                child: ElevatedButton(
                  onPressed: () async {

                    widget.cepEdit.logradouro = _controllerLogradouro.text.trim();
                    widget.cepEdit.complemento = _controlleComplemento.text.trim();
                    widget.cepEdit.bairro = _controllerBairro.text.trim();
           
                    await _cepBackFoAppService.atualizar(widget.cepEdit);

                    Navigator.pop(context);
                  },
                  child: const Text('Atualizar'),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Padding inputText(String label, TextEditingController controller, bool leitura) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 8),
      child: SizedBox(
        height: 45,
        child: TextField(
          readOnly: leitura,
          controller: controller,
          obscureText: false,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: label,
          ),
        ),
      ),
    );
  }
}
