import 'package:flutter/material.dart';
import 'package:state_management_examples/state_management/redux/counter_page.dart';
import 'package:state_management_examples/widgets/main_scaffold.dart';
import 'package:state_management_examples/widgets/navigate_button.dart';

class ReduxMainPage extends StatelessWidget {
  const ReduxMainPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('WELCOME! This is Redux Page'),
              NavigateButton(
                navigateTo: ReduxCounterPage(),
                title: 'Redux',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
