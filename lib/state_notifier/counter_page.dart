import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:provider/provider.dart';
import 'package:state_management_examples/widgets/main_appbar.dart';
import 'package:state_notifier/state_notifier.dart';

@immutable
class CounterState {
  CounterState({this.count});
  final int count;
}

class CounterStateNotifier extends StateNotifier<CounterState> {
  CounterStateNotifier() : super(CounterState(count: 0));
  // when not using freezed, you need to substitute new State into managed state
  void increment() => state = CounterState(count: state.count + 1);
  void decrement() => state = CounterState(count: state.count - 1);
  void reset() => state = CounterState(count: 0);
}

class StateNotifierCounterPage extends StatelessWidget {
  const StateNotifierCounterPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StateNotifierProvider<CounterStateNotifier, CounterState>(
      create: (context) => CounterStateNotifier(),
      child: const _StateNotifierCounterPage(),
    );
  }
}

class _StateNotifierCounterPage extends StatelessWidget {
  const _StateNotifierCounterPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('rebuild!');

    return Scaffold(
      appBar: MainAppBar(
        title: 'StateNotifier x Provider',
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            // Consumer is also valid for stateNotifier solution to narrow the rebuild scope
            Consumer<CounterState>(
              builder: (context, state, _) => Text(
                state.count.toString(),
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
              onPressed: () => context.read<CounterStateNotifier>().increment(),
              tooltip: 'Increment',
              heroTag: 'Increment',
              child: Icon(Icons.add),
            ),
            const SizedBox(width: 16),
            FloatingActionButton(
              onPressed: () => context.read<CounterStateNotifier>().decrement(),
              tooltip: 'Decrement',
              heroTag: 'Decrement',
              child: Icon(Icons.remove),
            ),
            const SizedBox(width: 16),
            FloatingActionButton.extended(
              onPressed: () => context.read<CounterStateNotifier>().reset(),
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
