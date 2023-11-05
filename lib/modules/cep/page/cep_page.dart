import 'package:cep_flutter/modules/cep/page/cep_edit_page.dart';
import 'package:cep_flutter/modules/cep/page/cep_modal_page.dart';
import 'package:cep_flutter/modules/cep/model/cep_model.dart';
import 'package:cep_flutter/modules/cep/service/cep_sevice.dart';
import 'package:flutter/material.dart';
import 'package:top_modal_sheet/top_modal_sheet.dart';

class CepPage extends StatefulWidget {
  const CepPage({super.key});

  @override
  State createState() => _CepPageState();
}

class _CepPageState extends State<CepPage> {
  
  late CepBackFoAppService _cepBackFoAppService;
  late List<CepModel> listaCep;
  late bool carregando;

  @override
  void initState() {
    super.initState();
    _cepBackFoAppService = CepBackFoAppService();
    listaCep = [];
    carregando = false;
    obterCep();
  }

  void obterCep() async {
    
    setState(() {
      carregando = true;
    });

    listaCep = await _cepBackFoAppService.obterTodosCep();

    setState(() {
      carregando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Busca Cep'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await showTopModalSheet<String?>(context, CepModalPage());
            setState(() {
              obterCep();
            });
          },
          tooltip: 'Create',
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          color: Colors.blue,
          child: IconTheme(
            data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
            child: Container(height: 45),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              carregando
                  ? Center(child: CircularProgressIndicator())
                  : Expanded(
                      child: ListView.builder(
                          itemCount: listaCep.length,
                          itemBuilder: (BuildContext bc, int index) {
                            var dados = listaCep[index];
                            var local =
                                "${dados.localidade ?? ""} - ${dados.uf ?? ""}";
                            var cep = dados.cep.toString();
                            var letra =
                                dados.localidade.toString().substring(0, 1);
                            return Column(
                              children: [
                                Dismissible(
                                  direction: DismissDirection.endToStart,
                                  onDismissed: (DismissDirection
                                      dismissDirection) async {
                                    await _cepBackFoAppService
                                        .remover(dados.id.toString());
                                    //obterCep();
                                  },
                                  background: Container(
                                    color: Colors.red,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: const [
                                          Icon(Icons.delete_forever,
                                              color: Colors.white),
                                          SizedBox(
                                            width: 8.0,
                                          ),
                                          Text(
                                            'Remover',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  key: Key(dados.cep.toString()),
                                  child: ListTile(
                                    leading: CircleAvatar(child: Text(letra)),
                                    title: Text(local),
                                    subtitle: Text(cep),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CepEditPage(
                                            cepEdit: dados,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Divider(height: 0),
                              ],
                            );
                          }),
                    ),
            ],
          ),
        ));
  }
}
