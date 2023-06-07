import 'dart:io';

class WelcomeState{
  const WelcomeState(this.file, {this.success=false});
  final File file;
  final bool success;
}