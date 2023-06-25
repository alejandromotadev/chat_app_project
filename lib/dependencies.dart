import 'package:chat_app/controller/network_controller.dart';
import 'package:chat_app/data/attachment/implementation/attachment_impl.dart';
import 'package:chat_app/data/attachment/repositories/attachment_repository.dart';
import 'package:chat_app/data/authentification/implementation/auth_impl.dart';
import 'package:chat_app/data/image_picker/implementation/image_picker_impl.dart';
import 'package:chat_app/data/persistent_storage/implementation/persistent_storage_impl.dart';
import 'package:chat_app/data/stream_api/implementation/stream_apl_impl.dart';
import 'package:chat_app/domain/authentification/repositories/auth_repository.dart';
import 'package:chat_app/domain/authentification/use_cases/login_use_case.dart';
import 'package:chat_app/domain/authentification/use_cases/logout_use_case.dart';
import 'package:chat_app/domain/chat/use_cases/group_use_case.dart';
import 'package:chat_app/domain/image_picker/repositories/image_picker_repository.dart';
import 'package:chat_app/domain/persistent_storage/repositories/persistent_storage_repository.dart';
import 'package:chat_app/domain/profile_sign_in/use_cases/profile_sign_in_use_case.dart';
import 'package:chat_app/domain/stream_api/repositories/stream_api_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

List<RepositoryProvider> buildRepositories(StreamChatClient client) {
  return [
    RepositoryProvider<StreamApiRepository>(
        create: (context) => StreamApiImpl(client)),
    RepositoryProvider<PersistentStorageRepository>(
        create: (context) => PersistentStorageImpl()),
    RepositoryProvider<AuthRepository>(
        create: (context) => AuthImpl()),
    RepositoryProvider<UploadStorageRepository>(
        create: (context) => UploadStorageImpl()),
    RepositoryProvider<ImagePickerRepository>(
        create: (context) => ImagePickerImpl()),
    RepositoryProvider<LoginUseCase>(
      create: (context) => LoginUseCase(
        context.read(),
        context.read(),
      ),
    ),
    RepositoryProvider<LogoutUseCase>(
      create: (context) => LogoutUseCase(
        context.read(),
        context.read(),
      ),
    ),
    RepositoryProvider<ProfileSignInUseCase>(
      create: (context) =>
          ProfileSignInUseCase(context.read(), context.read(), context.read()),
    ),
    RepositoryProvider<CreateGroupUseCase>(
      create: (context) => CreateGroupUseCase(
        context.read(),
        context.read(),
      ),
    ),
  ];
}

class ControllerInjection{
  static void init(){
    Get.put<NetworkController>(NetworkController(),permanent: true);
  }
}
