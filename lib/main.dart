import 'package:flutter/material.dart';
import 'package:state_management_examples/widgets/main_drawer.dart';

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
  const MainPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MAIN PAGE'),
        centerTitle: true,
      ),
      drawer: MainDrawer(),
      body: Center(
        child: Container(
          child: Text('THIS IS MAIN PAGE'),
        ),
      ),
    );
  }
}
