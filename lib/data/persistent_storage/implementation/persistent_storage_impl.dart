
import 'package:chat_app/data/persistent_storage/repositories/persistent_storage_repository.dart';

class PersistentStorageImpl extends PersistentStorageRepository{
  @override
  Future<bool> isDarkMode() async{
    await Future.delayed(const Duration(microseconds: 90));
    return false;
  }

  @override
  Future<void> updateDarkMode(bool isDarkMode) async{
    await Future.delayed(const Duration(microseconds: 90));
    return;
  }
}