import 'package:chat_app/features/chat/domain/entities/chat_user.dart';

class ChatUserState{
  const ChatUserState(this.chatUser, {this.selected = false});
  final ChatUser chatUser;
  final bool selected;
}