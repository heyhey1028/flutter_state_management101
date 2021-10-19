import 'package:flutter/material.dart';
import 'package:state_management_examples/widgets/main_drawer.dart';

class MainScaffold extends StatelessWidget {
  MainScaffold({
    Key key,
    @required this.body,
  }) : super(key: key);
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  final Widget body;

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
      body: body,
    );
  }
}
