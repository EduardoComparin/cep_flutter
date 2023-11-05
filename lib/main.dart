import 'package:cep_flutter/cep_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async{
  await dotenv.load(fileName: "assets/.env");
  runApp(const CepApp());
}


