import 'package:flutter/material.dart';
import 'package:state_management_examples/widgets/main_scaffold.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter State Managements',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      body: Center(
        child: Container(
          child: Text(
            'THANKS FOR VISITING!!\n' 'THIS IS MAIN PAGE',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
