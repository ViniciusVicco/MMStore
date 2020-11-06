import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  @override
  const CustomIconButton({this.iconData,this.color,this.onTap, this.size});

  final IconData iconData;
  final Color color;
  final VoidCallback onTap;
  final double size;

  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Icon(
              iconData,
              size: size ?? 24, // Se não passar nenhum tamanho, será 24 se passar será o tamanho
              color: onTap != null ? color : Colors.grey[400],
            ),
          ),
        ),
      ),
    );
  }
}
