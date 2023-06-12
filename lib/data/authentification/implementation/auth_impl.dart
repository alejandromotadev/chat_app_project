import 'package:chat_app/data/authentification/helpers/auth_exception.dart';
import 'package:chat_app/data/authentification/repositories/auth_repository.dart';
import 'package:chat_app/domain/authentification/entities/auth_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthImpl extends AuthRepository{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  @override
  Future<AuthUser> getAuthUser() async{
    final user = _auth.currentUser;
    if(user == null){
      throw AuthException(AuthErrorCode.no_auth);
    }
    return AuthUser(user.uid);
  }

  @override
  Future<AuthUser> signIn() async{
    try{
      UserCredential userCredential;
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      final OAuthCredential googleAuthCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      userCredential = await _auth.signInWithCredential(googleAuthCredential);
      final user = userCredential.user;
      return AuthUser(user!.uid);

    } catch(e){
      print("AuthImpl.signIn() error: $e");
      throw Exception("Error signing in");
    }
  }

  @override
  Future<void> logout() async{
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
