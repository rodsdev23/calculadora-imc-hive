import 'package:hive/hive.dart';

part 'imc_model.g.dart';

@HiveType(typeId: 1)
class IMC {
  @HiveField(0)
  double peso;

  @HiveField(1)
  double altura;

  IMC(this.peso, this.altura);

  double calcularIMC() {
    return peso / (altura * altura);
  }
}
