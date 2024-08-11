import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingManager extends StatelessWidget {
  const LoadingManager({super.key, required this.isLoading, required this.child});
 final bool isLoading;
 final Widget child;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
       child,
       if(isLoading)...[
        Container(
          color: Colors.black.withOpacity(0.3),
        ),
        Center(
         child: Lottie.asset('assets/animation/loading.json',width: 100,height: 100),
       )],

      ],
    );
  }
}