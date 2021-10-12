import 'package:flutter/material.dart';
import 'package:state_management_examples/widgets/main_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@immutable
class RiverpodCounterState {
  RiverpodCounterState({this.count});
  final int count;
}

class RiverpodCounterStateNotifier extends StateNotifier<RiverpodCounterState> {
  RiverpodCounterStateNotifier() : super(RiverpodCounterState(count: 0));
  // when not using freezed, you need to substitute new State into managed state
  void increment() => state = RiverpodCounterState(count: state.count + 1);
  void decrement() => state = RiverpodCounterState(count: state.count - 1);
  void clear() => state = RiverpodCounterState(count: 0);
}

final counterProvider =
    StateNotifierProvider((ref) => RiverpodCounterStateNotifier());

class RiverpodCounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: _RiverpodCounterConsumerPage(),
    );
  }
}

class _RiverpodCounterConsumerPage extends StatelessWidget {
  const _RiverpodCounterConsumerPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('rebuild!');

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('StateNotifier x Riverpod'),
      ),
      drawer: MainDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Consumer(
              builder: (context, watch, _) => Text(
                '${watch(counterProvider).count}',
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
