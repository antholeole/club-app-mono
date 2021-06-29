import 'package:fe/data/ws_message/message_message.dart';
import 'package:fe/stdlib/clients/ws_client/ws_client.dart';
import 'package:fe/stdlib/helpers/uuid_type.dart';
import 'package:ferry/ferry.dart';
import 'package:ferry_hive_store/ferry_hive_store.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../config.dart';
import '../../../service_locator.dart';

Future<Cache> buildCache() async {
  if (getIt<Config>().memoryCache) {
    return Cache(store: MemoryStore());
  } else {
    await Hive.initFlutter();
    final box = await Hive.openBox('graphql');
    final store = HiveStore(box);
    return Cache(store: store);
  }
}
