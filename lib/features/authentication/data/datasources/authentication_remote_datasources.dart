import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
abstract class AuthenticationRemoteDataSource{
  Future<void> signInWithPhoneNumber(String phoneNumber);
  Future<void> signInWithVerificationCode(String verificationCode);
}

class AuthenticationRemoteDataSourceImpl implements AuthenticationRemoteDataSource {

  @override
  Future<void> signInWithPhoneNumber(String phoneNumber) async {
    final firebaseAuth = FirebaseAuth.instance;
    //await firebaseAuth.signInWithPhoneNumber(phoneNumber);
    await firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {
        firebaseAuth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        if(e.code == 'invalid-phone-number'){
          throw Exception("Número de teléfono inválido");
        }
        throw Exception(e);
      },
      codeSent: (String verificationId, int? resendToken) {
        // TODO: Guarda el ID de verificación para que puedas usarlo en la siguiente parte de la app
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        //TODO Auto-verificación ha expirado
      },
    );
  }

  @override
  Future<void> signInWithVerificationCode(String verificationCode) async {
    final firebaseAuth = FirebaseAuth.instance;
    try {
      String verificationId = ""; // Obtén el ID de verificación guardado anteriormente
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: verificationCode,
      );
      await firebaseAuth.signInWithCredential(credential);
    } catch (e) {
      throw Exception(e);
    }
  }
}

class HelpersFunction{
  //keys
  static String userLoggedInKey = "USER_LOGGED_IN";
  static String userPhoneNumberKey = "USER_PHONE_NUMBER";
  static String userVerificationIdKey = "USER_VERIFICATION_ID";


  //functions

  static Future<bool?> saveUserLoggedIn(bool isUserLoggedIn) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(userLoggedInKey, isUserLoggedIn);
  }

  static Future<bool?> saveUserPhoneNumber(String phoneNumber) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(userPhoneNumberKey, phoneNumber);
  }

  static Future<bool?> isUserLoggedIn() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(userLoggedInKey);
  }
}

