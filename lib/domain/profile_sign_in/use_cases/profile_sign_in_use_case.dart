import 'dart:io';
import 'package:chat_app/data/attachment/repositories/attachment_repository.dart';
import 'package:chat_app/domain/authentification/repositories/auth_repository.dart';
import 'package:chat_app/domain/chat/entities/chat_user.dart';
import 'package:chat_app/domain/stream_api/repositories/stream_api_repository.dart';

class ProfileSignInUseCase {
  ProfileSignInUseCase(this._authRepository, this._streamApiRepository,
      this._uploadStorageRepository);
  final AuthRepository _authRepository;
  final StreamApiRepository _streamApiRepository;
  final UploadStorageRepository _uploadStorageRepository;

  Future<void> verify(ProfileInput input) async {
    final auth = await _authRepository.getAuthUser();
    final token = await _streamApiRepository.getToken(auth.id);
    final image = await _uploadStorageRepository.uploadPhoto(input.imageFile, "users/${auth.id}");
    await _streamApiRepository.connectUser(
        ChatUser(id: auth.id, name: input.name, image: image), token);
  }
}

class ProfileInput {
  ProfileInput({required this.imageFile, required this.name});
  final File imageFile;
  final String name;
}
