import 'package:flutter/material.dart';
import 'package:state_management_examples/widgets/main_drawer.dart';
import 'package:provider/provider.dart';

class ChangeNotifierProviderCounterState extends ChangeNotifier {
  int _counter = 0;
  int get counter => _counter;

  void incrementCounter() {
    _counter++;
    notifyListeners();
  }

  void decrementCounter() {
    _counter--;
    notifyListeners();
  }

  void resetCounter() {
    _counter = 0;
    notifyListeners();
  }
}

class ChangeNotifierProviderCounterPage extends StatelessWidget {
  const ChangeNotifierProviderCounterPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChangeNotifierProviderCounterState(),
      child: _ChangeNotifierProviderCounterPage(),
    );
  }
}

class _ChangeNotifierProviderCounterPage extends StatelessWidget {
  const _ChangeNotifierProviderCounterPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('rebuild!');
    final ChangeNotifierProviderCounterState unListenState =
        context.read<ChangeNotifierProviderCounterState>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('ChangeNotifier x Provider'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Consumer<ChangeNotifierProviderCounterState>(
              builder: (context, state, _) => Text(
                '${state.counter}',
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
