import 'package:flutter/material.dart';

Future<void> pushToPage(BuildContext context, String routeName) async {
  await Navigator.pushNamed(context, routeName);
}

Future<void> pushToPageWithReplacement(BuildContext context, String routeName) async {
  await Navigator.pushReplacementNamed(context, routeName);
}

Future<void> pushToPageWithClearStack(BuildContext context, String routeName) async {
  await Navigator.popAndPushNamed(context, routeName);
}
