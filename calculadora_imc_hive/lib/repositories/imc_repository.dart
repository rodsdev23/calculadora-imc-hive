import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../model/imc_model.dart';

class IMCRepository {
  final String _imcBox = 'imcBox';

  Future<void> saveIMC(IMC imc) async {
    final box = await Hive.openBox<IMC>(_imcBox);
    await box.add(imc);
  }

  Future<List<IMC>> getIMCHistory() async {
    final box = await Hive.openBox<IMC>(_imcBox);
    return box.values.toList();
  }

  Future<void> saveListHistory(List historicoIMC) async {
    final box = await Hive.openBox(_imcBox);
    await box.put(_imcBox, historicoIMC);
    print(box);
  }

  Future<double> getHeight() async {
    final box = await Hive.openBox('alturaBox');
    return box.get('altura', defaultValue: 0.0);
  }

  Future<void> saveHeight(double altura) async {
    final box = await Hive.openBox('alturaBox');
    await box.put('altura', altura);
  }

  Future<Widget> buildIMCCard(List historico) async {
    final box = await Hive.openBox<IMC>(_imcBox);
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        subtitle: Text('${box.values.toList()}'),
      ),
    );
  }

  String resultadoImc(double imc) {
    String classificacao = "";
    if (imc < 16) {
      classificacao = 'Magreza grave';
    } else if (imc < 17) {
      classificacao = 'Magreza moderada';
    } else if (imc < 18.5) {
      classificacao = 'Magreza leve';
    } else if (imc < 25) {
      classificacao = 'Saudável';
    } else if (imc < 30) {
      classificacao = 'Sobrepeso';
    } else if (imc < 35) {
      classificacao = 'Obesidade – GRAU I';
    } else if (imc < 40) {
      classificacao = 'Obesidade – GRAU II | Severa';
    } else if (imc > 40) {
      classificacao = 'Obesidade – GRAU III | Mórbida';
    } else {
      return "Não classificado.";
    }
    return classificacao;
  }
}
