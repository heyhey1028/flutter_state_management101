import 'package:flutter/material.dart';
import 'package:state_management_examples/dependency_injections/main_page.dart';
import 'package:state_management_examples/data_classes/main_page.dart';
import 'package:state_management_examples/main.dart';
import 'package:state_management_examples/state_managements/main_page.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: [
        Container(
          height: 230,
          child: DrawerHeader(
            margin: EdgeInsets.zero,
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey[100],
                  foregroundImage: AssetImage('assets/images/profile2.png'),
                  radius: 55,
                ),
                SizedBox(height: 10),
                Text(
                  'FLUTTER STATES BY\nHEY ROCKSTAR',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height - 240,
          child: ListView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            children: <Widget>[
              ListTile(
                title: Text('HOME'),
                onTap: () => _navigateTo(context, MainPage()),
              ),
              Divider(height: 0),
              ListTile(
                title: Text('State Management'),
                onTap: () => _navigateTo(context, StateManagementMainPage()),
              ),
              Divider(height: 0),
              ListTile(
                title: Text('Dependency Injection'),
                onTap: () => _navigateTo(context, DIMainPage()),
              ),
              Divider(height: 0),
              ListTile(
                title: Text('Data Classes'),
                onTap: () => _navigateTo(context, DataClassMainPage()),
              ),
              Divider(height: 0),
            ],
          ),
        ),
      ],
    ));
  }

  void _navigateTo(BuildContext context, Widget to) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => to),
    );
  }
}
