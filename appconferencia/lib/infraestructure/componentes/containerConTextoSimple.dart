// ignore_for_file: file_names
import 'package:flutter/material.dart';
import '../../../constants.dart';

class ContainerConTextoSimple extends StatelessWidget {
  const ContainerConTextoSimple({
    Key? key,
    required this.size,
    required this.tamanoLetra,
    required this.texto,
  }) : super(key: key);

  final Size size;
  final double tamanoLetra;
  final String texto;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(
          kDefaultPadding / 2, kDefaultPadding, kDefaultPadding / 2, 0),
      width: size.width,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              texto,
              style: TextStyle(
                color: ColorNegro,
                fontSize: tamanoLetra,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
    );
  }
}
