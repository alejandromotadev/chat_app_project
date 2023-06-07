import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'welcome_state.dart';

class WelcomeVerifyCubit extends Cubit<WelcomeState>{
  WelcomeVerifyCubit () : super(WelcomeState(File("")));
  final usernameController = TextEditingController();

  Future<void> startChatting() async{
    await Future.delayed(const Duration(seconds: 2));
    final file = state.file;
    final username = usernameController.text;
    emit(WelcomeState(file, success: true));
  }

  Future<void> pickImage() async {
    final file = File("");
    emit (WelcomeState(file));

  }
}

