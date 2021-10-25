import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@immutable
class CounterObj {
  CounterObj(this.count);
  final int count;
}

class CounterCubit extends Cubit<CounterObj> {
  CounterCubit() : super(CounterObj(0));
  void increment() => emit(CounterObj(state.count + 1));
  void decrement() => emit(CounterObj(state.count - 1));
  void clear() => emit(CounterObj(0));
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
            BlocBuilder<CounterCubit, CounterObj>(
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
