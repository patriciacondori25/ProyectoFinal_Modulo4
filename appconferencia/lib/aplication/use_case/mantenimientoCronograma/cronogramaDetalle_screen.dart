import 'package:appconferencia/constants.dart';
import 'package:appconferencia/domain/entity_manager/cronogramaDetalleVista.dart';
import 'package:appconferencia/infraestructure/componentes/containerConTextoSimple.dart';
import 'package:appconferencia/infraestructure/controller/readData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class CronogramaDetalle extends StatelessWidget {
  final String cronograma;
  final String evento;

  const CronogramaDetalle(
      {Key? key, required this.cronograma, required this.evento})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(),
        body: Bodycd(
          cronograma: cronograma,
          evento: evento,
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
          "Detalles",
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

class Bodycd extends StatelessWidget {
  final String cronograma;
  final String evento;

  const Bodycd({Key? key, required this.cronograma, required this.evento})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    readData read = readData();
    var conectate = read.readCronogramaDetalleVista(evento, cronograma);
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: FutureBuilder<cronogramaDetalleVista>(
        future: conectate,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            cronogramaDetalleVista vcronogramadetalle = snapshot.data!;
            return CronogramaDetalleFull(
              size: size,
              vcronogramadetalle: vcronogramadetalle,
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          //return  a circular progress indicator.
          return const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.transparent));
        },
      ),
    );
  }
}

class CronogramaDetalleFull extends StatelessWidget {
  final cronogramaDetalleVista vcronogramadetalle;
  const CronogramaDetalleFull({
    Key? key,
    required this.size,
    required this.vcronogramadetalle,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ContainerConTextoSimple(
          size: size,
          tamanoLetra: 16,
          texto: vcronogramadetalle.textocronograma,
        ),
        ContainerMinutesAndQuantity(
            size: size, vcronogramadetalle: vcronogramadetalle),
        RowWithTextAndIcon(
          rutaIcono: "assets/icons/person_outline_24px.svg",
          texto: vcronogramadetalle.conferencista,
        ),
        RowWithTextAndIcon(
          rutaIcono: "assets/icons/person_pin_circle_24px.svg",
          texto: vcronogramadetalle.area,
        ),
        RowWithTextAndIcon(
          rutaIcono: "assets/icons/schedule_24px.svg",
          texto: vcronogramadetalle.hora,
        ),
        //ShareLeft(size: size),
        vcronogramadetalle.avisos.isNotEmpty
            ? RedBox(size: size, vcronogramadetalle: vcronogramadetalle)
            : Container(
                height: 0,
              ),
        DetallesCurso(
          size: size,
          vcronogramadetalle: vcronogramadetalle,
        )
      ],
    );
  }
}

class DetallesCurso extends StatelessWidget {
  final cronogramaDetalleVista vcronogramadetalle;
  const DetallesCurso({
    Key? key,
    required this.size,
    required this.vcronogramadetalle,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(
          kDefaultPadding / 2, kDefaultPadding / 2, kDefaultPadding / 2, 0),
      width: size.width,
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 30,
          ),
          Row(
            children: const [
              Text(
                "Resumen",
                style: TextStyle(
                  color: ColorNegro,
                  fontSize: 13,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  vcronogramadetalle.descripcioncronograma,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    color: ColorNegro,
                    fontSize: 13,
                    fontFamily: "Poppins",
                    //fontWeight: FontWeight.w300,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: const [
              Text(
                "Detalles Especificos",
                style: TextStyle(
                  color: ColorNegro,
                  fontSize: 13,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  vcronogramadetalle.detallesEspecificos,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    color: ColorNegro,
                    fontSize: 13,
                    fontFamily: "Poppins",
                    //fontWeight: FontWeight.w300,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: const [
              Text(
                "Enlace video conferencia",
                style: TextStyle(
                  color: ColorNegro,
                  fontSize: 13,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                    child: Text(vcronogramadetalle.link,
                        style: const TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue,
                            fontSize: 13,
                            fontFamily: "Poppins")),
                    onTap: () async {
                      final url = vcronogramadetalle.link;

                      // ignore: deprecated_member_use
                      if (await canLaunch(url)) {
                        // ignore: deprecated_member_use
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    }

                    // do what you need to do when "Click here" gets clicked
                    ),
              ),
            ],
          ),
          Row(
            children: const [Text(" ")],
          ),
        ],
      ),
    );
  }
}

class RedBox extends StatelessWidget {
  final cronogramaDetalleVista vcronogramadetalle;
  const RedBox({
    Key? key,
    required this.size,
    required this.vcronogramadetalle,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        //padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        width: size.width / 1.05,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xffff6861),
            boxShadow: const [
              BoxShadow(
                offset: Offset(0, 0),
                blurRadius: 0,
                color: Color(0x3f000000),
              )
            ]),
        child: Row(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  vcronogramadetalle.avisos,
                  style: const TextStyle(
                    color: ColorBackground,
                    fontSize: 13,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ShareLeft extends StatelessWidget {
  const ShareLeft({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      height: 35,
      child: Stack(
        children: [
          Positioned(
              left: size.width - 50,
              child: IconButton(
                  icon: SvgPicture.asset("assets/icons/share_24px.svg"),
                  onPressed: () {}))
        ],
      ),
    );
  }
}

class ContainerMinutesAndQuantity extends StatelessWidget {
  final cronogramaDetalleVista vcronogramadetalle;
  const ContainerMinutesAndQuantity({
    Key? key,
    required this.size,
    required this.vcronogramadetalle,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(
            kDefaultPadding / 2, kDefaultPadding / 2, kDefaultPadding / 2, 0),
        width: size.width,
        height: 20,
        child: Stack(
          children: <Widget>[
            Positioned(
                top: 5,
                child: Text(
                  "${vcronogramadetalle.duracionmin} minutos",
                  style: const TextStyle(
                    color: Color(0xff424242),
                    fontSize: 12,
                  ),
                )),
            Positioned(
                left: size.width - 70,
                child: const SizedBox(
                  height: 15,
                  width: 15,
                  child: Icon(Icons.people_outline),
                )),
            Positioned(
                left: size.width - 40,
                top: 5,
                child: Text(
                  vcronogramadetalle.participantes.toString(),
                  style: const TextStyle(
                    color: Color(0xff424242),
                    fontSize: 12,
                  ),
                )),
          ],
        ));
  }
}

class RowWithTextAndIcon extends StatelessWidget {
  const RowWithTextAndIcon({
    Key? key,
    required this.rutaIcono,
    required this.texto,
  }) : super(key: key);

  final String rutaIcono;
  final String texto;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kDefaultPadding / 12),
      child: Row(
        children: <Widget>[
          SizedBox(
            height: 30,
            width: 30,
            child:
                IconButton(icon: SvgPicture.asset(rutaIcono), onPressed: () {}),
          ),
          Expanded(
            child: Text(
              texto,
              style: const TextStyle(fontSize: 13, color: ColorNegro),
            ),
          ),
        ],
      ),
    );
  }
}
