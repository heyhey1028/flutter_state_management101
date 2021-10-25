// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counter_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CounterStore on CounterStoreBase, Store {
  final _$countObjAtom = Atom(name: 'CounterStoreBase.countObj');

  @override
  CounterObj get countObj {
    _$countObjAtom.reportRead();
    return super.countObj;
  }

  @override
  set countObj(CounterObj value) {
    _$countObjAtom.reportWrite(value, super.countObj, () {
      super.countObj = value;
    });
  }

  final _$CounterStoreBaseActionController =
      ActionController(name: 'CounterStoreBase');

  @override
  void increment() {
    final _$actionInfo = _$CounterStoreBaseActionController.startAction(
        name: 'CounterStoreBase.increment');
    try {
      return super.increment();
    } finally {
      _$CounterStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void decrement() {
    final _$actionInfo = _$CounterStoreBaseActionController.startAction(
        name: 'CounterStoreBase.decrement');
    try {
      return super.decrement();
    } finally {
      _$CounterStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clear() {
    final _$actionInfo = _$CounterStoreBaseActionController.startAction(
        name: 'CounterStoreBase.clear');
    try {
      return super.clear();
    } finally {
      _$CounterStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
countObj: ${countObj}
    ''';
  }
}
