import 'package:flutter/material.dart';
import 'package:state_management_examples/widgets/main_drawer.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@immutable
class HooksRiverpodCounterState {
  HooksRiverpodCounterState({this.count});
  final int count;
}

class HooksRiverpodCounterStateNotifier
    extends StateNotifier<HooksRiverpodCounterState> {
  HooksRiverpodCounterStateNotifier()
      : super(HooksRiverpodCounterState(count: 0));
  // when not using freezed, you need to substitute new State into managed state
  void increment() => state = HooksRiverpodCounterState(count: state.count + 1);
  void decrement() => state = HooksRiverpodCounterState(count: state.count - 1);
  void clear() => state = HooksRiverpodCounterState(count: 0);
}

final counterProvider = StateNotifierProvider<HooksRiverpodCounterStateNotifier,
    HooksRiverpodCounterState>((ref) => HooksRiverpodCounterStateNotifier());

class HooksRiverpodCounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: HooksRiverpodCounterPageBody(),
    );
  }
}

class HooksRiverpodCounterPageBody extends HookWidget {
  const HooksRiverpodCounterPageBody({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HooksRiverpodCounterState counter = useProvider(counterProvider);
    print('rebuild!'); // なぜか何度もwidgetごとrebuildされてしまう、聞きたい...

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('StateNotifier x Hooks Riverpod'),
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
              '${counter.count}',
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
              onPressed: () =>
                  context.read(counterProvider.notifier).increment(),
              tooltip: 'Increment',
              heroTag: 'Increment',
              child: Icon(Icons.add),
            ),
            const SizedBox(width: 16),
            FloatingActionButton(
              onPressed: () =>
                  context.read(counterProvider.notifier).decrement(),
              tooltip: 'Decrement',
              heroTag: 'Decrement',
              child: Icon(Icons.remove),
            ),
            const SizedBox(width: 16),
            FloatingActionButton.extended(
              onPressed: () => context.read(counterProvider.notifier).clear(),
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
