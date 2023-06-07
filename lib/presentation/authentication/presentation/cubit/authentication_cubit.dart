import 'package:flutter_bloc/flutter_bloc.dart';
import 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationState.none);

  Future<void> signIn() async {
    await Future.delayed(const Duration(seconds: 1));
    emit(AuthenticationState.none);
  }
}