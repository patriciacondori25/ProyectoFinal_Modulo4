import 'package:appconferencia/aplication/use_case/mantenimientoEventos/eventos_screen.dart';
import 'package:appconferencia/constants.dart';
import 'package:appconferencia/infraestructure/componentes/modales.dart';
import 'package:appconferencia/infraestructure/componentes/preferenciasUsuario.dart';
import 'package:flutter/material.dart';

class AjustesScreen extends StatelessWidget {
  final String usuario;
  final String evento;
  final String tipousuario;

  const AjustesScreen(
      {Key? key,
      required this.usuario,
      required this.evento,
      required this.tipousuario})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(),
        body: Bodya(
          usuario: usuario,
          evento: evento,
          tipousuario: tipousuario,
        ));
  }
}

AppBar buildAppBar() {
  return AppBar(
    centerTitle: true,
    elevation: 0,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: const <Widget>[
        Text(
          "Ajustes",
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

class Bodya extends StatefulWidget {
  final String usuario;
  final String evento;
  final String tipousuario;

  const Bodya(
      {Key? key,
      required this.usuario,
      required this.evento,
      required this.tipousuario})
      : super(key: key);
  @override
  _BodyaState createState() => _BodyaState(usuario, evento);
}

class _BodyaState extends State<Bodya> {
  bool isSwitched = activaNotificaciones == 1 ? true : false;
  final String usuario;
  final String evento;

  _BodyaState(this.usuario, this.evento);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            (widget.tipousuario == "Administrador")
                ? LineArrow(
                    size: size,
                    texto: "Creación de eventos",
                    ultimo: Icons.keyboard_arrow_right,
                    press: () => () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const createEvent(),
                        ),
                      );
                    },
                  )
                : Container(
                    height: 0,
                  ),
            LineIcon(
              size: size,
              texto: "Cerrar sesión",
              inicio: Icons.power_settings_new,
            ),
          ]),
    );
  }
}

class LineIcon extends StatelessWidget {
  const LineIcon({
    Key? key,
    required this.size,
    required this.inicio,
    required this.texto,
    // required this.press,
  }) : super(key: key);

  final Size size;
  final IconData inicio;
  final String texto;

  //final Function press;

  @override
  Widget build(BuildContext context) {
    Modales mensajes = Modales(context);
    return Container(
        width: size.width,
        height: 42,
        decoration: BoxDecoration(color: ColorBackground, boxShadow: [
          BoxShadow(
            offset: const Offset(0, 0),
            blurRadius: 0,
            color: ColorPrimario.withOpacity(0.23),
          )
        ]),
        child: Container(
            width: size.width,
            height: 20,
            margin: const EdgeInsets.fromLTRB(kDefaultPadding, 0, 0, 0),
            child: Stack(
              children: [
                Positioned(
                  left: -5,
                  top: -5,
                  child: IconButton(
                      icon: Icon(inicio),
                      onPressed: () {
                        mensajes.cerrarSesion();
                      }),
                ),
                Positioned(
                    left: 35,
                    top: 10,
                    child: Text(
                      texto,
                      style: const TextStyle(
                        color: ColorNegro,
                        fontSize: 14,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w300,
                      ),
                    )),
              ],
            )));
  }
}

class LineIconArrow extends StatelessWidget {
  const LineIconArrow({
    Key? key,
    required this.size,
    required this.inicio,
    required this.texto,
    required this.ultimo,
    required this.press,
  }) : super(key: key);

  final Size size;
  final IconData inicio;
  final String texto;
  final IconData ultimo;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(kDefaultPadding / 12),
        width: size.width,
        height: 42,
        decoration: BoxDecoration(color: ColorBackground, boxShadow: [
          BoxShadow(
            offset: const Offset(0, 0),
            blurRadius: 0,
            color: ColorPrimario.withOpacity(0.23),
          )
        ]),
        child: Container(
            width: size.width,
            height: 50,
            margin: const EdgeInsets.fromLTRB(kDefaultPadding, 0, 0, 0),
            child: Stack(
              children: [
                Positioned(left: 3, top: 7, child: Icon(inicio)),
                Positioned(
                    left: 35,
                    top: 10,
                    child: Text(
                      texto,
                      style: const TextStyle(
                        color: ColorNegro,
                        fontSize: 14,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w300,
                      ),
                    )),
                Positioned(
                  left: size.width - 70,
                  top: -5,
                  child: IconButton(icon: Icon(ultimo), onPressed: press()),
                ),
              ],
            )));
  }
}

class LineArrow extends StatelessWidget {
  const LineArrow({
    Key? key,
    required this.size,
    required this.texto,
    required this.ultimo,
    required this.press,
  }) : super(key: key);

  final Size size;

  final String texto;
  final IconData ultimo;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(kDefaultPadding / 12),
        width: size.width,
        height: 42,
        decoration: BoxDecoration(color: ColorBackground, boxShadow: [
          BoxShadow(
            offset: const Offset(0, 0),
            blurRadius: 0,
            color: ColorPrimario.withOpacity(0.23),
          )
        ]),
        child: Container(
            width: size.width,
            height: 50,
            margin: const EdgeInsets.fromLTRB(kDefaultPadding, 0, 0, 0),
            child: Stack(
              children: [
                Positioned(
                    left: 3,
                    top: 10,
                    child: Text(
                      texto,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w300,
                      ),
                    )),
                Positioned(
                  left: size.width - 70,
                  top: -5,
                  child: IconButton(icon: Icon(ultimo), onPressed: press()),
                ),
              ],
            )));
  }
}

class RecursosLine extends StatelessWidget {
  const RecursosLine({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(kDefaultPadding / 12),
        width: size.width,
        height: 42,
        decoration: BoxDecoration(color: ColorBackground, boxShadow: [
          BoxShadow(
            offset: const Offset(0, 0),
            blurRadius: 0,
            color: ColorPrimario.withOpacity(0.23),
          )
        ]),
        child: Container(
          margin: const EdgeInsets.fromLTRB(kDefaultPadding, 0, 0, 0),
          child: Row(
            children: const [
              Text(
                "Recursos",
                style: TextStyle(
                  color: ColorNegro,
                  fontSize: 16,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ));
  }
}
