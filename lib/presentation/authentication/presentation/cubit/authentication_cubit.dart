import 'package:chat_app/data/authentification/helpers/auth_exception.dart';
import 'package:chat_app/domain/authentification/use_cases/login_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit(this._loginUseCase) : super(AuthenticationState.none);

  final LoginUseCase _loginUseCase;

  Future<void> signIn() async {
    try {
      final result = await _loginUseCase.validateLogin();
      if (result) {
        print("Authentication Cubit, authenticated");
        emit(AuthenticationState.authenticated);
      }
    } catch (e) {
        final result = await _loginUseCase.signIn();
        if(result != null){
          emit(AuthenticationState.none);
        }
    }
  }
}
