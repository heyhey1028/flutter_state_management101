import 'package:flutter/material.dart';
import 'package:state_management_examples/bloc/counter_page.dart';
import 'package:state_management_examples/cubit/counter_page.dart';
import 'package:state_management_examples/main.dart';
import 'package:state_management_examples/mobx/counter_page.dart';
import 'package:state_management_examples/provider/counter_page.dart';
import 'package:state_management_examples/redux/counter_page.dart';
import 'package:state_management_examples/riverpod/counter_page.dart';
import 'package:state_management_examples/state_notifier/counter_page.dart';
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
                title: Text('ChangeNotifier x Provider'),
                onTap: () => _navigateTo(context, ProviderCounterPage()),
              ),
              Divider(height: 0),
              ListTile(
                title: Text('StateNotifier x Provider'),
                onTap: () => _navigateTo(context, StateNotifierCounterPage()),
              ),
              Divider(height: 0),
              ListTile(
                title: Text('BLoC'),
                onTap: () => _navigateTo(context, BlocCounterPage()),
              ),
              Divider(height: 0),
              ListTile(
                title: Text('BLoC + RxDart'),
                onTap: () => _navigateTo(context, BlocCounterPage()),
              ),
              Divider(height: 0),
              ListTile(
                title: Text('Cubit'),
                onTap: () => _navigateTo(context, CubitCounterPage()),
              ),
              Divider(height: 0),
              ListTile(
                title: Text('MobX x Provider'),
                onTap: () => _navigateTo(context, MobxCounterPage()),
              ),
              Divider(height: 0),
              ListTile(
                title: Text('Redux'),
                onTap: () => _navigateTo(context, ReduxCounterPage()),
              ),
              Divider(height: 0),
              ListTile(
                title: Text('StateNotifier x Riverpod'),
                onTap: () => _navigateTo(context, RiverpodCounterPage()),
              ),
              Divider(height: 0),
              ListTile(
                title: Text('Hooks_Riverpod'),
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
