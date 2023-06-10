import 'dart:io';

import 'package:chat_app/domain/chat/entities/chat_user.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChatUserState{
  const ChatUserState(this.chatUser, {this.selected = false});
  final ChatUser chatUser;
  final bool selected;
}

class GroupSelectionState{
  const GroupSelectionState(this.file, {required this.channel});
  final File file;
  final Channel channel;
}