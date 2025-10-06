import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late TextEditingController _alturaController;
  late Box<double> _configBox;

  @override
  void initState() {
    super.initState();
    _configBox = Hive.box<double>('config_box');
    double altura = _configBox.get('altura', defaultValue: 1.70)!;
    _alturaController = TextEditingController(text: altura.toString());
  }

  void _salvarAltura() {
    final novaAltura = double.tryParse(_alturaController.text);
    if (novaAltura != null && novaAltura > 0) {
      _configBox.put('altura', novaAltura);
      Navigator.pop(context, novaAltura);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configurações')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _alturaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Altura (m)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _salvarAltura,
              child: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
