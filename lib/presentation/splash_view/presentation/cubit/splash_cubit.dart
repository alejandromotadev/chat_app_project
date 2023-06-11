import 'package:chat_app/data/authentification/helpers/auth_exception.dart';
import 'package:chat_app/domain/authentification/use_cases/login_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit(this._loginUseCase) : super(SplashState.none);
  final LoginUseCase _loginUseCase;

  Future<void> execute() async {
    print("SplashCubit execute()");
    await Future.delayed(const Duration(milliseconds: 70));
    try {
      final result = await _loginUseCase.validateLogin();
      print("result: $result");
      if (result) emit(SplashState.existing_user);
      print("SplashCubit.executed existing_user");
    } on AuthException catch (e) {
      if (e.errorCode == AuthErrorCode.no_auth) {
        print("SplashCubit.executed no_auth");
        emit(SplashState.none);
      }
      if (e.errorCode == AuthErrorCode.no_chat_user) {
        print("SplashCubit.executed no_chat_user");
        emit(SplashState.new_user);
      }
    }
  }
}
