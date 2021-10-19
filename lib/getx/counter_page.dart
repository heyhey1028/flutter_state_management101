import 'package:flutter/material.dart';
import 'package:state_management_examples/widgets/main_drawer.dart';
import 'package:get/get.dart';

class Human {
  Human({this.name, this.age});
  final String name;
  final int age;
}

class GetXCounterController extends GetxController {
  Rx<Human> human = Human(name: 'John', age: 18).obs;
  RxInt _counter = 0.obs;
  RxInt get counter => _counter;

  void incrementCounter() => _counter.value++;

  void decrementCounter() => _counter.value--;

  void resetCounter() => _counter.value = 0;
}

class GetXCounterPage extends StatelessWidget {
  const GetXCounterPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('rebuild!');
    final GetXCounterController c = Get.put(GetXCounterController());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('GetX'),
      ),
      drawer: MainDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Obx(
              () => Text(
                '${c.counter}',
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
