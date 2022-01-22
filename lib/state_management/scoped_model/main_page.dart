import 'package:flutter/material.dart';
import 'package:state_management_examples/state_management/scoped_model/counter_page.dart';
import 'package:state_management_examples/widgets/main_scaffold.dart';
import 'package:state_management_examples/widgets/navigate_button.dart';

class ScopedModelMainPage extends StatelessWidget {
  const ScopedModelMainPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('WELCOME! This is ScopedModel Page'),
              NavigateButton(
                navigateTo: ScopedModelCounterPage(),
                title: 'Scoped Model',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
