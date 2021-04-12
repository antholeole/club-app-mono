import 'package:fe/data_classes/chat.dart';
import 'package:fe/stdlib/local_data/local_file_store.dart';

class MainService {
  LocalFileStore _localFileStore = LocalFileStore();

  Future<List<Chat>> beginLoadingChats() async {
    final groups = await _localFileStore.deserialize(LocalStorageType.GroupIds);
  }
}
