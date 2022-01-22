import 'package:flutter/material.dart';
import 'package:state_management_examples/dependency_injections/get_it.dart';
import 'package:state_management_examples/dependency_injections/hooks_riverpod.dart';
import 'package:state_management_examples/dependency_injections/inherited_widget.dart';
import 'package:state_management_examples/dependency_injections/provider.dart';
import 'package:state_management_examples/dependency_injections/riverpod.dart';
import 'package:state_management_examples/widgets/main_scaffold.dart';
import 'package:state_management_examples/widgets/navigate_button.dart';

class DIMainPage extends StatelessWidget {
  const DIMainPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('WELCOME! This is DIs Page'),
              NavigateButton(
                navigateTo: InheritedWidgetCounterPage(),
                title: 'Inherited Widget',
              ),
              NavigateButton(
                navigateTo: StateNotifierProviderCounterPage(),
                title: 'Provider',
              ),
              NavigateButton(
                navigateTo: StateNotifierRiverpodCounterPage(),
                title: 'Riverpod',
              ),
              NavigateButton(
                navigateTo: HooksRiverpodCounterPage(),
                title: 'Hooks Riverpod',
              ),
              NavigateButton(
                navigateTo: StateNotifierGetItCounterPage(),
                title: 'Getit',
              ),
              NavigateButton(
                navigateTo: null,
                title: 'Getit x Injectable',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
