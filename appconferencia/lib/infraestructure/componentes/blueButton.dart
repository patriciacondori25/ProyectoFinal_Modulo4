// ignore_for_file: file_names, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:appconferencia/constants.dart';

class BottonBlue extends StatelessWidget {
  const BottonBlue(
      {Key? key,
      required this.ancho,
      required this.alto,
      required this.press,
      required this.texto,
      required this.colorboton,
      required this.colorTexto,
      required this.habilitado})
      : super(key: key);

  final double ancho;
  final double alto;
  final Function press;
  final String texto;
  final Color colorboton;
  final Color colorTexto;
  final int habilitado;

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: ancho, //380,
      height: alto, //38,
      shape: RoundedRectangleBorder(
          side: const BorderSide(color: Color(0xff969696), width: 1),
          borderRadius: BorderRadius.circular(5)),

      child: ConstrainedBox(
        constraints: BoxConstraints.tightFor(width: ancho, height: alto),
        child: ElevatedButton(
          onPressed: habilitado == 1 ? null : press(),
          child: Text(
            texto,
            style: TextStyle(
              color: colorTexto,
              fontSize: 15,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w600,
            ),
          ),
          style: ElevatedButton.styleFrom(
              backgroundColor: colorboton,
              textStyle: const TextStyle(
                color: ColorBackground,
              ),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              )),
        ),
      ),
    );
  }
}
