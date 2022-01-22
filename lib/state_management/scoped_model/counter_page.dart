import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:state_management_examples/widgets/main_appbar.dart';

class CounterObj {
  CounterObj() : count = 0;
  int count;
}

class ScopedModelCounterState extends Model {
  ScopedModelCounterState() : obj = CounterObj();
  CounterObj obj;

  void incrementCounter() {
    obj.count++;
    notifyListeners();
  }

  void decrementCounter() {
    obj.count--;
    notifyListeners();
  }

  void resetCounter() {
    obj.count = 0;
    notifyListeners();
  }
}

class ScopedModelCounterPage extends StatelessWidget {
  const ScopedModelCounterPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: ScopedModelCounterState(),
      child: _ScopedModelCounterPage(),
    );
  }
}

class _ScopedModelCounterPage extends StatelessWidget {
  const _ScopedModelCounterPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('rebuild!');
    final ScopedModelCounterState unListenState = ScopedModel.of(context);
    return Scaffold(
      appBar: MainAppBar(
        title: 'Scoped Model',
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            ScopedModelDescendant<ScopedModelCounterState>(
              builder: (context, _, model) => Text(
                '${model.obj.count}',
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
              onPressed: unListenState.incrementCounter,
              tooltip: 'Increment',
              heroTag: 'Increment',
              child: Icon(Icons.add),
            ),
            const SizedBox(width: 16),
            FloatingActionButton(
              onPressed: unListenState.decrementCounter,
              tooltip: 'Decrement',
              heroTag: 'Decrement',
              child: Icon(Icons.remove),
            ),
            const SizedBox(width: 16),
            FloatingActionButton.extended(
              onPressed: unListenState.resetCounter,
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
