# RxDart
package:
[rxdart](https://pub.dev/packages/rxdart) v0.27.2

## What's it about?
- rxdart is often introduced with bloc pattern.
- although, it doesn't me you neccessarily need to use bloc package together.
- functionality of rxdart is suitable for managing state in bloc pattern way.
- RxDart adds a powerful extensions to Stream.
- It is a Stream with a functionality to cache data which flow through it.

## Context
- RxDart is developed under the concept of ReactiveX.

## Key Concepts & Classes
- `Stream` class, `Subject` class
- `Stream` class is the most primitive class within RxDart.
- for whom familiar with `Observable`class, `Observable` have been deprecated and replaced with `Stream`class and it's extension methods from v0.23.0. [Reference](https://pub.dev/packages/rxdart/versions/0.23.0/changelog)
- `Subject` classes all inherit `Stream` class.
- within `subject` class there are,
    - `PublishSubject`
    - `BehaviorSubject`
    - `ReplaySubject`
- `PublishSubject`: Is a `Observable` with StreamController built in. Also is in broadcast that it will listen to it's stream multiple times. Unlike two other subects, it will not cache datas.
```dart
final streamSubject = PublishSubject<String>();

streamSubject.listen((addData){
print(addData);
});

streamSubject.sink.add('仗助');
```
- `BehaviorSubject`: on top ob `PublishSubject`, it allows us to set initial value of streaming and also caches the last data added into stream.
- `ReplaySubject`: on top of `BehaviorSubject`, it caches not only the last data, but all of the datas which flowed through the stream. 
- For `BehaviorSubject` and `ReplaySubject`, we don't neccesarily needs to define listen before sink.add.

