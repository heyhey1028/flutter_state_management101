import 'package:flutter/material.dart';
import 'package:state_management_examples/state_managements/bloc/main_page.dart';
import 'package:state_management_examples/state_managements/getx/main_page.dart';
import 'package:state_management_examples/state_managements/mobx/main_page.dart';
import 'package:state_management_examples/state_managements/provider/main_page.dart';
import 'package:state_management_examples/state_managements/redux/main_page.dart';
import 'package:state_management_examples/state_managements/rxdart/main_page.dart';
import 'package:state_management_examples/state_managements/scoped_model/main_page.dart';
import 'package:state_management_examples/state_managements/state_notifier/main_page.dart';
import 'package:state_management_examples/state_managements/stateful_widget/counter_page.dart';
import 'package:state_management_examples/widgets/main_scaffold.dart';
import 'package:state_management_examples/widgets/navigate_button.dart';

class StateManagementMainPage extends StatelessWidget {
  const StateManagementMainPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      showDrawer: true,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('WELCOME! This is StateManagement Page'),
              NavigateButton(
                navigateTo: StatefulWidgetCounterPage(),
                title: 'Stateful Widget',
              ),
              NavigateButton(
                navigateTo: ScopedModelMainPage(),
                title: 'Scoped Model',
              ),
              NavigateButton(
                navigateTo: ChangeNotifierMainPage(),
                title: 'ChangeNotifier(Provider)',
              ),
              NavigateButton(
                navigateTo: StateNotifierMainPage(),
                title: 'StateNotifier',
              ),
              NavigateButton(
                navigateTo: BlocMainPage(),
                title: 'BLoC',
              ),
              NavigateButton(
                navigateTo: RxdartMainPage(),
                title: 'RxDart',
              ),
              NavigateButton(
                navigateTo: MobxMainPage(),
                title: 'MobX',
              ),
              NavigateButton(
                navigateTo: ReduxMainPage(),
                title: 'Redux',
              ),
              NavigateButton(
                navigateTo: GetxMainPage(),
                title: 'GetX',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
