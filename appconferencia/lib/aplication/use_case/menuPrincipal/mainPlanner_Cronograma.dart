import 'package:appconferencia/aplication/use_case/mantenimientoCronograma/cronogramaDetalle_screen.dart';
import 'package:appconferencia/aplication/use_case/mantenimientoCronograma/cronogramaIngreso.dart';
import 'package:appconferencia/domain/entity_manager/listadoDias.dart';
import 'package:appconferencia/infraestructure/componentes/preferenciasUsuario.dart';
import 'package:appconferencia/infraestructure/controller/procesos.dart';
import 'package:appconferencia/infraestructure/controller/readData.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:appconferencia/constants.dart';

class Bodyc extends StatefulWidget {
  final List<String> fechas;
  final String evento;

  const Bodyc({
    Key? key,
    required this.fechas,
    required this.evento,
  }) : super(key: key);
  @override
  _BodycState createState() => _BodycState(fechas);
}

class _BodycState extends State<Bodyc> {
  PreferenciasUsuario pref = PreferenciasUsuario();
  String idevento = "";
  String tipousuario = "";

  void cargaPreferencias() async {
    idevento = await pref.getevento();
    tipousuario = await pref.getTipoUsuario();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    cargaPreferencias();
  }

  List<bool> isSelected = [
    true,
    false,
    false,
    false,
  ];
  final List<String> fechas;

  _BodycState(this.fechas);

  Future<List<dynamic>> datosLista(String evento) async {
    int indiceActual = 0;
    for (int i = 0; i < isSelected.length; i++) {
      if (isSelected[i] == true) {
        indiceActual = i;
      }
    }
    readData validarUsuario = readData();
    var cronoevent =
        await validarUsuario.cronogramaEvento(evento, fechas[indiceActual]);
    //

    return cronoevent;
  }

  String devuelveFecha() {
    int indiceActual = 0;
    for (int i = 0; i < isSelected.length; i++) {
      if (isSelected[i] == true) {
        indiceActual = i;
      }
    }
    return fechas[indiceActual];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: <Widget>[
        grupoDeBotones(size, fechas[0], fechas[0]),
        buildFutureBuilder(size, widget.evento),
        Row(
          children: [
            const Spacer(),
            tipousuario == 'Organizador' || tipousuario == 'Administrador'
                ? SizedBox(
                    height: 60,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: kDefaultPadding / 3,
                      ),
                      child: FloatingActionButton(
                        // mini: true,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CronogramaIngreso(
                                cronograma: "",
                                fecha: devuelveFecha(),
                                evento: idevento,
                                cronogramadetalle: "",
                              ),
                            ),
                          ).then((value) => setState(() {}));
                        },
                        foregroundColor: ColorNegro,
                        backgroundColor: Colors.grey.shade300,
                        child: const Icon(Icons.add),
                        // splashColor: kBackgroudColor,
                      ),
                    ),
                  )
                : Container(
                    height: 0,
                  ),
            const SizedBox(
              width: 10,
            )
          ],
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }

  FutureBuilder<List> buildFutureBuilder(Size size, String idevento) {
    return FutureBuilder<List<dynamic>>(
      future: datosLista(idevento),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List pcronogramaeventos = (snapshot.data!);
          return Expanded(
              child: GroupedListView<dynamic, String>(
                  sort: false,
                  elements: pcronogramaeventos,
                  groupBy: ((element) => element.horaBase),
                  groupComparator: (value1, value2) => value2.compareTo(value1),
                  itemComparator: (item1, item2) =>
                      item1.horaReal.compareTo(item2.horaReal),
                  order: GroupedListOrder.ASC,
                  useStickyGroupSeparators: true,
                  groupSeparatorBuilder: (String value) =>
                      LineaPloma(size: size, texto: value),
                  itemBuilder: (c, element) {
                    return LineaCronograma(
                      cronogramaDetalle: element.principal == 1
                          ? element.cronograma
                          : element.cronogramaDetalle,
                      context: context,
                      size: size,
                      horainicio: element.hora,
                      textocronograma: element.textoCronograma,
                      areaprincipal: element.area.length == 0
                          ? ""
                          // ignore: prefer_interpolation_to_compose_strings
                          : "Area:" + element.area,
                      principal: element.principal,
                      tipousuario: tipousuario,
                      fecha: devuelveFecha(),
                      idevento: idevento,
                      pressedit: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CronogramaIngreso(
                              cronograma: element.cronograma,
                              fecha: devuelveFecha(),
                              evento: idevento,
                              cronogramadetalle: element.cronogramaDetalle,
                            ),
                            settings:
                                const RouteSettings(name: '/CronogramaIngreso'),
                          ),
                        ).then((value) => setState(() {}))
                      },
                      cronograma: element.cronograma,
                    );
                  }));
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        //return  a circular progress indicator.
        return const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.transparent));
      },
    );
  }

  Container grupoDeBotones(Size size, String fechainicio, String fechafin) {
    Procesos procesos = Procesos();
    List<ListadoDias> plistadodias =
        procesos.generaDias(DateTime.parse(fechainicio));
    return Container(
        margin: const EdgeInsets.fromLTRB(5.0, 10.0, 0, 10.0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(0),
            topRight: Radius.circular(0),
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(0),
          ),
          color: ColorBackground,
        ),
        child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ToggleButtons(
              isSelected: isSelected,
              fillColor: ColorPrimario,
              selectedColor: ColorBackground,
              renderBorder: false,
              children: <Widget>[
                BottonCronograma(
                  texto:
                      "${plistadodias[0].nombreDia.toString().substring(0, 3)}\n${plistadodias[0].dia}",
                ),
                BottonCronograma(
                  texto:
                      "${plistadodias[1].nombreDia.toString().substring(0, 3)}\n${plistadodias[1].dia}",
                ),
                BottonCronograma(
                  texto:
                      "${plistadodias[2].nombreDia.toString().substring(0, 3)}\n${plistadodias[2].dia}",
                ),
                BottonCronograma(
                  texto:
                      "${plistadodias[3].nombreDia.toString().substring(0, 3)}\n${plistadodias[3].dia}",
                ),
              ],
              onPressed: (int newindex) {
                setState(() {
                  for (int index = 0; index < isSelected.length; index++) {
                    if (index == newindex) {
                      isSelected[index] = true;
                    } else {
                      isSelected[index] = false;
                    }
                  }
                  datosLista(idevento); //aca hay que filtrar por fecha tbm
                });
              },
            )));
  }
}

