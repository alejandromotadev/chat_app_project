import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:chat_app/domain/chat/use_cases/group_use_case.dart';
import 'package:chat_app/domain/image_picker/repositories/image_picker_repository.dart';
import 'package:chat_app/domain/stream_api/repositories/stream_api_repository.dart';
import 'package:chat_app/presentation/chat/presentation/cubit/chat_state.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class FriendSelectionCubit extends Cubit<List<ChatUserState>> {
  FriendSelectionCubit(this._streamApiRepository) : super([]);
  final StreamApiRepository _streamApiRepository;

  List<ChatUserState> get selectedUsers =>
      state.where((ChatUserState e) => e.selected).toList();

  Future<void> init() async {
    final list = (await _streamApiRepository.getChatUsers())
        .map((e) => ChatUserState(e))
        .toList();
    emit(list);
  }

  void selectUser(ChatUserState chatUser) {
    final index = state
        .indexWhere((ChatUserState e) => e.chatUser.id == chatUser.chatUser.id);
    state[index] =
        ChatUserState(state[index].chatUser, selected: !chatUser.selected);
    emit(List<ChatUserState>.from(state));
  }

  Future<Channel> createFriendChannel(ChatUserState chatUserState) async {
    final channel =
        _streamApiRepository.createSimpleChat(chatUserState.chatUser.id);
    return channel;
  }
}

class FriendsGroupCubit extends Cubit<bool> {
  FriendsGroupCubit() : super(false);

  void changeState() {
    emit(!state);
  }
}

class GroupSelectionCubit extends Cubit<GroupSelectionState> {
  GroupSelectionCubit(
    this.members,
    this._createGroupUseCase,
    this._imagePickerRepository,
  ) : super(GroupSelectionState(File(""),
            channel: Channel(
              StreamChatClient(""),
              "",
              "",
            )));
  final List<ChatUserState> members;
  final nameTextController = TextEditingController();
  final CreateGroupUseCase _createGroupUseCase;
  final ImagePickerRepository _imagePickerRepository;

  void createGroup() async {
    emit(GroupSelectionState(state.file,
        isLoading: true,
        channel: Channel(
          StreamChatClient(""),
          "",
          "",
        )));
    try {
      final channel = await _createGroupUseCase.createGroup(
        CreateGroupInput(
          imageFile: state.file,
          name: nameTextController.text,
          members: members.map((e) => e.chatUser.id).toList(),
        ),
      );
      emit(GroupSelectionState(state.file, channel: channel, isLoading: true));
      print("channel created");
    } catch (e) {
      print(e);
    }
  }

  void pickImage() async {
    try {
      print("pick image chat cubit");
      final image = await _imagePickerRepository.pickImage();
      emit(GroupSelectionState(image, channel: state.channel));
    } catch (e) {
      print(e);
    }
  }
}
