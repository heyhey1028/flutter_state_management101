import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_management_examples/widgets/main_appbar.dart';

@immutable
class CounterState extends Equatable {
  CounterState(this.count);
  final int count;

  @override
  List<Object> get props => [count];
}

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterState(0));
  void increment() => emit(CounterState(state.count + 1));
  void decrement() => emit(CounterState(state.count - 1));
  void reset() => emit(CounterState(0));
}

class CubitCounterPage extends StatelessWidget {
  const CubitCounterPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterCubit>(
      create: (context) => CounterCubit(),
      child: const _CubitCounterPage(),
    );
  }
}

class _CubitCounterPage extends StatelessWidget {
  const _CubitCounterPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('rebuild!');

    return Scaffold(
      appBar: MainAppBar(
        title: 'Cubit',
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            BlocBuilder<CounterCubit, CounterState>(
              builder: (context, state) => Text(
                '${state.count}',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FloatingActionButton(
              onPressed: () => context.read<CounterCubit>().increment(),
              tooltip: 'Increment',
              heroTag: 'Increment',
              child: Icon(Icons.add),
            ),
            const SizedBox(width: 16),
            FloatingActionButton(
              onPressed: () => context.read<CounterCubit>().decrement(),
              tooltip: 'Decrement',
              heroTag: 'Decrement',
              child: Icon(Icons.remove),
            ),
            const SizedBox(width: 16),
            FloatingActionButton.extended(
              onPressed: () => context.read<CounterCubit>().reset(),
              tooltip: 'Reset',
              heroTag: 'Reset',
              label: Text('RESET'),
            ),
          ],
        ),
      ),
    );
  }
}
