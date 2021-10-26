import 'package:flutter/material.dart';
import 'package:state_management_examples/widgets/main_drawer.dart';

class CounterState {
  CounterState({this.count});
  int count;
}

class StatefulWidgetCounterPage extends StatefulWidget {
  StatefulWidgetCounterPage();

  @override
  _StatefulWidgetCounterPageState createState() =>
      _StatefulWidgetCounterPageState();
}

class _StatefulWidgetCounterPageState extends State<StatefulWidgetCounterPage> {
  CounterState _counter = CounterState(count: 0);

  void _incrementCounter() {
    setState(() {
      _counter.count++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter.count--;
    });
  }

  void _resetCounter() {
    setState(() {
      _counter.count = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('rebuild!');

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('StatefulWidget'),
      ),
      drawer: MainDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '${_counter.count}',
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
              onPressed: _incrementCounter,
              tooltip: 'Increment',
              heroTag: 'Increment',
              child: Icon(Icons.add),
            ),
            const SizedBox(width: 16),
            FloatingActionButton(
              onPressed: _decrementCounter,
              tooltip: 'Decrement',
              heroTag: 'Decrement',
              child: Icon(Icons.remove),
            ),
            const SizedBox(width: 16),
            FloatingActionButton.extended(
              onPressed: _resetCounter,
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
