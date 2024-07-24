import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final String imageUrl;
  final VoidCallback onPressed;

  const CircleButton({
    required this.imageUrl,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      onPressed: onPressed,
    );
  }
}
