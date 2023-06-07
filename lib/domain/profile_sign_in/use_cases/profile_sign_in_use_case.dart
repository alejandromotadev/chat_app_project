import 'dart:io';

import 'package:chat_app/data/attachment/repositories/attachment_repository.dart';
import 'package:chat_app/data/authentification/repositories/auth_repository.dart';
import 'package:chat_app/data/stream_api/repositories/stream_api_repository.dart';
import 'package:chat_app/domain/chat/entities/chat_user.dart';

class ProfileSignInUseCase{
  ProfileSignInUseCase(this._authRepository, this._streamApiRepository, this._uploadStorageRepository);
  final AuthRepository _authRepository;
  final StreamApiRepository _streamApiRepository;
  final UploadStorageRepository _uploadStorageRepository;

  Future<void>verify(ProfileInput input) async{
    //await _streamApiRepository.connectUser(ChatUser(id: "0", name: input.name, image: null), token)
  }
}

class ProfileInput {
  ProfileInput(this.imageFile, this.name);
  final File imageFile;
  final String name;
}