import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class InputCompWidget extends StatefulWidget {
  const InputCompWidget({Key key}) : super(key: key);

  @override
  _InputCompWidgetState createState() => _InputCompWidgetState();
}

class _InputCompWidgetState extends State<InputCompWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Title',
                  style: FlutterFlowTheme.title2,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Container(
                    width: 100,
                    height: 60,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.tertiaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: AlignmentDirectional(0, 0),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  width: 100,
                  height: 50,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.primaryColor,
                  ),
                  alignment: AlignmentDirectional(0, 0),
                  child: Text(
                    'Verify',
                    style: FlutterFlowTheme.subtitle2.override(
                      fontFamily: 'Roboto',
                      color: FlutterFlowTheme.tertiaryColor,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () async {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 100,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0xFFAE2D2D),
                    ),
                    alignment: AlignmentDirectional(0, 0),
                    child: Text(
                      'Cancel',
                      style: FlutterFlowTheme.subtitle2.override(
                        fontFamily: 'Roboto',
                        color: FlutterFlowTheme.tertiaryColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
