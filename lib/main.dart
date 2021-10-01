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
  MainPage({Key key}) : super(key: key);
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.blue),
        leading: IconButton(
          icon: Icon(Icons.menu, size: 40), // change this size and style
          onPressed: () => _scaffoldKey.currentState.openDrawer(),
        ),
      ),
      drawer: MainDrawer(),
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
