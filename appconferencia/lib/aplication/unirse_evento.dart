// ignore_for_file: library_private_types_in_public_api, no_logic_in_create_state, unrelated_type_equality_checks, unused_local_variable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:appconferencia/domain/entity_manager/evento.dart';
import 'package:appconferencia/domain/entity_manager/usuario.dart';
import '../infraestructure/componentes/blueButton.dart';
import '../infraestructure/componentes/modales.dart';
import '../infraestructure/componentes/preferenciasUsuario.dart';
import '../infraestructure/componentes/rowCenterText.dart';
import '../infraestructure/componentes/textFieldWithTexto.dart';
import '../constants.dart';
import '../infraestructure/controller/readData.dart';
import 'use_case/menuPrincipal/mainPlanner_container.dart';

class UnirseEvento extends StatelessWidget {
  final String idevento;
  final String fechainicio;
  final String rutaservidor;

  const UnirseEvento(
      {Key? key,
      required this.idevento,
      required this.fechainicio,
      required this.rutaservidor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar("Unirse al evento", context),
      body: Bodyue(
        idevento: idevento,
        fechainicio: fechainicio,
        rutaservidor: rutaservidor,
      ),
    );
  }
}

AppBar buildAppBar(String texto, BuildContext context1) {
  Modales mensajes = Modales(context1);
  return AppBar(
    title: Text(texto),
    actions: <Widget>[
      Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: GestureDetector(
            onTap: () => mensajes.modalTextoBoton(
                "\nSu organizador le envio un correo electrónico de invitación para descargar la aplicación. Ese correo electrónico proporciona su código de invitación. En caso no lo encuentre compruebe la carpeta de correo no deseado.",
                Colors.red,
                'Cerrar'),
            child: const Icon(Icons.error),
          )),
    ],
  );
}

class Bodyue extends StatefulWidget {
  final String idevento;
  final String fechainicio;
  final String rutaservidor;

  const Bodyue(
      {Key? key,
      required this.idevento,
      required this.fechainicio,
      required this.rutaservidor})
      : super(key: key);
  @override
  _BodyueState createState() => _BodyueState(idevento, fechainicio);
}

class _BodyueState extends State<Bodyue> {
  final String idevento;
  final String fechainicio;
  final myController = TextEditingController();
  PreferenciasUsuario pref = PreferenciasUsuario();

  void cargaPreferencias() async {
    activaNotificaciones = await pref.getActivaNotificaciones();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    cargaPreferencias();
  }

  _BodyueState(this.idevento, this.fechainicio);
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    Size size = MediaQuery.of(context).size;
    Modales mensajes = Modales(context);

    return SingleChildScrollView(
        child: Column(children: <Widget>[
      const RowCenterText(
        texto: "",
      ),
      const SizedBox(
        height: 5,
      ),
      Row(
        children: <Widget>[
          const Spacer(),
          TextFieldwithTexto(
            myController: myController,
            texto: "Invitación",
            largoporcentaje: 0.6,
          ),
          const SizedBox(
            width: 10,
          ),
          BottonBlue(
            alto: 48,
            ancho: size.width * 0.25,
            colorboton: ColorPrimario,
            texto: "Ingresar",
            colorTexto: ColorBackground,
            press: () => () async {
              readData validarUsuario = readData();
              Usuario usuariovalidado = await validarUsuario.validarUsuario(
                  myController.text, idevento);

              if (usuariovalidado.codigoInvitacion == myController.text) {
                myController.text = "Existe";
                final Evento eventoSelected =
                    await validarUsuario.datosEvento(idevento);

                pref.setCodigoUsuario(usuariovalidado.usuario);
                pref.setevento(idevento);
                pref.setTipoUsuario(usuariovalidado.tipoUsuario);
                pref.setRolUsuario(usuariovalidado.rolUsuario);
                pref.setFotoEventoPrincipal(eventoSelected.fotoeventop);
                pref.setNombreEvento(eventoSelected.nombreevento);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainPlanner(
                      evento: eventoSelected,
                      usuario: usuariovalidado,
                    ),
                  ),
                );
              } else {
                mensajes.modalTextoBoton(
                    'Código erroneo', Colors.red, 'Cerrar');
              }
            },
            habilitado: 0,
          ),
          const Spacer(),
        ],
      ),
    ]));
  }
}
