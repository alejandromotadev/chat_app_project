import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeAppTheme extends Cubit<bool> {
  ChangeAppTheme() : super(false);

  Future<void>changeTheme() async{
    emit(true);
  }
}