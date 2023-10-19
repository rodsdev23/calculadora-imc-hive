import 'package:calculadora_imc_hive/model/imc_model.dart';
import 'package:calculadora_imc_hive/my_app.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(IMCAdapter());

  runApp(const MyApp());
}
