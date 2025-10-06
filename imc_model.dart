import 'package:hive/hive.dart';

part 'imc_model.g.dart';

@HiveType(typeId: 0)
class IMC extends HiveObject {
  @HiveField(0)
  double peso;

  @HiveField(1)
  double altura;

  @HiveField(2)
  DateTime data;

  @HiveField(3)
  double resultado;

  IMC({
    required this.peso,
    required this.altura,
    required this.data,
    required this.resultado,
  });

  String get classificacao {
    if (resultado < 18.5) return 'Abaixo do peso';
    if (resultado < 25) return 'Peso ideal';
    if (resultado < 30) return 'Sobrepeso';
    if (resultado < 35) return 'Obesidade grau I';
    if (resultado < 40) return 'Obesidade grau II';
    return 'Obesidade grau III';
  }

  // Cor por classificação
  int get cor => resultado < 18.5
      ? 0xFF2196F3
      : resultado < 25
          ? 0xFF4CAF50
          : resultado < 30
              ? 0xFFFFC107
              : resultado < 35
                  ? 0xFFFF9800
                  : resultado < 40
                      ? 0xFFF44336
                      : 0xFF9C27B0;
}
