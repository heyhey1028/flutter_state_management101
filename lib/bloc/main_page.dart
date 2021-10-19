import 'package:flutter/material.dart';
import 'package:state_management_examples/bloc/counter_page_bloc.dart';
import 'package:state_management_examples/bloc/counter_page_cubit.dart';
import 'package:state_management_examples/widgets/main_scaffold.dart';
import 'package:state_management_examples/widgets/navigate_button.dart';

class BlocMainPage extends StatelessWidget {
  const BlocMainPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('WELCOME! This is BLoC Page'),
              NavigateButton(
                navigateTo: BlocCounterPage(),
                title: 'BLoC',
              ),
              NavigateButton(
                navigateTo: CubitCounterPage(),
                title: 'Cubit',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
