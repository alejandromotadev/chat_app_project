import 'package:bloc/bloc.dart';
import 'package:chat_app/domain/chat/entities/chat_user.dart';
import 'package:chat_app/presentation/chat/presentation/cubit/chat_state.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class FriendSelectionCubit extends Cubit<List<ChatUserState>> {
  FriendSelectionCubit() : super([]);

  List<ChatUserState> get selectedUsers =>
      state.where((ChatUserState e) => e.selected).toList();

  Future<void> init() async {
    //final List<ChatUserState> newState = state.map((ChatUserState e) => e.chatUser.id == chatUserState.chatUser.id ? ChatUserState(chatUserState.chatUser, selected: !chatUserState.selected) : e).toList();
    final list = List.generate(
        10,
        (index) => ChatUserState(
            ChatUser(id: index.toString(), name: "User: $index", image: "https://picsum.photos/200/300")));
    emit(list);
  }

  void selectUser(ChatUserState chatUser) {
    final index = state
        .indexWhere((ChatUserState e) => e.chatUser.id == chatUser.chatUser.id);
    state[index] =
        ChatUserState(state[index].chatUser, selected: !chatUser.selected);
    emit(List<ChatUserState>.from(state));
  }

  Future<Channel> createChannel(ChatUserState chatUserState) async {
    //TODO: Create a channel with the selected users
    throw UnimplementedError();
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
  ) : super(GroupSelectionState());
  final List<ChatUserState> members;
  final groupNameController = TextEditingController();

  void createGroup() async {
    emit(GroupSelectionState());
  }

  void pickImage() async {
    emit(GroupSelectionState());
  }
}
