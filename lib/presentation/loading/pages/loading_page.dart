import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  const LoadingView({super.key, required this.child, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          child,
          if(isLoading)
            Container(
              color: Colors.black26,
              child: Center(
                child: CircularProgressIndicator(),
              )
            )
        ],
      ),
    );
  }
}
