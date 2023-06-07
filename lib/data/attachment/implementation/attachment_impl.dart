import 'dart:io';

import 'package:chat_app/data/attachment/repositories/attachment_repository.dart';

class UploadStorageImpl extends UploadStorageRepository{
  @override
  Future<String> uploadPhoto(File file, String path) async {
    return 'https://lh3.googleusercontent.com/a-/AOh14GiUjlWnt4MNgr7Wmeyb3PzXlka4E8PFEIlF27oIxIA';
  }
}