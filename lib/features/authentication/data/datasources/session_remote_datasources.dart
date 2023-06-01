abstract class SessionRemoteDataSource {
  Future<void> signOut();
  Future<bool> isSignedIn();
}