import 'package:mobx/mobx.dart';

part 'counter_store.g.dart';

class CounterObj {
  CounterObj(this.count);
  int count;
}

class CounterStore = CounterStoreBase with _$CounterStore;

abstract class CounterStoreBase with Store {
  @observable
  CounterObj countObj = CounterObj(0);

  @action
  void increment() {
    countObj = CounterObj(countObj.count + 1);
  }

  @action
  void decrement() {
    countObj = CounterObj(countObj.count - 1);
  }

  @action
  void reset() {
    countObj = CounterObj(0);
  }
}
