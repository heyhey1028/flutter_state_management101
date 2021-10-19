import 'package:flutter/material.dart';
import 'package:state_management_examples/rxdart/counter_page.dart';
import 'package:state_management_examples/rxdart/counter_page_provider.dart';
import 'package:state_management_examples/rxdart/counter_page_riverpod.dart';
import 'package:state_management_examples/widgets/main_scaffold.dart';
import 'package:state_management_examples/widgets/navigate_button.dart';

class RxdartMainPage extends StatelessWidget {
  const RxdartMainPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('WELCOME! This is RxDart Page'),
              NavigateButton(
                navigateTo: RxdartCounterPage(),
                title: 'Simple RxDart',
              ),
              NavigateButton(
                navigateTo: RxdartProviderCounterPage(),
                title: 'RxDart with Provider',
              ),
              NavigateButton(
                navigateTo: RxdartRiverpodCounterPage(),
                title: 'RxDart with Riverpod',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
