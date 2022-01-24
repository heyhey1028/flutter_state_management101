import 'package:flutter/material.dart';
import 'package:state_management_examples/widgets/main_appbar.dart';

class CounterState {
  CounterState({this.count});
  int count;
}

class InheritedWidgetCounterPage extends StatefulWidget {
  InheritedWidgetCounterPage();

  @override
  _InheritedWidgetCounterPageState createState() =>
      _InheritedWidgetCounterPageState();
}

class _InheritedWidgetCounterPageState
    extends State<InheritedWidgetCounterPage> {
  CounterState counter = CounterState(count: 0);

  void increment() {
    setState(() => counter.count++);
  }

  void decrement() {
    setState(() => counter.count--);
  }

  void reset() {
    setState(() => counter.count = 0);
  }

  @override
  Widget build(BuildContext context) {
    return _MyInheritedWidget(
      child: _InheritedWidgetCounterPage(),
      state: this,
    );
  }
}

class _MyInheritedWidget extends InheritedWidget {
  _MyInheritedWidget({
    Key key,
    @required Widget child,
    @required this.state,
  }) : super(key: key, child: child);

  final _InheritedWidgetCounterPageState state;

  static _MyInheritedWidget of(BuildContext context, {bool rebuild = true}) {
    if (rebuild) {
      return context.dependOnInheritedWidgetOfExactType<_MyInheritedWidget>();
    }
    return context.findAncestorWidgetOfExactType<_MyInheritedWidget>();
  }

  void incrementCounter() {
    state.increment();
  }

  void decrementCounter() {
    state.decrement();
  }

  void resetCounter() {
    state.reset();
  }

  @override
  bool updateShouldNotify(_MyInheritedWidget oldWidget) {
    return state != oldWidget.state;
  }
}

class _InheritedWidgetCounterPage extends StatelessWidget {
  const _InheritedWidgetCounterPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _MyInheritedWidget inherit = _MyInheritedWidget.of(context);

    print('rebuild!');

    return Scaffold(
      appBar: MainAppBar(
        title: 'Inherited Widget',
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '${inherit.state.counter.count}',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FloatingActionButton(
              onPressed: inherit.incrementCounter,
              tooltip: 'Increment',
              heroTag: 'Increment',
              child: Icon(Icons.add),
            ),
            const SizedBox(width: 16),
            FloatingActionButton(
              onPressed: inherit.decrementCounter,
              tooltip: 'Decrement',
              heroTag: 'Decrement',
              child: Icon(Icons.remove),
            ),
            const SizedBox(width: 16),
            FloatingActionButton.extended(
              onPressed: inherit.resetCounter,
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
