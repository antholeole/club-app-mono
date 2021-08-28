import 'package:ferry/ferry.dart';
import 'package:ferry_hive_store/ferry_hive_store.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<Cache> buildCache({required bool memoryCache}) async {
  if (memoryCache) {
    return Cache(store: MemoryStore());
  } else {
    await Hive.initFlutter();
    final box = await Hive.openBox('graphql');
    final store = HiveStore(box);
    return Cache(store: store);
  }
}
