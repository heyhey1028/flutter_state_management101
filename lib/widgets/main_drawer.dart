import 'package:flutter/material.dart';
import 'package:state_management_examples/DIs/main_page.dart';
import 'package:state_management_examples/bloc/main_page.dart';
import 'package:state_management_examples/data_classes/main_page.dart';
import 'package:state_management_examples/getx/main_page.dart';
import 'package:state_management_examples/main.dart';
import 'package:state_management_examples/mobx/main_page.dart';
import 'package:state_management_examples/provider/main_page.dart';
import 'package:state_management_examples/redux/main_page.dart';
import 'package:state_management_examples/rxdart/main_page.dart';
import 'package:state_management_examples/scoped_model/main_page.dart';
import 'package:state_management_examples/state_notifier/main_page.dart';
import 'package:state_management_examples/stateful_widget/counter_page.dart';

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
                title: Text('Stateful Widget'),
                onTap: () => _navigateTo(context, StatefulWidgetCounterPage()),
              ),
              Divider(height: 0),
              ListTile(
                title: Text('Scoped Model'),
                onTap: () => _navigateTo(context, ScopedModelMainPage()),
              ),
              Divider(height: 0),
              ListTile(
                title: Text('ChangeNotifier(Provider)'),
                onTap: () => _navigateTo(context, ChangeNotifierMainPage()),
              ),
              Divider(height: 0),
              ListTile(
                title: Text('StateNotifier'),
                onTap: () => _navigateTo(context, StateNotifierMainPage()),
              ),
              Divider(height: 0),
              ListTile(
                title: Text('BLoC'),
                onTap: () => _navigateTo(context, BlocMainPage()),
              ),
              Divider(height: 0),
              ListTile(
                title: Text('RxDart'),
                onTap: () => _navigateTo(context, RxdartMainPage()),
              ),
              Divider(height: 0),
              ListTile(
                title: Text('MobX'),
                onTap: () => _navigateTo(context, MobxMainPage()),
              ),
              Divider(height: 0),
              ListTile(
                title: Text('Redux'),
                onTap: () => _navigateTo(context, ReduxMainPage()),
              ),
              Divider(height: 0),
              ListTile(
                title: Text('GetX'),
                onTap: () => _navigateTo(context, GetxMainPage()),
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
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => to),
    );
  }
}
