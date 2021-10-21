import 'package:flutter/material.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:get_it/get_it.dart';

@immutable
class CounterState {
  CounterState({this.count});
  final int count;
}

class CounterStateNotifier extends StateNotifier<CounterState> {
  CounterStateNotifier() : super(CounterState(count: 0));
  CounterState get state => state;
  // when not using freezed, you need to substitute new State into managed state
  void increment() => state = CounterState(count: state.count + 1);
  void decrement() => state = CounterState(count: state.count - 1);
  void clear() => state = CounterState(count: 0);
}

final locator = GetIt.instance;

class StateNotifierGetItCounterPage extends StatelessWidget {
  const StateNotifierGetItCounterPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    locator.registerSingleton<CounterStateNotifier>(CounterStateNotifier());
    return const _StateNotifierGetItCounterPage();
  }
}

class _StateNotifierGetItCounterPage extends StatelessWidget {
  const _StateNotifierGetItCounterPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CounterStateNotifier state = locator<CounterStateNotifier>();
    print('rebuild!');

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('StateNotifier x Provider'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              state.state.count.toString(),
              style: Theme.of(context).textTheme.headline4,
            )
          ],
        ),
      ),
      floatingActionButton: FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FloatingActionButton(
              onPressed: () => state.increment(),
              tooltip: 'Increment',
              heroTag: 'Increment',
              child: Icon(Icons.add),
            ),
            const SizedBox(width: 16),
            FloatingActionButton(
              onPressed: () => state.decrement(),
              tooltip: 'Decrement',
              heroTag: 'Decrement',
              child: Icon(Icons.remove),
            ),
            const SizedBox(width: 16),
            FloatingActionButton.extended(
              onPressed: () => state.clear(),
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
