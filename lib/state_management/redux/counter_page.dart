import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:state_management_examples/widgets/main_appbar.dart';

@immutable
class CounterState {
  final int count;
  const CounterState({this.count = 0});
}

@immutable
class RootState {
  final CounterState reduxCounterState;

  RootState({this.reduxCounterState = const CounterState()});
}

class IncrementAction {
  IncrementAction();
}

class DecrementAction {
  DecrementAction();
}

class ResetAction {
  ResetAction();
}

CounterState counterReducer(CounterState state, action) {
  // type of second argument needs to be `dynamic`, to be able to pass into Store constructor.
  if (action is IncrementAction) {
    return CounterState(count: state.count + 1);
  } else if (action is DecrementAction) {
    return CounterState(count: state.count - 1);
  } else if (action is ResetAction) {
    return CounterState();
  } else {
    return state;
  }
}

RootState rootCounterReducer(RootState state, action) {
  return RootState(
      reduxCounterState: counterReducer(state.reduxCounterState, action));
}

class ReduxCounterPage extends StatelessWidget {
  final store = Store<RootState>(rootCounterReducer, initialState: RootState());

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: _ReduxCounterPage(),
    );
  }
}

class _ReduxCounterPage extends StatelessWidget {
  const _ReduxCounterPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('rebuild!');

    return Scaffold(
      appBar: MainAppBar(
        title: 'Redux',
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            StoreConnector<RootState, int>(
              converter: (store) => store.state.reduxCounterState.count,
              distinct: true,
              builder: (context, count) => Text(
                '$count',
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
            StoreConnector<RootState, VoidCallback>(
              converter: (store) => () => store.dispatch(IncrementAction()),
              builder: (context, dispatchIncrement) => FloatingActionButton(
                onPressed: dispatchIncrement,
                tooltip: 'Increment',
                heroTag: 'Increment',
                child: Icon(Icons.add),
              ),
            ),
            const SizedBox(width: 16),
            StoreConnector<RootState, VoidCallback>(
              converter: (store) => () => store.dispatch(DecrementAction()),
              builder: (context, dispatchDecrement) => FloatingActionButton(
                onPressed: dispatchDecrement,
                tooltip: 'Decrement',
                heroTag: 'Decrement',
                child: Icon(Icons.remove),
              ),
            ),
            const SizedBox(width: 16),
            StoreConnector<RootState, VoidCallback>(
              converter: (store) => () => store.dispatch(ResetAction()),
              builder: (context, dispatchReset) =>
                  FloatingActionButton.extended(
                onPressed: dispatchReset,
                tooltip: 'Reset',
                heroTag: 'Reset',
                label: Text('RESET'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
