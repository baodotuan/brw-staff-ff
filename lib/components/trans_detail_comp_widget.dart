import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_expanded_image_view.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class TransDetailCompWidget extends StatefulWidget {
  const TransDetailCompWidget({
    Key key,
    this.transRef,
  }) : super(key: key);

  final DocumentReference transRef;

  @override
  _TransDetailCompWidgetState createState() => _TransDetailCompWidgetState();
}

class _TransDetailCompWidgetState extends State<TransDetailCompWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: FutureBuilder<TransactionsRecord>(
            future: TransactionsRecord.getDocumentOnce(widget.transRef),
            builder: (context, snapshot) {
              // Customize what your widget looks like when it's loading.
              if (!snapshot.hasData) {
                return Center(
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: SpinKitDoubleBounce(
                      color: FlutterFlowTheme.primaryColor,
                      size: 40,
                    ),
                  ),
                );
              }
              final containerTransactionsRecord = snapshot.data;
              return Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.tertiaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              await Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  child: FlutterFlowExpandedImageView(
                                    image: Image.network(
                                      containerTransactionsRecord.receiptUrl,
                                      fit: BoxFit.contain,
                                    ),
                                    allowRotation: false,
                                    tag: 'imageTag',
                                    useHeroAnimation: true,
                                  ),
                                ),
                              );
                            },
                            child: Hero(
                              tag: 'imageTag',
                              transitionOnUserGestures: true,
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(0),
                                  bottomRight: Radius.circular(0),
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                                child: Image.network(
                                  containerTransactionsRecord.receiptUrl,
                                  width: 100,
                                  height:
                                      MediaQuery.of(context).size.height * 0.4,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 10, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            dateTimeFormat(
                                'd/M H:mm', containerTransactionsRecord.time),
                            style: FlutterFlowTheme.title2,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 10, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              if (containerTransactionsRecord.credit ?? true)
                                Align(
                                  alignment: AlignmentDirectional(-1, 0),
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.red1,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    alignment: AlignmentDirectional(0, 0),
                                    child: Text(
                                      '-',
                                      style: FlutterFlowTheme.title1.override(
                                        fontFamily: 'Roboto',
                                        color: FlutterFlowTheme.tertiaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                              if (!(containerTransactionsRecord.credit) ?? true)
                                Align(
                                  alignment: AlignmentDirectional(-1, 0),
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF325B21),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    alignment: AlignmentDirectional(0, 0),
                                    child: Text(
                                      '+',
                                      style: FlutterFlowTheme.title1.override(
                                        fontFamily: 'Roboto',
                                        color: FlutterFlowTheme.tertiaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 10, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            formatNumber(
                              containerTransactionsRecord.amount,
                              formatType: FormatType.decimal,
                              decimalType: DecimalType.commaDecimal,
                            ),
                            style: FlutterFlowTheme.title2,
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                            child: Text(
                              'for',
                              style: FlutterFlowTheme.title2,
                            ),
                          ),
                          Text(
                            containerTransactionsRecord.quantity.toString(),
                            style: FlutterFlowTheme.title2,
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                            child: Text(
                              'items',
                              style: FlutterFlowTheme.title2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 10, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'Initial balance:',
                            style: FlutterFlowTheme.subtitle1,
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                            child: Text(
                              formatNumber(
                                containerTransactionsRecord.initialPoint,
                                formatType: FormatType.decimal,
                                decimalType: DecimalType.commaDecimal,
                              ),
                              style: FlutterFlowTheme.subtitle1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 10, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'Note:',
                            style: FlutterFlowTheme.subtitle1,
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                            child: Text(
                              containerTransactionsRecord.note,
                              style: FlutterFlowTheme.subtitle1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if ((currentUserDocument?.role) == 'admin')
                      Expanded(
                        child: Align(
                          alignment: AlignmentDirectional(0, 1),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                            child: AuthUserStreamWidget(
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      Navigator.pop(context);
                                      await containerTransactionsRecord
                                          .reference
                                          .delete();
                                    },
                                    child: Material(
                                      color: Colors.transparent,
                                      elevation: 4,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      child: Container(
                                        width: 100,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.red1,
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        alignment: AlignmentDirectional(0, 0),
                                        child: Text(
                                          'Delete',
                                          style: FlutterFlowTheme.subtitle1
                                              .override(
                                            fontFamily: 'Roboto',
                                            color:
                                                FlutterFlowTheme.tertiaryColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
