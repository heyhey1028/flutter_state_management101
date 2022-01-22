import 'package:flutter/material.dart';
import 'package:state_management_examples/state_management/state_notifier/counter_page.dart';
import 'package:state_management_examples/widgets/main_scaffold.dart';
import 'package:state_management_examples/widgets/navigate_button.dart';

class StateNotifierMainPage extends StatelessWidget {
  const StateNotifierMainPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('WELCOME! This is StateNotifier Page'),
              NavigateButton(
                navigateTo: StateNotifierCounterPage(),
                title: 'StateNotifier with Provider',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
