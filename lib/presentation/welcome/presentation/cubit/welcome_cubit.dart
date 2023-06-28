import 'dart:io';
import 'package:chat_app/domain/image_picker/repositories/image_picker_repository.dart';
import 'package:chat_app/domain/profile_sign_in/use_cases/profile_sign_in_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'welcome_state.dart';

class WelcomeVerifyCubit extends Cubit<WelcomeState> {
  WelcomeVerifyCubit(this._profileSignInUseCase, this._imagePicker)
      : super(WelcomeState(File("")));
  final usernameController = TextEditingController();
  final ImagePickerRepository _imagePicker;
  final ProfileSignInUseCase _profileSignInUseCase;

  Future<void> startChatting() async {
    await Future.delayed(const Duration(milliseconds: 90));
    final file = state.file;
    final username = usernameController.text;
    await _profileSignInUseCase.verify(ProfileInput(
        imageFile: file,
        name: username));
    emit(WelcomeState(file, success: true));
  }

  Future<void> pickImage() async {
    print("pickImage");
    final file = await _imagePicker.pickImage();
    emit(WelcomeState(file));
  }
}
