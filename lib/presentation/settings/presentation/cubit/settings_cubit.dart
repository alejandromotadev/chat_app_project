import 'package:chat_app/domain/authentification/use_cases/logout_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsSwitchCubit extends Cubit<bool>{
  SettingsSwitchCubit(bool state) : super(state);

  void changeDarkMode(bool isDark) => emit(isDark);
}

class SettingsLogoutCubit extends Cubit<void>{
  SettingsLogoutCubit(this._logoutUseCase) : super(null);
  final LogoutUseCase _logoutUseCase;
  void logout()async{
    await _logoutUseCase.logout();
    emit(null);
  }
}