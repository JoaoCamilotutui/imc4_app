import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/imc_model.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(IMCAdapter());

  await Hive.openBox<IMC>('imc_box');
  await Hive.openBox<double>('config_box');

  runApp(const IMCApp());
}

class IMCApp extends StatelessWidget {
  const IMCApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove faixa debug
      title: 'Calculadora IMC 4',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const HomeScreen(),
    );
  }
}
