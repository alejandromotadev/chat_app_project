import 'dart:io';
import 'package:chat_app/features/welcome/presentation/cubit/welcome_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

