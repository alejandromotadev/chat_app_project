import 'package:bloc/bloc.dart';
import 'package:chat_app/features/chat/domain/entities/chat_user.dart';
import 'package:chat_app/features/chat/presentation/cubit/chat_state.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class FriendSelectionCubit extends Cubit<List<ChatUserState>>{
  FriendSelectionCubit() : super([]);

  List<ChatUserState> get selectedUsers => state.where((ChatUserState e) => e.selected).toList();

  void init(ChatUserState chatUserState){
    //final List<ChatUserState> newState = state.map((ChatUserState e) => e.chatUser.id == chatUserState.chatUser.id ? ChatUserState(chatUserState.chatUser, selected: !chatUserState.selected) : e).toList();
    final newState = List.generate(10, (index) => ChatUserState(ChatUser(id: index.toString(),name: "Name: $index", avatar: '')));
    emit(newState);
  }
  void selectUser(ChatUserState chatUser){
    final index = state.indexWhere((ChatUserState e) => e.chatUser.id == chatUser.chatUser.id);
    state[index] = ChatUserState(state[index].chatUser, selected: !chatUser.selected);
    emit(List<ChatUserState>.from(state));
  }

  Future<Channel> createChannel(ChatUserState chatUserState) async{
    //TODO: Create a channel with the selected users
    throw UnimplementedError();
  }
}

class FriendsGroupCubit extends Cubit<bool>{
  FriendsGroupCubit() : super(false);

  void changeState(){
    emit(!state);
  }
}