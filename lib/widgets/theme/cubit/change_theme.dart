import 'package:chat_app/data/persistent_storage/repositories/persistent_storage_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppThemeCubit extends Cubit<bool> {
  AppThemeCubit(this.persistentStorageRepository) : super(false);
  bool _isDark = false;
  bool get isDark => _isDark;
  final PersistentStorageRepository persistentStorageRepository;

  Future<void>init() async{
    _isDark = await persistentStorageRepository.isDarkMode();
    emit(_isDark);
  }
  Future<void>updateTheme(bool isDarkMode) async{
    _isDark = isDarkMode;
    await persistentStorageRepository.updateDarkMode(isDarkMode);
    emit(_isDark);
  }
}