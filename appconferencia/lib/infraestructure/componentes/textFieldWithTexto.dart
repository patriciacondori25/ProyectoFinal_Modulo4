// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../../../constants.dart';

class TextFieldwithTexto extends StatelessWidget {
  final TextEditingController myController;
  // ignore: prefer_typing_uninitialized_variables
  final largoporcentaje;
  const TextFieldwithTexto({
    Key? key,
    required this.texto,
    required this.myController,
    required this.largoporcentaje,
  }) : super(key: key);

  final String texto;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width * largoporcentaje, // 0.75, // * 0.6,
      // height: 38,
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: ColorBackground,
          border: Border.all(color: Colors.black26)),
      child: TextField(
        textAlign: TextAlign.center,
        controller: myController,
        maxLines: null, //wrap text
        autofocus: false,
        autocorrect: true,

        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          hintText: texto,
          hintStyle: TextStyle(
            //fontSize: 12,
            color: ColorPrimario.withOpacity(0.5),
          ),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
        onChanged: (value) {},
      ),
    );
  }
}
