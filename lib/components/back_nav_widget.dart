import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class BackNavWidget extends StatefulWidget {
  const BackNavWidget({Key key}) : super(key: key);

  @override
  _BackNavWidgetState createState() => _BackNavWidgetState();
}

class _BackNavWidgetState extends State<BackNavWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        InkWell(
          onTap: () async {
            Navigator.pop(context);
          },
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Color(0x00FFFFFF),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
              size: 24,
            ),
          ),
        ),
      ],
    );
  }
}
