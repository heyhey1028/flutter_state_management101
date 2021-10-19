import 'package:flutter/material.dart';
import 'package:state_management_examples/DIs/hooks_riverpod.dart';
import 'package:state_management_examples/DIs/riverpod.dart';

import 'package:state_management_examples/getx/counter_page.dart';
import 'package:state_management_examples/state_notifier/counter_page_provider.dart';
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
                navigateTo: null,
                title: 'Getit',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
