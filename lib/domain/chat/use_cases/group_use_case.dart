import 'dart:io';

import 'package:chat_app/data/attachment/repositories/attachment_repository.dart';
import 'package:chat_app/data/stream_api/repositories/stream_api_repository.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class CreateGroupUseCase {
  CreateGroupUseCase(
    this._streamApiRepository,
    this._uploadStorageRepository,
  );

  final StreamApiRepository _streamApiRepository;
  final UploadStorageRepository _uploadStorageRepository;

  Future<Channel> createGroup(CreateGroupInput input) async {
    final channelId = Uuid().v4();
    final imageResult =
        await _uploadStorageRepository.uploadPhoto(input.imageFile, "channels");
    final channel = await _streamApiRepository.createGroupChat(
        channelId, input.name, input.members, imageResult);
    return channel;
  }
}

class CreateGroupInput {
  CreateGroupInput(
      {required this.imageFile, required this.name, required this.members});
  final File imageFile;
  final String name;
  final List<String> members;
}
