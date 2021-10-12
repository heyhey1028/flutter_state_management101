import 'package:flutter/material.dart';
import 'package:state_management_examples/widgets/main_drawer.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

@immutable
class ReduxCounterState {
  final int count;
  const ReduxCounterState({this.count = 0});
}

@immutable
class RootState {
  final ReduxCounterState reduxCounterState;

  RootState({this.reduxCounterState = const ReduxCounterState()});
}

class IncrementAction {
  IncrementAction();
}

class DecrementAction {
  DecrementAction();
}

class ClearAction {
  ClearAction();
}

ReduxCounterState counterReducer(ReduxCounterState state, action) {
  // type of second argument needs to be `dynamic`, to be able to pass into Store constructor.
  if (action is IncrementAction) {
    return ReduxCounterState(count: state.count + 1);
  } else if (action is DecrementAction) {
    return ReduxCounterState(count: state.count - 1);
  } else if (action is ClearAction) {
    return ReduxCounterState();
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
      appBar: AppBar(
        centerTitle: true,
        title: Text('Redux'),
      ),
      drawer: MainDrawer(),
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
              converter: (store) => () => store.dispatch(ClearAction()),
              builder: (context, dispatchClear) =>
                  FloatingActionButton.extended(
                onPressed: dispatchClear,
                tooltip: 'Clear',
                heroTag: 'Clear',
                label: Text('CLEAR'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
