// ignore_for_file: file_names, no_logic_in_create_state, library_private_types_in_public_api, depend_on_referenced_packages

import 'package:appconferencia/constants.dart';
import 'package:flutter/material.dart';
import 'package:appconferencia/domain/entity_manager/evento.dart';
import 'package:appconferencia/domain/entity_manager/usuario.dart';
import 'package:intl/intl.dart';
import '../mantenimientoAjustes/ajustes_screen.dart';
import 'mainPlanner_Asistentes.dart';
import 'mainPlanner_Cronograma.dart';
import 'mainPlanner_home.dart';

class MainPlanner extends StatefulWidget {
  final Usuario usuario;
  final Evento evento;

  const MainPlanner({
    Key? key,
    required this.usuario,
    required this.evento,
  }) : super(key: key);

  @override
  _MainPlannerState createState() => _MainPlannerState(
        [
          const Bodymp(),
          Bodyc(
            fechas: [
              DateFormat('yyyy-MM-dd').format(
                DateTime.parse(evento.fechainicio.toString().substring(0, 10)),
              ),
              DateFormat('yyyy-MM-dd').format(
                DateTime.parse(evento.fechainicio.toString().substring(0, 10))
                    .add(const Duration(days: 1)),
              ),
              DateFormat('yyyy-MM-dd').format(
                DateTime.parse(evento.fechainicio.toString().substring(0, 10))
                    .add(const Duration(days: 2)),
              ),
              DateFormat('yyyy-MM-dd').format(
                DateTime.parse(evento.fechainicio.toString().substring(0, 10))
                    .add(const Duration(days: 3)),
              ),
              DateFormat('yyyy-MM-dd').format(
                DateTime.parse(evento.fechainicio.toString().substring(0, 10))
                    .add(const Duration(days: 4)),
              ),
              DateFormat('yyyy-MM-dd').format(
                DateTime.parse(evento.fechainicio.toString().substring(0, 10))
                    .add(const Duration(days: 5)),
              ),
              DateFormat('yyyy-MM-dd').format(
                DateTime.parse(evento.fechainicio.toString().substring(0, 10))
                    .add(const Duration(days: 6)),
              ),
              DateFormat('yyyy-MM-dd').format(
                DateTime.parse(evento.fechainicio.toString().substring(0, 10))
                    .add(const Duration(days: 7)),
              ),
              DateFormat('yyyy-MM-dd').format(
                DateTime.parse(evento.fechainicio.toString().substring(0, 10))
                    .add(const Duration(days: 8)),
              ),
              DateFormat('yyyy-MM-dd').format(
                DateTime.parse(evento.fechainicio.toString().substring(0, 10))
                    .add(const Duration(days: 9)),
              ),
            ],
            evento: evento.evento,
          ),
          mainplanner_asistentes(
            idevento: evento.evento,
            imagenPrincipal: evento.fotoeventop,
            tipousuario: usuario.tipoUsuario,
          ),
        ],
        usuario.usuario,
        evento.evento,
      );
}

class _MainPlannerState extends State<MainPlanner> {
  final String usuario;
  final String evento;

  final List<Widget> children;
  _MainPlannerState(this.children, this.usuario, this.evento);

  int indiceActual = 0;

  final List<String> titulos = [
    "Home",
    "Cronograma",
    "Asistentes",
  ];
  final List<IconData> iconos = [
    Icons.portrait,
    Icons.paste,
    Icons.emoji_people,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(iconos[indiceActual], titulos[indiceActual], context,
          usuario, evento, widget.usuario.tipoUsuario),
      body: children[indiceActual],
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      fixedColor: ColorPrimario,
      type: BottomNavigationBarType.fixed,
      currentIndex: indiceActual,
      onTap: (int index) => setState(() => indiceActual = index),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.portrait),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.paste),
          label: 'Cronograma',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.emoji_people),
          label: 'Asistentes',
        ),
      ],
    );
  }
}

AppBar buildAppBar(IconData rutaicono, String texto, BuildContext context1,
    String usuario, String evento, String tipousuario) {
  return AppBar(
    centerTitle: true,
    elevation: 0,
    leading: IconButton(
      icon: Icon(rutaicono),
      onPressed: () {
        const Bodymp();
      },
    ),
    title: Row(
      children: <Widget>[
        Text(
          texto,
          textAlign: TextAlign.left,
          style: const TextStyle(fontSize: 18),
        ),
      ],
    ),
    actions: <Widget>[
      Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: GestureDetector(
            onTap: () => showDialog(
                context: context1,
                builder: (context) => AjustesScreen(
                      evento: evento,
                      usuario: usuario,
                      tipousuario: tipousuario,
                    )),
            child: const Icon(Icons.settings),
          )),
    ],
  );
}
