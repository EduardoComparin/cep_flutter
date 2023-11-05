
import 'package:cep_flutter/modules/cep/page/cep_page.dart';
import 'package:flutter/material.dart';

class CepApp extends StatelessWidget {
  const CepApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
 Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Busca Cep',
      debugShowCheckedModeBanner: false,
      home: const CepPage(),
    );
  }
  

}

