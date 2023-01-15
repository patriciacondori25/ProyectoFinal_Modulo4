import 'package:appconferencia/constants.dart';
import 'package:appconferencia/domain/entity_manager/cronograma.dart';
import 'package:appconferencia/domain/entity_manager/cronogramaDetalleEdit.dart';
import 'package:appconferencia/domain/entity_manager/cronogramaDetalleEdit_Actividad.dart';
import 'package:appconferencia/domain/entity_manager/ponentesHabilitados.dart';
import 'package:appconferencia/infraestructure/componentes/blueButton.dart';
import 'package:appconferencia/infraestructure/componentes/blueButtonRedondo.dart';
import 'package:appconferencia/infraestructure/componentes/modales.dart';
import 'package:appconferencia/infraestructure/componentes/preferenciasUsuario.dart';
import 'package:appconferencia/infraestructure/controller/createData.dart';
import 'package:appconferencia/infraestructure/controller/deleteData.dart';
import 'package:appconferencia/infraestructure/controller/readData.dart';
import 'package:appconferencia/infraestructure/controller/updateData.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';

class CronogramaIngreso extends StatelessWidget {
  final String cronograma;
  final String evento;
  final String fecha;
  final String cronogramadetalle;

  const CronogramaIngreso(
      {Key? key,
      required this.cronograma,
      required this.fecha,
      required this.evento,
      required this.cronogramadetalle})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(),
        body: Bodyci(
          cronograma: cronograma,
          fecha: fecha,
          evento: evento,
          cronogramadetalle: cronogramadetalle,
        ));
  }
}

