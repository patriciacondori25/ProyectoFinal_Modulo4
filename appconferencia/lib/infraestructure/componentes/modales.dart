// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:appconferencia/infraestructure/componentes/blueButton.dart';
import '../../constants.dart';

class Modales {
  final BuildContext context;
  Modales(this.context);

  void modalTextoBoton(String texto, Color colorTextoBoton, String textoBoton) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                content: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      // color: ColorBackground,
                    ),
                    child: Text(texto,
                        style: TextStyle(), textAlign: TextAlign.justify)),
                actions: <Widget>[
                  Row(
                    children: [
                      Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          textStyle: TextStyle(
                              //    color: ColorBackground,
                              ),
                          elevation: 0,
                        ),
                        child: Text(
                          textoBoton,
                          style: TextStyle(color: colorTextoBoton),
                        ),
                      )
                    ],
                  )
                ]));
  }

  void cerrarSesion() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(6))),
          title: SizedBox(
            width: 10,
            //height: 20,
            child: Text(
              "¿Desea cerrar sesión?",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ColorNegro,
                fontSize: 14,
              ),
            ),
          ),
          backgroundColor: ColorBackground,
          actions: <Widget>[
            Row(
              children: [
                Spacer(),
                BottonBlue(
                  alto: 40,
                  ancho: 90,
                  colorboton: ColorPrimario,
                  texto: "Volver",
                  colorTexto: ColorBackground,
                  press: () => () {
                    Navigator.of(context).pop();
                  },
                  habilitado: 0,
                ),
                SizedBox(
                  width: 10,
                ),
                BottonBlue(
                  alto: 40,
                  ancho: 90,
                  colorboton: Color(0xff2fad66),
                  texto: "Salir",
                  colorTexto: ColorBackground,
                  press: () => () {
                    Navigator.popUntil(context, (r) => r.settings.name == '/');
                  },
                  habilitado: 0,
                ),
                Spacer(),
              ],
            ),
            SizedBox(
              height: 15,
            )
          ]),
    );
  }

  void confirmar(
      String textoConfirmacion, Function noacepta, Function siacepta) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(6))),
          title: SizedBox(
            width: 10,
            //height: 20,
            child: Text(
              textoConfirmacion,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ColorNegro,
                fontSize: 14,
              ),
            ),
          ),
          backgroundColor: ColorBackground,
          actions: <Widget>[
            Row(
              children: [
                Spacer(),
                BottonBlue(
                  alto: 40,
                  ancho: 90,
                  colorboton: ColorPrimario,
                  texto: "No",
                  colorTexto: ColorBackground,
                  press: () => () {
                    noacepta();
                    Navigator.of(context).pop();
                  },
                  habilitado: 0,
                ),
                SizedBox(
                  width: 10,
                ),
                BottonBlue(
                  alto: 40,
                  ancho: 90,
                  colorboton: Color(0xff2fad66),
                  texto: "Si",
                  colorTexto: ColorBackground,
                  press: () => () {
                    siacepta();
                    Navigator.of(context).pop();
                  },
                  habilitado: 0,
                ),
                Spacer(),
              ],
            ),
            SizedBox(
              height: 15,
            )
          ]),
    );
  }
}
