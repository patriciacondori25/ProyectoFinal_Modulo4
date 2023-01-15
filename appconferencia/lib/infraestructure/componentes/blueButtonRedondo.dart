import 'package:flutter/material.dart';
import 'package:appconferencia/constants.dart';

class BottonBlueRedondo extends StatelessWidget {
  const BottonBlueRedondo({
    Key? key,
    required this.ancho,
    required this.alto,
    required this.press,
    required this.texto,
    required this.colorboton,
    required this.colorTexto,
    required this.icono,
    required this.habilitado,
  }) : super(key: key);

  final double ancho;
  final double alto;
  final Function press;
  final String texto;
  final Color colorboton;
  final Color colorTexto;
  final IconData icono;
  final int habilitado;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ancho, //ancho,
      height: alto, //alto,
      decoration: BoxDecoration(
        color: colorboton,
        shape: BoxShape.circle,
      ),

      child: Center(
        child: IconButton(
          onPressed: habilitado == 1 ? null : press(),
          icon: Icon(
            icono,
            color: ColorBackground,
            size: 20,
          ),
        ),
      ),
    );
  }
}
