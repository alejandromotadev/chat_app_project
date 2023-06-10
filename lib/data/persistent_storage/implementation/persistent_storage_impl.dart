
import 'package:chat_app/data/persistent_storage/repositories/persistent_storage_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersistentStorageImpl extends PersistentStorageRepository{
  static const _isDarkModePref = "isDarkMode";
  @override
  Future<bool> isDarkMode() async{
    final preference = await SharedPreferences.getInstance();
    return preference.getBool(_isDarkModePref) ?? false;
  }

  @override
  Future<void> updateDarkMode(bool isDarkMode) async{
    final preference = await SharedPreferences.getInstance();
    preference.setBool(_isDarkModePref, isDarkMode);
  }
}