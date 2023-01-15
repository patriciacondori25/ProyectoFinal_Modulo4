// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:appconferencia/constants.dart';
import '../infraestructure/componentes/blueButton.dart';
import '../infraestructure/componentes/rowWithLowerTextSinFondo.dart';
import '../infraestructure/componentes/rowWithUpperTextSinFondo.dart';
import '../domain/entity_manager/evento.dart';
import 'unirse_evento.dart';

class DetailsScreen extends StatelessWidget {
  final Evento vlistadoeventos;

  const DetailsScreen({Key? key, required this.vlistadoeventos})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(vlistadoeventos.nombrecorto),
      body: Bodyd(
        vListadoEventos: vlistadoeventos,
      ),
    );
  }
}

AppBar buildAppBar(String texto) {
  return AppBar(
    centerTitle: true,
    elevation: 0,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          texto,
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

class Bodyd extends StatelessWidget {
  final Evento vListadoEventos;

  const Bodyd({Key? key, required this.vListadoEventos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(child: Row()),
              Container(
                height: 200,
                width: size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(vListadoEventos.fotoeventop))),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Row(
              children: <Widget>[
                Image(
                  image:
                      NetworkImage(vListadoEventos.fotoeventos), //Image.network
                  width: 100,
                  height: 100,
                  alignment: Alignment.centerLeft,
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          RowWithUpperText(
                            texto: vListadoEventos.nombreevento,
                          ),
                          RowWithTextLower(
                            texto:
                                '${vListadoEventos.fechainicio.toString().substring(0, 10)}\n${vListadoEventos.fechafin.toString().substring(0, 10)}      ${vListadoEventos.ubicacion}',
                          ),
                          const RowWithTextLower(
                            texto: '',
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          // Row(children: <Widget>[Text("\n")]),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        "Descripción del evento",
                        style: TextStyle(
                          color: ColorPrimario,
                          fontSize: 15,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        vListadoEventos.descripcionevento,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          color: ColorNegro,
                          fontSize: 14,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Row(children: const <Widget>[Text("\n\n")]),
          Align(
              alignment: Alignment.bottomCenter,
              child: BottonBlue(
                alto: 38,
                ancho: size.width - 20,
                colorboton: ColorPrimario,
                texto: "Unirse",
                colorTexto: ColorBackground,
                press: () => () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UnirseEvento(
                        idevento: vListadoEventos.evento,
                        fechainicio: vListadoEventos.fechainicio
                            .toString()
                            .substring(0, 10),
                        rutaservidor: vListadoEventos.rutaservidor,
                      ),
                    ),
                  );
                },
                habilitado: 0,
              )),
          Row(children: const <Widget>[Text("\n")]),
        ]));
  }
}
