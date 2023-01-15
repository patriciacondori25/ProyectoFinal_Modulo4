// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import '../../../../constants.dart';

class RowWithUpperText extends StatelessWidget {
  const RowWithUpperText({
    Key? key,
    required this.texto,
  }) : super(key: key);
  final String texto;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(kDefaultPadding / 2.5, kDefaultPadding,
          kDefaultPadding / 5, kDefaultPadding / 5),
      width: 300,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              texto.toUpperCase(),
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
    );
  }
}
