import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);
  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);
  void clear() => emit(0);
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
      appBar: AppBar(
        centerTitle: true,
        title: Text('Cubit'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            BlocBuilder<CounterCubit, int>(
              builder: (context, state) => Text(
                '$state',
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
              onPressed: () => context.read<CounterCubit>().clear(),
              tooltip: 'Clear',
              heroTag: 'Clear',
              label: Text('CLEAR'),
            ),
          ],
        ),
      ),
    );
  }
}
