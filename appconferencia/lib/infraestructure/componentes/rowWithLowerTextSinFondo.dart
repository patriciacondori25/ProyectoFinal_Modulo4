// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import '../../../../constants.dart';

class RowWithTextLower extends StatelessWidget {
  const RowWithTextLower({
    Key? key,
    required this.texto,
  }) : super(key: key);
  final String texto;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          kDefaultPadding / 3, kDefaultPadding / 5, kDefaultPadding / 3, 0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              texto,
              style: TextStyle(
                color: ColorNegro,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
