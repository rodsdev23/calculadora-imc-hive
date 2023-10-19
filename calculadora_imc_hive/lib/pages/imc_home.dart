import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../model/imc_model.dart';
import '../repositories/imc_repository.dart';
import 'configuracoes/configuracoes_page.dart';

class IMCHomePage extends StatefulWidget {
  const IMCHomePage({Key? key}) : super(key: key);

  @override
  State<IMCHomePage> createState() => _IMCHomePageState();
}

class _IMCHomePageState extends State<IMCHomePage> {
  final _decimalRegExp =
      RegExp(r'^\d+(\.\d{0,2})?$'); // Permite até 2 casas decimais
  final IMCRepository imcRepository = IMCRepository();
  final TextEditingController pesoController = TextEditingController();
  final TextEditingController nomeController = TextEditingController();
  double altura = 0.0;
  double imc = 0.0;
  late String nome = "";
  late String classificacao = '';
  List<Widget> historicoIMC = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carregarDados();
  }

  carregarDados() async {
    // historicoIMC = await imcRepository.getIMCHistory();
    // print(historicoIMC);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de IMC'),
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      controller: nomeController,
                      decoration: const InputDecoration(
                        isDense: true,
                        labelText: "Nome:",
                        labelStyle: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                        hintText: "Digite seu nome:",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      controller: pesoController,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(_decimalRegExp)
                      ],
                      decoration: const InputDecoration(
                        isDense: true,
                        labelText: "Peso",
                        labelStyle: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                        hintText: "Digite seu peso em Kg (Ex.: 82.5):",
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      var tempAltura = await imcRepository.getHeight();
                      calcularIMC(tempAltura);
                      _saveIMC();
                      classificacao = imcRepository.resultadoImc(imc);
                      nome = nomeController.text;
                      setState(() {});
                    },
                    child: const Text('Calcular IMC'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _loadHeight();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => AlturaConfiguracaoPage()));
                    },
                    child: const Text('Configurações de Altura'),
                  ),
                  const Text('Histórico IMC'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                Text(
                  'Nome: $nome',
                  style: const TextStyle(fontSize: 16),
                ),
                Text('IMC: ${imc.toStringAsFixed(2)}'),
                Text('classificação IMC: $classificacao'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void calcularIMC(double altura) {
    final double peso = double.tryParse(pesoController.text) ?? 0.0;
    setState(() {
      imc = peso / (altura * altura);
    });
  }

  void _saveIMC() async {
    final IMC novoIMC =
        IMC(double.tryParse(pesoController.text) ?? 0.0, altura);
    await imcRepository.saveIMC(novoIMC);
    nome = nomeController.text;
  }

  void _loadHeight() async {
    final double altura = await imcRepository.getHeight();
    if (altura != 0.0) {
      setState(() {
        this.altura = altura;
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Altura não configurada'),
            content: Text('Configure sua altura antes de calcular o IMC.'),
            actions: <Widget>[
              ElevatedButton(
                  child: Text('Fechar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ],
          );
        },
      );
    }
  }
}
