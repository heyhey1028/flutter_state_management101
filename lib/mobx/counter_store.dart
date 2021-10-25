import 'package:mobx/mobx.dart';

part 'counter_store.g.dart';

class CounterState {
  CounterState(this.count);
  int count;
}

class CounterStore = CounterStoreBase with _$CounterStore;

abstract class CounterStoreBase with Store {
  @observable
  CounterState countObj = CounterState(0);

  @action
  void increment() {
    countObj = CounterState(countObj.count + 1);
  }

  @action
  void decrement() {
    countObj = CounterState(countObj.count - 1);
  }

  @action
  void clear() {
    countObj = CounterState(0);
  }
}
