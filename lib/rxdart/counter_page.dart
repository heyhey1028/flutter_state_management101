import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class CounterState {
  CounterState(this.count);
  int count;
}

class RxCounterBloc {
  CounterState state;
  BehaviorSubject<CounterState> _counterSubject;
  RxCounterBloc({this.state}) {
    _counterSubject = BehaviorSubject<CounterState>.seeded(this.state);
  }

  Stream get counterStream => _counterSubject.stream;

  void increment() {
    state = CounterState(state.count + 1);
    _counterSubject.sink.add(state);
  }

  void decrement() {
    state = CounterState(state.count - 1);
    _counterSubject.sink.add(state);
  }

  void clear() {
    state = CounterState(0);
    _counterSubject.sink.add(state);
  }

  void dispose() {
    _counterSubject.close();
  }
}

class RxdartCounterPage extends StatelessWidget {
  const RxdartCounterPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<RxCounterBloc>(
      create: (_) => RxCounterBloc(state: CounterState(0)),
      child: _RxdartCounterPage(),
    );
  }
}

class _RxdartCounterPage extends StatelessWidget {
  const _RxdartCounterPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RxCounterBloc counter = Provider.of<RxCounterBloc>(context);
    print('rebuild!');

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('RxDart x Provider'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            StreamBuilder<CounterState>(
              initialData: CounterState(0),
              stream: counter.counterStream,
              builder: (BuildContext context,
                      AsyncSnapshot<CounterState> snapshot) =>
                  Text(
                snapshot.data.count.toString(),
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
              onPressed: () => counter.increment(),
              tooltip: 'Increment',
              heroTag: 'Increment',
              child: Icon(Icons.add),
            ),
            const SizedBox(width: 16),
            FloatingActionButton(
              onPressed: () => counter.decrement(),
              tooltip: 'Decrement',
              heroTag: 'Decrement',
              child: Icon(Icons.remove),
            ),
            const SizedBox(width: 16),
            FloatingActionButton.extended(
              onPressed: () => counter.clear(),
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