class LineaCronograma extends StatelessWidget {
  final String horainicio;
  final String textocronograma;
  final String areaprincipal;
  final int principal;
  final BuildContext context;
  final String cronogramaDetalle;
  final String tipousuario;
  final String fecha;
  final String idevento;
  final String cronograma;

  const LineaCronograma({
    Key? key,
    required this.size,
    required this.horainicio,
    required this.textocronograma,
    required this.areaprincipal,
    required this.principal,
    required this.context,
    required this.cronogramaDetalle,
    required this.tipousuario,
    required this.fecha,
    required this.idevento,
    required this.pressedit,
    required this.cronograma,
  }) : super(key: key);

  final Size size;
  final Function pressedit;

  void press() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CronogramaDetalle(
          cronograma: cronogramaDetalle,
          evento: idevento,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        //LineaPloma(size: size),
        SizedBox(
          width: size.width,
          height: principal == 1 ? 50 : 20, //90
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: size.width,
                height: principal == 1 ? 90 : 20,
                color: ColorBackground,
                child: Stack(
                  children: [
                    Positioned(
                      left: size.width / 29,
                      top: principal == 1 ? 17 : 0,
                      child: Text(
                        horainicio,
                        style: const TextStyle(
                          color: ColorNegro,
                          fontSize: 13,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    Positioned(
                      left: size.width / 4.7,
                      top: principal == 1 ? 8 : 0,
                      child: SizedBox(
                        width: 220,
                        child: Text(textocronograma,
                            style: TextStyle(
                              color: principal == 1
                                  ? ColorNegro
                                  : const Color(0xff969696),
                              fontSize: principal == 1 ? 15 : 13,
                              fontFamily: "Poppins",
                              fontWeight: principal == 1
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                            ),
                            maxLines: 1),
                      ),
                    ),
                    principal == 1
                        ? Positioned(
                            left: size.width / 4.7,
                            top: principal == 1 ? 29 : 0,
                            child: SizedBox(
                              width: 220,
                              child: Text(
                                areaprincipal,
                                style: const TextStyle(
                                  color: Color(0xff969696),
                                  fontSize: 13,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 1,
                              ),
                            ),
                          )
                        : Container(
                            height: 0,
                          ),
                    principal == 1 &&
                            (tipousuario == 'Organizador' ||
                                tipousuario == 'Administrador')
                        ? Positioned(
                            left: size.width / 1.3,
                            top: principal == 1 ? 2 : 0,
                            child: IconButton(
                              icon: const Icon(Icons.edit_note),
                              onPressed: () => pressedit(),
                            ),
                          )
                        : Container(
                            height: 0,
                          ),
                    principal == 1
                        ? Positioned(
                            left: size.width / 1.17,
                            top: principal == 1 ? 2 : 0,
                            child:
                                //Text("SSS")
                                IconButton(
                              icon: const Icon(Icons.keyboard_arrow_right),
                              onPressed: press,
                            ),
                          )
                        : Container(
                            height: 0,
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class LineaPloma extends StatelessWidget {
  final String texto;
  const LineaPloma({
    Key? key,
    required this.size,
    required this.texto,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      height: 38,
      child: Column(
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: size.width / 1.05,
                height: 28,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: const Color(0x7fdadada),
                ),
                padding: const EdgeInsets.only(
                  left: 9,
                  top: 3,
                  bottom: 1,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      texto,
                      style: const TextStyle(
                        color: ColorNegro,
                        fontSize: 16,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BottonCronograma extends StatelessWidget {
  const BottonCronograma({
    Key? key,
    required this.texto,
  }) : super(key: key);
  final String texto;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(3.0, 0.0, 3.0, 0.0),
        width: 76,
        height: 53,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(6),
            topRight: Radius.circular(6),
            bottomLeft: Radius.circular(6),
            bottomRight: Radius.circular(6),
          ),
          border: Border.all(
            color: ColorPrimario,
            width: 1.2,
          ),
        ),
        child: Center(
          child: Text(
            texto,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ));
  }
}
