import 'dart:io';
import 'package:chat_app/data/image_picker/repositories/image_picker_repository.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerImpl extends ImagePickerRepository{
  @override
  Future<File>pickImage() async{
    print("Pick image IMPLEMENTATION");
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery , maxWidth: 500);
    return File(pickedFile!.path);
  }
}