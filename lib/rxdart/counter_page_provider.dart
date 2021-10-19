import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class RxCounterBloc {
  int initialCount = 0;
  BehaviorSubject<int> _counterSubject;
  RxCounterBloc({this.initialCount}) {
    _counterSubject = BehaviorSubject<int>.seeded(this.initialCount);
  }

  Stream get counterStream => _counterSubject.stream;

  void increment() {
    initialCount++;
    _counterSubject.sink.add(initialCount);
  }

  void decrement() {
    initialCount--;
    _counterSubject.sink.add(initialCount);
  }

  void clear() {
    initialCount = 0;
    _counterSubject.sink.add(initialCount);
  }

  void dispose() {
    _counterSubject.close();
  }
}

class RxdartProviderCounterPage extends StatelessWidget {
  const RxdartProviderCounterPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => RxCounterBloc(),
      child: _RxdartProviderCounterPage(),
    );
  }
}

class _RxdartProviderCounterPage extends StatelessWidget {
  const _RxdartProviderCounterPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RxCounterBloc counter = RxCounterBloc(initialCount: 0);
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
            StreamBuilder<int>(
              stream: counter.counterStream,
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) =>
                  Text(
                '${snapshot.data}',
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
