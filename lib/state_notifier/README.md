# StateNotifier Counter
- ChangeNotifier depends on Flutter.
- StateNotifier is a state management solution for immutable programming.
- That is why, it is commonly used with package `Freezed`.
- package `state_notifier` is the one which does not depends on flutter
- package `flutter_state_notifier` is the one which added functionality for flutter
- you can use `flutter_state_notifier`, if you are using for flutter.
- in StateNotifier, you can only pass one value with single stateNotifier.
- In case, you want to pass several datas at once, you need to conduct them as data class.
- to use StateNotifierProvider, you needd to import `flutter_state_notifier`.

## Setting up StateNotifier
- within StateNotifier class, managed state can be easily accessed by keyword `state`.
- every method will function to change this `state` by substituting new State class into `state`.

## Accessing Data, Watching Data
- to read: `context.read<StateNotifier>()`
- to watch: `context.watch<State>().value`
- to watch selected value: `context.select<State,value>((state)=> state.value)`
- using watch and select exposed will rebuild the entire widget every time state changes.
- to narrow the rebuilt scope, Consumer is valid just like in the Provider pattern.

## difference between ChangeNotifier and StateNotifier
----
- ChangeNotifier notifies the change of the class.
- StateNotifier nnotifies the state itself.

## For Distribution
----
- for distribution of the states, you can either use 'Provider' or 'Riverpod'.
