import 'package:flutter/material.dart';

class ImagePrincipal extends StatelessWidget {
  final String imagenPrincipal;
  const ImagePrincipal({
    Key? key,
    required this.size,
    required this.imagenPrincipal,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          height: 200,
          width: size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      imagenPrincipal.isEmpty ? "" : imagenPrincipal))),
        )
      ],
    );
  }
}
