import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management_examples/mobx/counter_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class MobxCounterPage extends StatelessWidget {
  const MobxCounterPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => CounterStore(),
      child: _MobxCounterPage(),
    );
  }
}

class _MobxCounterPage extends StatelessWidget {
  const _MobxCounterPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CounterStore store = Provider.of(context);

    print('rebuild!');

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('MobX x Provider'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Observer(
              builder: (context) => Text(
                '${store.count}',
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
              onPressed: () => store.increment(),
              tooltip: 'Increment',
              heroTag: 'Increment',
              child: Icon(Icons.add),
            ),
            const SizedBox(width: 16),
            FloatingActionButton(
              onPressed: () => store.decrement(),
              tooltip: 'Decrement',
              heroTag: 'Decrement',
              child: Icon(Icons.remove),
            ),
            const SizedBox(width: 16),
            FloatingActionButton.extended(
              onPressed: () => store.clear(),
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
