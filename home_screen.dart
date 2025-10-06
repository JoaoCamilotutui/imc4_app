import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/imc_model.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _pesoController = TextEditingController();
  late Box<IMC> _imcBox;
  late Box<double> _configBox;
  double _altura = 1.70;

  @override
  void initState() {
    super.initState();
    _imcBox = Hive.box<IMC>('imc_box');
    _configBox = Hive.box<double>('config_box');
    _altura = _configBox.get('altura', defaultValue: 1.70)!;
  }

  void _calcularIMC() {
    final peso = double.tryParse(_pesoController.text);
    if (peso == null || peso <= 0) return;

    final resultado = peso / (_altura * _altura);

    final imc = IMC(
      peso: peso,
      altura: _altura,
      resultado: resultado,
      data: DateTime.now(),
    );

    _imcBox.add(imc);
    setState(() {});
  }

  void _limparHistorico() async {
    await _imcBox.clear();
    setState(() {});
  }

  List<FlSpot> get _spots {
    final imcs = _imcBox.values.toList();
    return List.generate(imcs.length, (i) => FlSpot(i.toDouble(), imcs[i].resultado));
  }

  @override
  Widget build(BuildContext context) {
    final imcs = _imcBox.values.toList().reversed.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora IMC 4'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () async {
              final novaAltura = await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              );
              if (novaAltura != null) setState(() => _altura = novaAltura);
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: _limparHistorico,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _pesoController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Peso (kg)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _calcularIMC,
              child: const Text('Calcular IMC'),
            ),
            const SizedBox(height: 16),
            if (_imcBox.isNotEmpty) SizedBox(
              height: 200,
              child: LineChart(   // ⬅️ INÍCIO DO TRECHO A SER SUBSTITUÍDO
                LineChartData(
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 1, // mostra menos valores no eixo X
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toInt().toString(),
                            style: const TextStyle(fontSize: 10, color: Colors.grey),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 28, // dá mais espaço pro eixo Y
                        interval: 2, // reduz a quantidade de valores exibidos
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toStringAsFixed(1),
                            style: const TextStyle(fontSize: 10, color: Colors.grey),
                          );
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      spots: _spots,
                      isCurved: true,
                      color: Colors.blue,
                      barWidth: 3,
                      dotData: FlDotData(show: true),
                    ),
                  ],
                ),
              ),   // ⬅️ FIM DO TRECHO A SER SUBSTITUÍDO
            ),
            const SizedBox(height: 16),
            const Divider(),
            const Text(
              'Histórico de IMCs',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: imcs.length,
                itemBuilder: (context, index) {
                  final imc = imcs[index];
                  return Card(
                    color: Color(imc.cor),
                    child: ListTile(
                      title: Text(
                        'IMC: ${imc.resultado.toStringAsFixed(2)} - ${imc.classificacao}',
                        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      subtitle: Text(
                        'Peso: ${imc.peso} kg | Altura: ${imc.altura} m\n'
                        'Data: ${imc.data.toLocal()}',
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
