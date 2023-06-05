abstract class AuthenticationRepository{
  Future<void> signInWithPhoneNumber(String phoneNumber);
  Future<void> signInWithVerificationCode(String verificationCode);
}