AppBar buildAppBar() {
  return AppBar(
    centerTitle: true,
    elevation: 0,
    //leading: IconButton(
    //icon: SvgPicture.asset("assets/icons/menu.svg"),
    //onPressed: () {},
    //),
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: const <Widget>[
        Text(
          "Ingresar Actividad",
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

class Bodyci extends StatefulWidget {
  final String cronograma;
  final String evento;
  final String fecha;
  final String cronogramadetalle;

  const Bodyci(
      {Key? key,
      required this.cronograma,
      required this.fecha,
      required this.evento,
      required this.cronogramadetalle})
      : super(key: key);

  @override
  _BodyciState createState() => _BodyciState();
}

class _BodyciState extends State<Bodyci> {
  final _formKey = GlobalKey<FormState>();
  int i = 0;

  Future<cronogramaDetalleEdit> datosLista() async {
    readData read = readData();
    var conectate = read.readCronogramaDetalleEdit(
        widget.cronograma, widget.evento, widget.cronogramadetalle);
    return conectate;
  }

  //
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //Future<List<PCargaDatosCronogramaDetalle>> abc = datosdetalle();
    cronogramaDetalleEdit datosCabecera;

    return Stack(
      children: [
        FutureBuilder<cronogramaDetalleEdit>(
          future: datosLista(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              datosCabecera = (snapshot.data!);
              return FormularioUno(
                formKey: _formKey,
                size: size,
                widget: widget,
                datosCabecera: datosCabecera,
                // detalle: detalle,
                // i: i
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            //return  a circular progress indicator.
            return const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.transparent));
          },
        ),
      ],
    );
  }
}

class FormularioUno extends StatefulWidget {
  const FormularioUno({
    Key? key,
    required GlobalKey<FormState> formKey,
    required this.size,
    required this.widget,
    required this.datosCabecera,
    //  required this.detalle,
    //  required this.i,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final Size size;
  final Bodyci widget;
  final cronogramaDetalleEdit datosCabecera;

  @override
  _FormularioUnoState createState() => _FormularioUnoState();
}

class _FormularioUnoState extends State<FormularioUno> {
  String selectPonente = "";
  List<ponentesHabilitados> data = [];
  List<String> detallesaBorrar = [];
  String pcronodetalle = "";
  String pcrono = "";
  int estado = 1;
  String evento = "";
  PreferenciasUsuario pref = PreferenciasUsuario();
  void cargaPreferencias() async {
    evento = await pref.getevento();
    setState(() {});
  }

  desabilita() {
    setState(() {
      estado = 1;
    });
  }

  habilita() {
    setState(() {
      estado = 0;
    });
  }

  int estado2 = 1;
  desabilita2() {
    setState(() {
      estado2 = 1;
    });
  }

  habilita2() {
    setState(() {
      estado2 = 0;
    });
  }

//Para el tiempo de inicio
  TimeOfDay selectedTime = const TimeOfDay(hour: 00, minute: 00);
  String _hour = "", _minute = "", _time = "", _24hour = "";
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        cancelText: "Cancelar",
        confirmText: "Ok",
        initialEntryMode: TimePickerEntryMode.input,
        hourLabelText: "Hora",
        minuteLabelText: "Minutos",
        helpText: "Seleccione la hora");
    if (picked != null) {
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString().padLeft(2, "0");
        _minute = selectedTime.minute.toString().padLeft(2, "0");
        _24hour = '$_hour:$_minute';
        hora24.text = '$_hour:$_minute';
        //_time = '$_hour:$_minute';
        _time = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
        horaInicio.text = _time;
        horaInicio.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, ":", am]).toString();
      });
    }
  }

  //Para el tiempo final
  TimeOfDay selectedTime2 = const TimeOfDay(hour: 00, minute: 00);
  String _hour2 = "", _minute2 = "", _time2 = "";
  Future<void> _selectTime2(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: selectedTime2,
        cancelText: "Cancelar",
        confirmText: "Ok",
        initialEntryMode: TimePickerEntryMode.input,
        hourLabelText: "Hora",
        minuteLabelText: "Minutos",
        helpText: "Seleccione la hora");
    if (picked != null) {
      setState(() {
        selectedTime2 = picked;
        _hour2 = selectedTime2.hour.toString().padLeft(2, "0");
        _minute2 = selectedTime2.minute.toString().padLeft(2, "0");
        _time2 = '$_hour2:$_minute2';
        horaFin.text = _time2;
        horaFin.text = formatDate(
            DateTime(2019, 08, 1, selectedTime2.hour, selectedTime2.minute),
            [hh, ':', nn, " ", am]).toString();
      });
    }
  }

  //Para el tiempo del detalle
  TimeOfDay selectedTime3 = const TimeOfDay(hour: 00, minute: 00);
  String _hour3 = "", _minute3 = "", _time3 = "";
  Future<void> _selectTime3(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: selectedTime3,
        cancelText: "Cancelar",
        confirmText: "Ok",
        initialEntryMode: TimePickerEntryMode.input,
        hourLabelText: "Hora",
        minuteLabelText: "Minutos",
        helpText: "Seleccione la hora");
    if (picked != null) {
      setState(() {
        selectedTime3 = picked;
        _hour3 = selectedTime3.hour.toString().padLeft(2, "0");
        _minute3 = selectedTime3.minute.toString().padLeft(2, "0");
        _time3 = '$_hour3:$_minute3';
        iniciodetalle.text = _time3;
        iniciodetalle.text = formatDate(
            DateTime(2019, 08, 1, selectedTime3.hour, selectedTime3.minute),
            [hh, ':', nn, " ", am]).toString();
      });
    }
  }

  Future getPonentes() async {
    readData read = readData();
    var conectate = await read.readPonentesHabilitados(widget.widget.evento);

    setState(() {
      data = conectate;
      selectPonente = widget.datosCabecera.usuario.toString();
    });

    return "ok";
  }

  List<cronogramaDetalleEdit_Actividad> ListaDetalleCronograma = [];
  void datosdetalle() async {
    readData read = readData();
    var conectate = await read.readCronogramaDetalleActividad(
        widget.widget.evento,
        widget.widget.cronograma == "" ? pcrono : widget.widget.cronograma,
        widget.widget.fecha);

    ListaDetalleCronograma = conectate;
  }

  Future<List<ponentesHabilitados>> datosPonente() async {
    readData read = readData();

    var conectate = read.readPonentesHabilitados(widget.widget.evento);

    return conectate;
  }

  Future<Cronograma> validaCabecera(
      String evento, cronogramaDetalleEdit datos, String fecha) async {
    createData create = createData();

    return create.createCronograma(evento, datos, fecha);
  }

  Future<String> agregaDetalle(
      String cronogramaid,
      String textoCronograma,
      String horainicio,
      String horaReal,
      String usuarioid,
      String evento) async {
    createData create = createData();

    return create.createCronogramaDetalle(
        cronogramaid, textoCronograma, horainicio, horaReal, usuarioid, evento);
  }

  Future<int> borrarDetalle(
      String cronogramadetalle, String cronograma, String evento) async {
    deleteData delete = deleteData();
    delete.deleteCronogramaDetalle(cronograma, cronogramadetalle, evento);

    return 0;
  }

  Future<int> borrarActividad(String cronograma, String evento) async {
    deleteData delete = deleteData();
    delete.deleteCronograma(cronograma, evento);

    return 0;
  }

  @override
  void initState() {
    super.initState();
    cargaPreferencias();
    getPonentes();
    datosdetalle();
    pcronodetalle = widget.datosCabecera.cronogramadetalle;

    pcrono = widget.datosCabecera.cronograma;

    nombreActividad =
        TextEditingController(text: widget.datosCabecera.textocronograma);
    duracionMinutos = TextEditingController(
        text: widget.datosCabecera.duracionmin.toString());
    lugar = TextEditingController(text: widget.datosCabecera.area);
    horaInicio = TextEditingController(
        text: formatDate(
            DateTime(
                2019,
                08,
                1,
                int.parse(widget.datosCabecera.horaInicio.split(":")[0]),
                int.parse(widget.datosCabecera.horaInicio.split(":")[1])),
            [hh, ':', nn, " ", am]).toString());
    horaFin = TextEditingController(
        text: formatDate(
            DateTime(
                2019,
                08,
                1,
                int.parse(widget.datosCabecera.horafinal.split(":")[0]),
                int.parse(widget.datosCabecera.horafinal.split(":")[1])),
            [hh, ':', nn, " ", am]).toString());
    mensajeAlerta = TextEditingController(text: widget.datosCabecera.avisos);
    resumenEvento =
        TextEditingController(text: widget.datosCabecera.descripcioncronograma);
    detallesEspecificos =
        TextEditingController(text: widget.datosCabecera.detallesespecificos);
    linkEvento = TextEditingController(text: widget.datosCabecera.linkvideo);

    iniciodetalle = TextEditingController(text: "");
    textodetalle = TextEditingController(text: "");
    hora24 = TextEditingController(
        text:
            "${widget.datosCabecera.horaInicio.split(":")[0]}:${widget.datosCabecera.horaInicio.split(":")[1]}");

    setState(() {});
  }

  TextEditingController nombreActividad = TextEditingController();
  TextEditingController duracionMinutos = TextEditingController();
  TextEditingController lugar = TextEditingController();
  TextEditingController horaInicio = TextEditingController();
  TextEditingController horaFin = TextEditingController();
  TextEditingController mensajeAlerta = TextEditingController();
  TextEditingController resumenEvento = TextEditingController();
  TextEditingController detallesEspecificos = TextEditingController();
  TextEditingController linkEvento = TextEditingController();
  TextEditingController iniciodetalle = TextEditingController();
  TextEditingController textodetalle = TextEditingController();
  TextEditingController hora24 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
            key: widget._formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  //margin: EdgeInsets.fromLTRB(kDefaultPadding / 2,
                  //  kDefaultPadding, kDefaultPadding / 2, 0),
                  width: widget.size.width,
                  child: Text(
                    'Fecha de evento: ${widget.widget.fecha}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  //width: widget.size.width * 0.8,
                  decoration: BoxDecoration(
                      color: ColorBackground,
                      border: Border.all(color: Colors.white, width: 0.2),
                      borderRadius: BorderRadius.circular(10)),
                  //height: 38,
                  child: TextFormField(
                    enabled: estado == 1 ? false : true,
                    maxLines: null,
                    style: const TextStyle(fontSize: 14),
                    controller: nombreActividad,
                    decoration: InputDecoration(
                        errorStyle: const TextStyle(height: 0, fontSize: 9),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          // borderSide: BorderSide(
                          // color: Colors.grey,
                          //),
                        ),
                        contentPadding: const EdgeInsets.only(
                            left: 15, bottom: 5, top: 11, right: 15),
                        hintText:
                            "Nombre de la actividad. Ejem: Educación para..."),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Debe ingresar el nombre del evento';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  // width: widget.size.width * 0.8,
                  decoration: BoxDecoration(
                      color: ColorBackground,
                      border: Border.all(color: Colors.white, width: 0.2),
                      borderRadius: BorderRadius.circular(10)),
                  //height: 38,
                  child: TextFormField(
                    enabled: estado == 1 ? false : true,
                    maxLines: null,
                    style: const TextStyle(fontSize: 14),
                    controller: duracionMinutos,
                    decoration: InputDecoration(
                        errorStyle: const TextStyle(height: 0, fontSize: 9),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: const EdgeInsets.only(
                            left: 15, bottom: 5, top: 11, right: 15),
                        hintText:
                            "Ingrese hora total de actividad. Ejem: 60:00 min"),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Debe ingresar la duración del evento';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      const Icon(Icons.people),
                      const Spacer(),
                      Container(
                          width: widget.size.width * 0.82,
                          height: 48,
                          decoration: BoxDecoration(
                              color: ColorBackground,
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10)),
                          child: DropdownButton<String>(
                            dropdownColor: ColorBackground,
                            isExpanded: true,
                            value: selectPonente,
                            hint: const Text("Seleccione Ponente",
                                style: TextStyle(fontSize: 14)),
                            icon: const Icon(Icons.arrow_drop_down),
                            iconSize: 25,
                            underline: const SizedBox(),
                            elevation: 16,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 14),
                            onChanged: estado == 1
                                ? null
                                : (value) {
                                    setState(() {
                                      selectPonente = value!;
                                    });
                                  },
                            items: data.map<DropdownMenuItem<String>>((value) {
                              return DropdownMenuItem<String>(
                                value: value.usuario.toString(),
                                child: Text('   ${value.nombrecompleto}',
                                    style: const TextStyle(fontSize: 14)),
                              );
                            }).toList(),
                          ))
                    ],
                  ),
                ),

                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      const Icon(Icons.place),
                      const Spacer(),
                      Container(
                          width: widget.size.width * 0.82,
                          //height: 100,
                          decoration: BoxDecoration(
                              color: ColorBackground,
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(10)),
                          // height: 50,
                          child: TextFormField(
                            enabled: estado == 1 ? false : true,
                            maxLines: null,
                            style: const TextStyle(fontSize: 14),
                            controller: lugar,
                            decoration: InputDecoration(
                                errorStyle:
                                    const TextStyle(height: 0, fontSize: 9),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                contentPadding: const EdgeInsets.only(
                                    left: 15, bottom: 5, top: 11, right: 15),
                                hintText:
                                    "Área, ambiente, lugar de la actividad"),
                            // The validator receives the text that the user has entered.
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Debe ingresar el lugar';
                              }
                              return null;
                            },
                          )),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      const Icon(Icons.timer),
                      const Spacer(),
                      InkWell(
                        onTap: estado == 1
                            ? null
                            : () {
                                _selectTime(context);
                              },
                        child: Container(
                            width: widget.size.width * 0.395,
                            //height: 38,
                            decoration: BoxDecoration(
                                color: ColorBackground,
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(10)),
                            // height: 50,
                            child: TextFormField(
                              enabled: false,
                              maxLines: null,
                              style: const TextStyle(fontSize: 14),
                              controller: horaInicio,
                              decoration: InputDecoration(
                                  errorStyle:
                                      const TextStyle(height: 0, fontSize: 9),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  contentPadding: const EdgeInsets.only(
                                      left: 15, bottom: 5, top: 11, right: 15),
                                  hintText: "Hora ejm 00:00"),
                              // The validator receives the text that the user has entered.
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Debe ingresar hora inicio';
                                }
                                return null;
                              },
                            )),
                      ),
                      const Spacer(),
                      const Text('-'),
                      const Spacer(),
                      InkWell(
                        onTap: estado == 1
                            ? null
                            : () {
                                _selectTime2(context);
                              },
                        child: Container(
                            width: widget.size.width * 0.395,
                            // height: 38,
                            decoration: BoxDecoration(
                                color: ColorBackground,
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(10)),
                            // height: 50,
                            child: TextFormField(
                              enabled: false,
                              maxLines: null,
                              style: const TextStyle(fontSize: 14),
                              controller: horaFin,
                              decoration: InputDecoration(
                                  errorStyle:
                                      const TextStyle(height: 0, fontSize: 9),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  contentPadding: const EdgeInsets.only(
                                      left: 15, bottom: 5, top: 11, right: 15),
                                  hintText: "Hora ejem 00:00"),
                              // The validator receives the text that the user has entered.
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Debe ingresar hora fin';
                                }
                                return null;
                              },
                            )),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: const [
                      Text(
                        'Agregue detalles a la actividad',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: estado == 1
                            ? null
                            : () {
                                _selectTime3(context);
                              },
                        child: Container(
                          //
                          width: widget.size.width * 0.25,
                          //height: 38,
                          decoration: BoxDecoration(
                              color: ColorBackground,
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(10)),
                          // height: 50,
                          child: TextFormField(
                            //initialValue: datos.hora,

                            enabled: false,
                            maxLines: null,
                            style: const TextStyle(fontSize: 14),
                            controller: iniciodetalle,
                            decoration: InputDecoration(
                                errorStyle:
                                    const TextStyle(height: 0, fontSize: 9),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                contentPadding: const EdgeInsets.only(
                                    left: 15, bottom: 5, top: 11, right: 15),
                                hintText: "H 00:00"),
                            // The validator receives the text that the user has entered.
                          ),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        width: widget.size.width * 0.5,
                        // height: 38,
                        decoration: BoxDecoration(
                            color: ColorBackground,
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(10)),
                        child: TextFormField(
                          enabled: estado == 1 ? false : true,
                          maxLines: null,
                          style: const TextStyle(fontSize: 14),
                          //   initialValue: datos.textocronograma,
                          controller: textodetalle,
                          decoration: InputDecoration(
                              errorStyle:
                                  const TextStyle(height: 0, fontSize: 9),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding: const EdgeInsets.only(
                                  left: 15, bottom: 5, top: 11, right: 15),
                              hintText: "Descripción"),
                          // The validator receives the text that the user has entered.
                        ),
                      ),
                      const Spacer(),
                      BottonBlueRedondo(
                        alto: 47,
                        ancho: 43,
                        colorboton:
                            estado == 1 ? Colors.grey.shade300 : ColorPrimario,
                        texto: " + ",
                        colorTexto: ColorBackground,
                        press: () => () async {
                          if (textodetalle.text.isEmpty ||
                              iniciodetalle.text.isEmpty) {
                            Modales mensajes = Modales(context);
                            mensajes.modalTextoBoton(
                                'Debe ingresar todos los datos',
                                Colors.red,
                                'Cerrar');
                          } else {
                            cronogramaDetalleEdit_Actividad detalle =
                                cronogramaDetalleEdit_Actividad(
                                    evento,
                                    pcrono,
                                    "0",
                                    iniciodetalle.text,
                                    _time3,
                                    textodetalle.text);

                            ListaDetalleCronograma.add(detalle);

                            setState(() {});

                            textodetalle.text = '';
                            iniciodetalle.text = '';
                          }
                        },
                        icono: Icons.add,
                        habilitado: estado,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 20,
                ),

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Row(
                        children: const [
                          Text('Hora',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                          Spacer(),
                          Text('Descripción',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                          Spacer(),
                          Text('Borrar',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold))
                        ],
                      ),
                      const Divider(
                        thickness: 2.0,
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                        child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            reverse: false,
                            shrinkWrap: true,
                            // padding: const EdgeInsets.symmetric(vertical: 0),
                            itemCount: ListaDetalleCronograma.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                            width: 60,
                                            child: Text(
                                                ListaDetalleCronograma[index]
                                                    .hora)),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        SizedBox(
                                          width: size.width * 0.55,
                                          child: Text(
                                              ListaDetalleCronograma[index]
                                                  .textocronograma),
                                        ),
                                        const Spacer(),
                                        SizedBox(
                                          // width: 50,
                                          height: 10,
                                          child: IconButton(
                                              padding: const EdgeInsets.all(0),
                                              iconSize: 20,
                                              //iconSize: ,
                                              icon: const Icon(
                                                  Icons.delete_outlined),
                                              onPressed: estado == 1
                                                  ? null
                                                  : () {
                                                      detallesaBorrar.add(
                                                          ListaDetalleCronograma[
                                                                  index]
                                                              .cronogramadetalle);
                                                      ListaDetalleCronograma
                                                          .removeAt(index);

                                                      setState(() {});
                                                    }),
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                      thickness: 2,
                                    ),
                                  ],
                                ),
                              );
                            })),
                  ],
                ),

                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      const Icon(Icons.add_alert),
                      const Spacer(),
                      Container(
                          width: widget.size.width * 0.68,
                          //height: 38,
                          decoration: BoxDecoration(
                              color: ColorBackground,
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(10)),
                          // height: 50,
                          child: TextFormField(
                            enabled: estado2 == 1 ? false : true,
                            maxLines: null,
                            style: const TextStyle(fontSize: 14),
                            controller: mensajeAlerta,
                            decoration: InputDecoration(
                                errorStyle:
                                    const TextStyle(height: 0, fontSize: 9),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                contentPadding: const EdgeInsets.only(
                                    left: 15, bottom: 5, top: 11, right: 15),
                                hintText: "Mensajes de alerta"),
                            // The validator receives the text that the user has entered.
                          )),
                      const Spacer(),
                      BottonBlue(
                        alto: 50,
                        ancho: 50,
                        colorboton: ColorPrimario,
                        colorTexto: ColorBackground,
                        habilitado: estado,
                        press: () => () {
                          if (estado2 == 1) {
                            habilita2();
                          } else {
                            desabilita2();
                          }
                        },
                        texto: '✔',
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),

                      // width: widget.size.width * 0.8,
                      child: const Text(
                        'Resumen:',
                        style: TextStyle(
                          color: ColorNegro,
                          fontSize: 16,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            enabled: estado == 1 ? false : true,
                            style: const TextStyle(fontSize: 14),
                            controller: resumenEvento,
                            maxLines: null,
                            decoration: InputDecoration(
                                errorStyle:
                                    const TextStyle(height: 0, fontSize: 9),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                contentPadding: const EdgeInsets.only(
                                    left: 15, bottom: 11, top: 11, right: 15),
                                hintText: "Ingrese el resumen del evento"),
                            // The validator receives the text that the user has entered.
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Debe ingresar el resumen';
                              }
                              return null;
                            },
                          )),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                //  Row(
                //     children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      width: widget.size.width * 0.8,
                      child: const Text(
                        'Detalles específicos:',
                        style: TextStyle(
                          color: ColorNegro,
                          fontSize: 16,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                //   ],
                //  ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            enabled: estado == 1 ? false : true,
                            style: const TextStyle(fontSize: 14),
                            controller: detallesEspecificos,
                            maxLines: null,
                            decoration: InputDecoration(
                                errorStyle:
                                    const TextStyle(height: 0, fontSize: 9),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                contentPadding: const EdgeInsets.only(
                                    left: 15, bottom: 11, top: 11, right: 15),
                                hintText: "Ingrese el resumen del evento"),
                            // The validator receives the text that the user has entered.
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Debe ingresar el detalles';
                              }
                              return null;
                            },
                          )),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      width: widget.size.width * 0.8,
                      child: const Text(
                        'Enlace de video conferencia:',
                        style: TextStyle(
                          color: ColorNegro,
                          fontSize: 16,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                              color: ColorBackground,
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(10)),
                          //height: 48,
                          child: TextFormField(
                            enabled: estado == 1 ? false : true,
                            style: const TextStyle(fontSize: 14),
                            controller: linkEvento,
                            maxLines: null,
                            decoration: InputDecoration(
                                errorStyle:
                                    const TextStyle(height: 0, fontSize: 9),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                contentPadding: const EdgeInsets.only(
                                    left: 15, bottom: 7, top: 11, right: 15),
                                hintText:
                                    "Ingrese enlace de video conferencia"),
                            // The validator receives the text that the user has entered.
                          )),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(children: [
                    BottonBlue(
                      alto: 35,
                      ancho: 100,
                      colorboton: Colors.red,
                      texto: "Eliminar",
                      colorTexto: ColorBackground,
                      press: () => () async {
                        borrarActividad(
                            widget.widget.cronograma, widget.widget.evento);

                        Navigator.pop(context);
                      },
                      habilitado: estado,
                    ),
                    const SizedBox(width: 5),
                    BottonBlue(
                      alto: 35,
                      ancho: 100,
                      colorboton: ColorPrimario,
                      texto: "Editar",
                      colorTexto: ColorBackground,
                      press: () => () {
                        if (estado == 1) {
                          habilita();
                        } else {
                          desabilita();
                        }
                        datosdetalle();
                        setState(() {});
                      },
                      habilitado: 0,
                    ),
                    const Spacer(),
                    BottonBlue(
                        alto: 35,
                        ancho: 100,
                        colorboton: ColorPrimario,
                        texto: "Grabar",
                        colorTexto: ColorBackground,
                        press: () => () async {
                              //Navigator.,of(context).pop();
//Empezamos validando la primera pregunta
                              if (widget._formKey.currentState!.validate()) {
                                // Para la cabecera
                                cronogramaDetalleEdit datoscronograma =
                                    cronogramaDetalleEdit(
                                        evento: widget.widget.evento,
                                        cronograma:
                                            widget.datosCabecera.cronograma,
                                        cronogramadetalle: widget
                                            .datosCabecera.cronogramadetalle,
                                        textocronograma: nombreActividad.text,
                                        duracionmin:
                                            int.parse(duracionMinutos.text),
                                        usuario: selectPonente,
                                        ponente: "",
                                        area: lugar.text,
                                        horaInicio: horaInicio.text,
                                        horabase: hora24.text,
                                        horafinal: horaFin.text,
                                        avisos: mensajeAlerta.text,
                                        descripcioncronograma:
                                            resumenEvento.text,
                                        detallesespecificos:
                                            detallesEspecificos.text,
                                        linkvideo: linkEvento.text);

                                if (widget.datosCabecera.cronograma == "") {
                                  //Agrega
                                  Cronograma a = await validaCabecera(
                                      widget.widget.evento,
                                      datoscronograma,
                                      widget.widget.fecha);

                                  pcrono = a.cronograma;
                                } else {
                                  //Edita
                                  pcrono = datoscronograma.cronograma;

                                  updateData update = updateData();
                                  update.updateCronograma(
                                      datoscronograma, widget.widget.fecha);
                                }

                                /*    pcronodetalle 
                                    int.parse(a[0]["cronogramaDetalle"]);*/
                                datosdetalle();

//Para el detalledatosdetalle();
//Borra elementos eliminados
                                for (String x in detallesaBorrar) {
                                  if (x.isNotEmpty) {
                                    borrarDetalle(
                                        x[0], pcrono, widget.widget.evento);
                                  }
                                }

                                for (var dato in ListaDetalleCronograma) {
                                  if (dato.cronogramadetalle.toString() ==
                                      "0".toString()) {
                                    agregaDetalle(
                                        dato.cronograma.toString() ==
                                                "".toString()
                                            ? pcrono
                                            : dato.cronograma,
                                        dato.textocronograma,
                                        "${dato.hora.substring(0, 5)} ${dato.hora.substring(6, 8)}",
                                        dato.horaReal,
                                        selectPonente,
                                        widget.widget.evento);
                                  }
                                }

                                datosdetalle();

                                // setState(() {});

                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Procesando')));

                                Modales mensajes = Modales(context);
                                mensajes.modalTextoBoton(
                                    'Grabado Correctamente',
                                    Colors.red,
                                    'Cerrar');

                                desabilita();
                                desabilita2();

                                /* if (mensajeAlerta.text.isNotEmpty) {
                                  var mensaje = ClaseNotificaciones(
                                      cuerpo: mensajeAlerta.text,
                                      titulo: 'Cambio de cronograma');
                                  var notificacion = EnviaNotificaciones(
                                      mensaje, widget.widget.evento);
                                  notificacion.enviamensajes();
                                }*/

                                setState(() {});
                              } else {
                                Modales mensajes = Modales(context);
                                mensajes.modalTextoBoton(
                                    'Debe ingresar todos los datos',
                                    Colors.red,
                                    'Cerrar');
                              }
                            },
                        habilitado: estado),
                  ]),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            )),
      ),
    );
  }
}
