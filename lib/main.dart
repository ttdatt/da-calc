import 'package:flutter/material.dart';
import './calculator/calculator.dart';
// import 'package:da_calc/calculator_observer.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  // Bloc.observer = const CalculatorObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Basic Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CalculatorWidget(),
    );
  }
}
