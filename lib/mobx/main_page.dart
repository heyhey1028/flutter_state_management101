import 'package:flutter/material.dart';
import 'package:state_management_examples/bloc/counter_page_bloc.dart';
import 'package:state_management_examples/bloc/counter_page_cubit.dart';
import 'package:state_management_examples/mobx/counter_page.dart';
import 'package:state_management_examples/widgets/main_scaffold.dart';
import 'package:state_management_examples/widgets/navigate_button.dart';

class MobxMainPage extends StatelessWidget {
  const MobxMainPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('WELCOME! This is MobX Page'),
              NavigateButton(
                navigateTo: MobxCounterPage(),
                title: 'MobX with Provider',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
