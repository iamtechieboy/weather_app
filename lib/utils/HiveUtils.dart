import 'package:hive/hive.dart';

mixin HiveUtils {

  Future addAllBox<T>(String boxName, Iterable<T> value) async {
    Box<T> box = await isCheckOpenBox<T>(boxName);
    await box.addAll(value);
    box.close();
  }

  Future addBox<T>(String boxName, T value) async {
    Box<T> box = await isCheckOpenBox<T>(boxName);
    await box.add(value);
    box.close();
  }

  Future<Box<T>> getAllBox<T>(String boxName) async {
    Box<T> box = await isCheckOpenBox<T>(boxName);
    // var result = box;
    // box.close();
    return Future<Box<T>>.value(box);
  }

  Future<Box<T>> isCheckOpenBox<T>(String boxName) async {
    if (Hive.isBoxOpen(boxName)) {
      return Hive.box(boxName);
    } else {
      return Future.value(Hive.openBox<T>(boxName));
    }
  }

  Future<bool> isEmptyBox<T>(String boxName) async {
    Box<T> box = await  isCheckOpenBox<T>(boxName);
    bool isOpen = box.isEmpty;
    box.close();
    return Future<bool>.value(isOpen);
  }
}
