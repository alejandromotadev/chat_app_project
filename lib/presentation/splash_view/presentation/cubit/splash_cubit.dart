import 'package:chat_app/data/authentification/helpers/auth_exception.dart';
import 'package:chat_app/domain/authentification/use_cases/login_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit(this._loginUseCase) : super(SplashState.none);
  final LoginUseCase _loginUseCase;

  Future<void> execute() async {
    await Future.delayed(const Duration(milliseconds: 70));
    try {
      print("validate login");
      final result = await _loginUseCase.validateLogin();
      if (result){
        print("existing user");
        emit(SplashState.existing_user);
      }
    } on AuthException catch (e) {
      if (e.errorCode == AuthErrorCode.no_auth) {
        print("no auth");
        emit(SplashState.none);
      }
      if (e.errorCode == AuthErrorCode.no_chat_user) {
        print("new user");
        emit(SplashState.new_user);
      }
    }
  }
}
