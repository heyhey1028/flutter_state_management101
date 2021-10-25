import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class CounterObj {
  CounterObj(this.count);
  int count;
}

class RxCounterBloc {
  CounterObj state;
  BehaviorSubject<CounterObj> _counterSubject;
  RxCounterBloc({this.state}) {
    _counterSubject = BehaviorSubject<CounterObj>.seeded(this.state);
  }

  Stream get counterStream => _counterSubject.stream;

  void increment() {
    state = CounterObj(state.count + 1);
    _counterSubject.sink.add(state);
  }

  void decrement() {
    state = CounterObj(state.count - 1);
    _counterSubject.sink.add(state);
  }

  void clear() {
    state = CounterObj(0);
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
      create: (_) => RxCounterBloc(state: CounterObj(0)),
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
            StreamBuilder<CounterObj>(
              initialData: CounterObj(0),
              stream: counter.counterStream,
              builder:
                  (BuildContext context, AsyncSnapshot<CounterObj> snapshot) =>
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
