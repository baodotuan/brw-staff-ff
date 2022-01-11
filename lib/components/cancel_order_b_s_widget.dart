import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class CancelOrderBSWidget extends StatefulWidget {
  const CancelOrderBSWidget({
    Key key,
    this.userRef,
    this.orderRef,
  }) : super(key: key);

  final DocumentReference userRef;
  final DocumentReference orderRef;

  @override
  _CancelOrderBSWidgetState createState() => _CancelOrderBSWidgetState();
}

class _CancelOrderBSWidgetState extends State<CancelOrderBSWidget> {
  TextEditingController textController;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Reason',
                  style: FlutterFlowTheme.title2,
                ),
              ],
            ),
          ),
          Expanded(
            child: Align(
              alignment: AlignmentDirectional(0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                      child: TextFormField(
                        onChanged: (_) => EasyDebounce.debounce(
                          'textController',
                          Duration(milliseconds: 500),
                          () => setState(() {}),
                        ),
                        controller: textController,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: ' Type reason here...',
                          hintStyle: FlutterFlowTheme.bodyText1,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                          ),
                        ),
                        style: FlutterFlowTheme.bodyText1,
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Field is required';
                          }

                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              if ((textController.text) != '')
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      final usersUpdateData = {
                        'processing_order':
                            FieldValue.arrayRemove([widget.orderRef]),
                      };
                      await widget.userRef.update(usersUpdateData);
                      await widget.orderRef.delete();
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              NavBarPage(initialPage: 'orderPage'),
                        ),
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xFFCD290F),
                      ),
                      alignment: AlignmentDirectional(0, 0),
                      child: Text(
                        'Cancel Order Now',
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
