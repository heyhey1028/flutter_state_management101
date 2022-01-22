import 'package:flutter/material.dart';
import 'package:state_management_examples/dependency_injections/riverpod.dart';
import 'package:state_management_examples/widgets/main_scaffold.dart';
import 'package:state_management_examples/widgets/navigate_button.dart';

class DataClassMainPage extends StatelessWidget {
  const DataClassMainPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('WELCOME! This is Data Classes Page'),
              NavigateButton(
                navigateTo: null,
                title: 'Freezed',
              ),
              NavigateButton(
                navigateTo: StateNotifierRiverpodCounterPage(),
                title: 'built_value',
              ),
              NavigateButton(
                navigateTo: StateNotifierRiverpodCounterPage(),
                title: 'equatable',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
