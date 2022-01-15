import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management_examples/widgets/main_appbar.dart';

class CounterObj {
  CounterObj() : count = 0;
  int count;
}

class ProviderCounterState extends ChangeNotifier {
  ProviderCounterState() : obj = CounterObj();
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
    return ChangeNotifierProvider(
      create: (_) => ProviderCounterState(),
      child: _ScopedModelCounterPage(),
    );
  }
}

class _ScopedModelCounterPage extends StatelessWidget {
  const _ScopedModelCounterPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('rebuild!');
    final ProviderCounterState unListenState =
        context.read<ProviderCounterState>();
    return Scaffold(
      appBar: MainAppBar(
        title: 'ChangeNotifier x Provider',
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Consumer<ProviderCounterState>(
              builder: (context, state, _) => Text(
                '${state.obj.count}',
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
