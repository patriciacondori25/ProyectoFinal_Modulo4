// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:appconferencia/infraestructure/controller/readData.dart';
import '../constants.dart';
import '../domain/entity_manager/evento.dart';
import 'descripcion_inicial_eventos.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: buildAppBar(), body: const eventList());
    // Body(),
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
          "Bienvenido tu APP MÓVIL",
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

class eventList extends StatefulWidget {
  const eventList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _eventList();
}

class _eventList extends State<eventList> {
  @override
  Widget build(BuildContext context) {
    readData leerListadoEvento = readData();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
            child: Container(
          padding: const EdgeInsets.fromLTRB(
              0, kDefaultPadding, 0, kDefaultPadding / 2),
          height: 10,
          child: const Text(
            "",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        )),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding / 5),
          child: StreamBuilder<List<Evento>>(
            stream: leerListadoEvento.readEventos(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Evento>? evento = snapshot.data;

                return CustomListView(
                  vlistadoeventos: evento,
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              return const CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Colors.transparent));
            },
          ),
        ))
      ],
    );
  }
}

class CustomListView extends StatelessWidget {
  final List<Evento>? vlistadoeventos;

  const CustomListView({Key? key, required this.vlistadoeventos})
      : super(key: key);

  @override
  Widget build(context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 1 / 1.7, //esto controla el tamano del
            crossAxisSpacing: 5, //20,
            mainAxisSpacing: 5,
            crossAxisCount: 2), //20),

        itemCount: vlistadoeventos?.length,
        itemBuilder: (BuildContext ctx, currentIndex) {
          return Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: ColorBackground,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey, width: 1),
            ),
            child: FlyerEventos(
              //size: context.size,
              rutaImagen: vlistadoeventos![currentIndex].fotoeventos,
              textoImagen: vlistadoeventos![currentIndex].nombreevento,
              rutaIconoFecha: "assets/icons/date.svg",
              textoIconoFecha:
                  '${vlistadoeventos![currentIndex].fechainicio.toString().substring(0, 10)}\n${vlistadoeventos![currentIndex].fechafin.toString().substring(0, 10)}',
              rutaIconoLugar: "assets/icons/place.svg",
              textoIconoLugar: vlistadoeventos![currentIndex].ubicacion,
              press: () => () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsScreen(
                      vlistadoeventos: vlistadoeventos![currentIndex],
                    ),
                  ),
                );
              },
            ),
          );
        });
  }
}

class FlyerEventos extends StatefulWidget {
  const FlyerEventos({
    Key? key,
    required //this.size,
        this.rutaImagen,
    required this.textoImagen,
    required this.rutaIconoFecha,
    required this.textoIconoFecha,
    required this.rutaIconoLugar,
    required this.textoIconoLugar,
    required this.press,
  }) : super(key: key);

  //final Size size;
  final String rutaImagen;
  final String textoImagen;
  final String rutaIconoFecha;
  final String textoIconoFecha;
  final String rutaIconoLugar;
  final String textoIconoLugar;
  final Function press;

  @override
  State<FlyerEventos> createState() => _FlyerEventosState();
}

class _FlyerEventosState extends State<FlyerEventos> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: kDefaultPadding / 3,
        right: kDefaultPadding / 3,
        top: kDefaultPadding / 3,
        bottom: kDefaultPadding / 3, //* 2.5,
      ),

      //height: 800, // * 0.4,

      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: widget.press(),
            //onTap: press(),
            child:
                SizedBox(height: 90, child: Image.network(widget.rutaImagen)),
          ),
          const Divider(
            color: Colors.grey,
            thickness: 1,
          ),
          GestureDetector(
            onTap: widget.press(),
            child: SizedBox(
              height: 100,
              child: RowWithUpperText(
                texto: widget.textoImagen,
              ),
            ),
          ),
          GestureDetector(
            onTap: widget.press(),
            child: RowWithTextAndIcon(
              rutaIcono: widget.rutaIconoFecha,
              texto: widget.textoIconoFecha,
            ),
          ),
          GestureDetector(
            onTap: widget.press(),
            child: RowWithTextAndIcon(
              rutaIcono: widget.rutaIconoLugar,
              texto: widget.textoIconoLugar,
            ),
          ),
        ],
      ),
    );
  }
}

class RowWithUpperText extends StatelessWidget {
  const RowWithUpperText({
    Key? key,
    required this.texto,
  }) : super(key: key);
  final String texto;
  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 40,
      padding: const EdgeInsets.all(kDefaultPadding / 5),
      decoration: BoxDecoration(
        border: Border.all(color: ColorBackground, width: 0),
        color: ColorBackground,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              texto.toUpperCase(),
              textAlign: TextAlign.center,
              //style: Theme.of(context).textTheme.button,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: ColorPrimario),
            ),
          ),
        ],
      ),
    );
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
      height: 35,
      padding: const EdgeInsets.fromLTRB(kDefaultPadding / 12,
          kDefaultPadding / 12, kDefaultPadding / 20, kDefaultPadding / 12),
      decoration: BoxDecoration(
        border: Border.all(color: ColorBackground, width: 0),
        color: ColorBackground,
      ),
      child: Row(
        children: <Widget>[
          SizedBox(
              height: 50,
              width: 50,
              child: IconButton(
                  icon: SvgPicture.asset(rutaIcono),
                  color: ColorBackground,
                  onPressed: () {})),
          Expanded(
            child: Text(
              texto,
              style: const TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
