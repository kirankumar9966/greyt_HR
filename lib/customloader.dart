// custom_lottie_mini_loader.dart
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomLottieMiniLoader extends StatelessWidget {
  final double size;
  final String lottieAsset;

  const CustomLottieMiniLoader({
    Key? key,
    this.size = 60,
    this.lottieAsset = 'assets/images/loader.json',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      lottieAsset,
      width: size,
      height: size,
      fit: BoxFit.contain,
    );
  }
}
