import 'package:flutter/material.dart';
import 'package:state_management_examples/state_management/provider/counter_page_provider.dart';
import 'package:state_management_examples/widgets/main_scaffold.dart';
import 'package:state_management_examples/widgets/navigate_button.dart';

class ChangeNotifierMainPage extends StatelessWidget {
  const ChangeNotifierMainPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('WELCOME! This is ChangeNotifier(Provider) Page'),
              NavigateButton(
                navigateTo: ProviderCounterPage(),
                title: 'ChangeNotifier with Provider',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
