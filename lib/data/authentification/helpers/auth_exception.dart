enum AuthErrorCode{
  no_auth,
  no_chat_user
}
class AuthException implements Exception{
  AuthException(this.errorCode);
  final AuthErrorCode errorCode;
}