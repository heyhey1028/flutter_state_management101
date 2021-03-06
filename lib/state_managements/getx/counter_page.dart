import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:state_management_examples/widgets/main_appbar.dart';

class CounterObj {
  CounterObj() : count = 0.obs;
  RxInt count;
}

class GetXCounterController extends GetxController {
  Rx<CounterObj> _counter = CounterObj().obs;
  Rx<CounterObj> get counter => _counter;

  void incrementCounter() => _counter.value.count++;

  void decrementCounter() => _counter.value.count--;

  void resetCounter() => _counter.value.count.value = 0;
}

class GetXCounterPage extends StatelessWidget {
  const GetXCounterPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(GetXCounterController());
    return const _GetXCounterPage();
  }
}

class _GetXCounterPage extends StatelessWidget {
  const _GetXCounterPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('rebuild!');
    final GetXCounterController c = Get.find();

    return Scaffold(
      appBar: MainAppBar(
        title: 'GetX',
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Obx(
              () => Text(
                '${c.counter.value.count}',
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
              onPressed: c.incrementCounter,
              tooltip: 'Increment',
              heroTag: 'Increment',
              child: Icon(Icons.add),
            ),
            const SizedBox(width: 16),
            FloatingActionButton(
              onPressed: c.decrementCounter,
              tooltip: 'Decrement',
              heroTag: 'Decrement',
              child: Icon(Icons.remove),
            ),
            const SizedBox(width: 16),
            FloatingActionButton.extended(
              onPressed: c.resetCounter,
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
