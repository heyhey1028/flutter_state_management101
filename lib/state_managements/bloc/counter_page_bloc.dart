import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:state_management_examples/widgets/main_appbar.dart';

abstract class CounterEvent extends Equatable {
  const CounterEvent();
  @override
  List<Object> get props => [];
}

class IncrementEvent extends CounterEvent {}

class DecrementEvent extends CounterEvent {}

class ResetEvent extends CounterEvent {}

class CounterState extends Equatable {
  final int count;
  const CounterState({@required this.count});

  @override
  List<Object> get props => [count];
}

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState(count: 0));

  @override
  Stream<CounterState> mapEventToState(CounterEvent event) async* {
    if (event is IncrementEvent) {
      yield CounterState(count: state.count + 1);
    } else if (event is DecrementEvent) {
      yield CounterState(count: state.count - 1);
    } else if (event is ResetEvent) {
      yield CounterState(count: 0);
    } else {
      yield CounterState(count: state.count);
    }
  }
}

class BlocCounterPage extends StatelessWidget {
  const BlocCounterPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterBloc>(
      create: (context) => CounterBloc(),
      child: const _BlocCounterPage(),
    );
  }
}

class _BlocCounterPage extends StatelessWidget {
  const _BlocCounterPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CounterBloc counterBloc = BlocProvider.of<CounterBloc>(context);
    print('rebuild!');

    return Scaffold(
      appBar: MainAppBar(
        title: 'BLoC',
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            BlocBuilder<CounterBloc, CounterState>(
              builder: (context, state) => Text(
                '${state.count}',
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
              onPressed: () => counterBloc.add(IncrementEvent()),
              tooltip: 'Increment',
              heroTag: 'Increment',
              child: Icon(Icons.add),
            ),
            const SizedBox(width: 16),
            FloatingActionButton(
              onPressed: () => counterBloc.add(DecrementEvent()),
              tooltip: 'Decrement',
              heroTag: 'Decrement',
              child: Icon(Icons.remove),
            ),
            const SizedBox(width: 16),
            FloatingActionButton.extended(
              onPressed: () => counterBloc.add(ResetEvent()),
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
