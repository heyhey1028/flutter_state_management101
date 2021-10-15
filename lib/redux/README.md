# Redux
package:
- [flutter_redux](https://pub.dev/packages/flutter_redux) v0.8.2
- [redux](https://pub.dev/packages/redux) v5.0.0
we need to install both packages.

- Redux is more of a state management architecture.
- developed as a state management architecture for facebook using React.
- Three tenets of Redux are
  1. Single source of truth: state is managed by sole class
  2. State is read only: States are immutable.
  3. Changes are made with pure function: State changes are managed by functions creating new instances rather than mutating an instance.
- Another important concept is it's flow of data.
- key players of data flow are
    1. Store
    2. UI
    3. Action
    4. Reducer
    5. Middleware
- State is stored in a class `Store`
- To change state, UI will dispatch an action class.
- store will receive the action and will run corresponding reducer, creating new instance of state.
- middleware comes in between Action and Reducer
<img width="453" alt="スクリーンショット 2021-10-04 22 02 32" src="https://user-images.githubusercontent.com/44666053/137484916-004b6969-4344-4b37-8970-48ea1165abba.png">


## Getting started 
- instantiate a store at root of the app.
```dart
  final store = Store<RootState>(rootCounterReducer, initialState: RootState());
```
- As in the tenet, store is made sure to be created only once as a singleton.
- When instantiating, we will provide it with reducer, initial state and middleware.
- Because usually, application will have multiple states and multiple reducers, it is common to wrap states and reducers into `RootState` class and `RootReducer` class and pass it on instantiation of `Store`.
- like in bloc example where we created a series of Event class, we will create Action classes.
- Actions can be either class or enum.
- After store is instantiated, it will be distributed by `StoreProvider`.

## Accessing Data, Watching Data
to watch: provides two option, `StoreBuilder` and `StoreConnector`
  - `StoreBuilder`: identifies every changes made to state and rebuilds the widget.
  - `StoreConnector`: identifies changes only made to output through converter and rebuilds the widget. takes in `distinct` field, which if true, rebuild will run only if the value is different.
to read (dispatch an action): also accessed through `StoreConnector`. Actions are dispatch with `store.dispatch()`.  
