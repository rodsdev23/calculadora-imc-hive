import 'package:calculadora_imc_hive/pages/imc_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../repositories/imc_repository.dart';

class AlturaConfiguracaoPage extends StatefulWidget {
  const AlturaConfiguracaoPage({super.key});
  @override
  State<AlturaConfiguracaoPage> createState() => _AlturaConfiguracaoPageState();
}

class _AlturaConfiguracaoPageState extends State<AlturaConfiguracaoPage> {
  final TextEditingController alturaController = TextEditingController();
  final IMCRepository imcRepository = IMCRepository();
  final _decimalRegExp =
      RegExp(r'^\d+(\.\d{0,2})?$'); // Permite até 2 casas decimais

  bool validateAlturaInput() {
    return alturaController.text.isNotEmpty &&
        double.tryParse(alturaController.text) != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuração de Altura'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                readOnly: false,
                enabled: true,
                controller: alturaController,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(_decimalRegExp)
                ],
                decoration: const InputDecoration(
                  isDense: true,
                  labelText: "Altura",
                  hintText: "Digite sua altura em metros (Ex.: 1.80):",
                  labelStyle:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                salvarAltura();
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => IMCHomePage()));
              },
              child: const Text('Salvar Altura'),
            ),
          ],
        ),
      ),
    );
  }

  void salvarAltura() async {
    final double altura = double.tryParse(alturaController.text) ?? 0.0;
    await imcRepository.saveHeight(altura);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Altura Salva'),
          content: Text('A altura foi configurada com sucesso.'),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Fechar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
