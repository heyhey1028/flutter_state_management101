import 'package:flutter/material.dart';

import 'package:state_management_examples/state_managements/getx/counter_page.dart';
import 'package:state_management_examples/widgets/main_scaffold.dart';
import 'package:state_management_examples/widgets/navigate_button.dart';

class GetxMainPage extends StatelessWidget {
  const GetxMainPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('WELCOME! This is GetX Page'),
              NavigateButton(
                navigateTo: GetXCounterPage(),
                title: 'GetX',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
