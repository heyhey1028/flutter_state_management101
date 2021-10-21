

# Provider

# Riverpod
package:
- [flutter_riverpod](https://pub.dev/packages/flutter_riverpod) v0.14.0+3

## Providers and Consumers
- One thing that confused me at first was that Riverpod also shares concepts named same as Provider package such as `Provider` class, `Consumer` class.
- While they shares a same functionality it might be good idea to recognize them separately.
- many of the examples on the internet uses `StateNotifier` together with Riverpod but in truth, riverpod is equipped with series of Providers that you do not explicitly need to use only StateNotifier with Riverpod. We can also use good old changeNotifier with ChangeNotifierProvider of Riverpod. 
- Provider
- StateProvider
- StateNotifierProvider
- ChangeNotifierProvider
- FutureProvider
- StreamProviders

## Getting Started

- classes we need to prepare
    - State
    - Provider
    - ProviderScope
    - Consumer
- For alternative to Consumer class, we can use ConsumerWidget class
-  

# Hooks Riverpod
[hooks_riverpod](https://pub.dev/packages/hooks_riverpod) v0.14.0+5
[flutter_hooks](https://pub.dev/packages/flutter_hooks) v0.18.0

- when we want to use riverpod while using flutter hooks, we need to use `hooks_riverpod` package instead of `flutter_riverpod`. 

## What is Flutter Hooks?
- first of all, 
- various hooks of flutter hooks
    - useState
    - useProvider
    - useAnimationController
    - useContext
    - useFuture
    - useStream
    - useTextEditingController
    - useTabController
    - useEffect
    - useMemoized

# Get_it


