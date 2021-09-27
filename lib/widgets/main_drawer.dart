import 'package:flutter/material.dart';
import 'package:state_management_examples/bloc/counter_page.dart';
import 'package:state_management_examples/provider/home_page.dart';
import 'package:state_management_examples/stateful_widget/home_page.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        children: <Widget>[
          Container(
            height: 200,
            child: DrawerHeader(
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
          ListTile(
            title: Text('Stateful Widget'),
            onTap: () => _navigateTo(context, StatefulWidgetHomePage()),
          ),
          Divider(height: 0),
          ListTile(
            title: Text('ChangeNotifier x Provider'),
            onTap: () => _navigateTo(context, ProviderHomePage()),
          ),
          Divider(height: 0),
          ListTile(
            title: Text('BLoC'),
            onTap: () => _navigateTo(context, BlocCounterPage()),
          ),
          Divider(height: 0),
          ListTile(
            title: Text('RxDart(Redux)'),
          ),
          Divider(height: 0),
          ListTile(
            title: Text('StateNotifier x freezed x Provider'),
          ),
          Divider(height: 0),
          ListTile(
            title: Text('StateNotifier x hooks_riverpod'),
          ),
          Divider(height: 0),
          ListTile(
            title: Text('StateNotifierProvider x riverpod'),
          ),
          Divider(height: 0),
        ],
      ),
    );
  }

  void _navigateTo(BuildContext context, Widget to) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => to),
    );
  }
}
