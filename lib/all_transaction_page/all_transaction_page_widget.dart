import '../backend/backend.dart';
import '../components/back_nav_widget.dart';
import '../components/trans_detail_comp_widget.dart';
import '../flutter_flow/flutter_flow_expanded_image_view.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class AllTransactionPageWidget extends StatefulWidget {
  const AllTransactionPageWidget({Key key}) : super(key: key);

  @override
  _AllTransactionPageWidgetState createState() =>
      _AllTransactionPageWidgetState();
}

class _AllTransactionPageWidgetState extends State<AllTransactionPageWidget> {
  DateTime datePicked1;
  DateTime datePicked2;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.tertiaryColor,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            BackNavWidget(),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'All Transactions',
                    style: FlutterFlowTheme.title1,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      await DatePicker.showDatePicker(
                        context,
                        showTitleActions: true,
                        onConfirm: (date) {
                          setState(() => datePicked1 = date);
                        },
                        currentTime: getCurrentTimestamp,
                      );
                    },
                    child: Material(
                      color: Colors.transparent,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        width: 100,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color(0xFFEEEEEE),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: AlignmentDirectional(0, 0),
                        child: Text(
                          dateTimeFormat('d/M/y', datePicked1),
                          style: FlutterFlowTheme.subtitle2,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                    child: Text(
                      '->',
                      style: FlutterFlowTheme.title3,
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      await DatePicker.showDatePicker(
                        context,
                        showTitleActions: true,
                        onConfirm: (date) {
                          setState(() => datePicked2 = date);
                        },
                        currentTime: getCurrentTimestamp,
                      );
                    },
                    child: Material(
                      color: Colors.transparent,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        width: 100,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color(0xFFEEEEEE),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: AlignmentDirectional(0, 0),
                        child: Text(
                          dateTimeFormat('d/M/y', datePicked2),
                          style: FlutterFlowTheme.subtitle2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                child: StreamBuilder<List<TransactionsRecord>>(
                  stream: queryTransactionsRecord(
                    queryBuilder: (transactionsRecord) => transactionsRecord
                        .where('time', isGreaterThanOrEqualTo: datePicked1)
                        .where('time', isLessThanOrEqualTo: datePicked2)
                        .orderBy('time', descending: true),
                    limit: 100,
                  ),
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
                    List<TransactionsRecord>
                        resultListViewTransactionsRecordList = snapshot.data;
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      itemCount: resultListViewTransactionsRecordList.length,
                      itemBuilder: (context, resultListViewIndex) {
                        final resultListViewTransactionsRecord =
                            resultListViewTransactionsRecordList[
                                resultListViewIndex];
                        return Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 5),
                          child: InkWell(
                            onTap: () async {
                              await showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                barrierColor: Colors.transparent,
                                context: context,
                                builder: (context) {
                                  return Padding(
                                    padding: MediaQuery.of(context).viewInsets,
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.8,
                                      child: TransDetailCompWidget(
                                        transRef:
                                            resultListViewTransactionsRecord
                                                .reference,
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Color(0xFFF2F2F2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        if (resultListViewTransactionsRecord
                                                .credit ??
                                            true)
                                          Align(
                                            alignment:
                                                AlignmentDirectional(-1, 0),
                                            child: Container(
                                              width: 50,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                color: FlutterFlowTheme.red1,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              alignment:
                                                  AlignmentDirectional(0, 0),
                                              child: Text(
                                                '-',
                                                style: FlutterFlowTheme.title1
                                                    .override(
                                                  fontFamily: 'Roboto',
                                                  color: FlutterFlowTheme
                                                      .tertiaryColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                        if (!(resultListViewTransactionsRecord
                                                .credit) ??
                                            true)
                                          Align(
                                            alignment:
                                                AlignmentDirectional(-1, 0),
                                            child: Container(
                                              width: 50,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                color: Color(0xFF325B21),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              alignment:
                                                  AlignmentDirectional(0, 0),
                                              child: Text(
                                                '+',
                                                style: FlutterFlowTheme.title1
                                                    .override(
                                                  fontFamily: 'Roboto',
                                                  color: FlutterFlowTheme
                                                      .tertiaryColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional(-1, 0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10, 10, 0, 10),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(5, 0, 0, 0),
                                                  child: Text(
                                                    dateTimeFormat(
                                                        'd/M h:mm a',
                                                        resultListViewTransactionsRecord
                                                            .time),
                                                    style: FlutterFlowTheme
                                                        .subtitle2,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            StreamBuilder<UsersRecord>(
                                              stream: UsersRecord.getDocument(
                                                  resultListViewTransactionsRecord
                                                      .customerId),
                                              builder: (context, snapshot) {
                                                // Customize what your widget looks like when it's loading.
                                                if (!snapshot.hasData) {
                                                  return Center(
                                                    child: SizedBox(
                                                      width: 40,
                                                      height: 40,
                                                      child:
                                                          SpinKitDoubleBounce(
                                                        color: FlutterFlowTheme
                                                            .primaryColor,
                                                        size: 40,
                                                      ),
                                                    ),
                                                  );
                                                }
                                                final rowUsersRecord =
                                                    snapshot.data;
                                                return Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  5, 0, 0, 0),
                                                      child: Text(
                                                        rowUsersRecord.lastName,
                                                        style: FlutterFlowTheme
                                                            .bodyText1,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  5, 0, 0, 0),
                                                      child: Text(
                                                        rowUsersRecord
                                                            .firstName,
                                                        style: FlutterFlowTheme
                                                            .bodyText1,
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(5, 0, 0, 0),
                                                  child: Text(
                                                    'Initial balance',
                                                    style: FlutterFlowTheme
                                                        .bodyText1,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(5, 0, 0, 0),
                                                  child: Text(
                                                    formatNumber(
                                                      resultListViewTransactionsRecord
                                                          .initialPoint,
                                                      formatType:
                                                          FormatType.decimal,
                                                      decimalType: DecimalType
                                                          .commaDecimal,
                                                    ),
                                                    style: FlutterFlowTheme
                                                        .bodyText1,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(5, 0, 0, 0),
                                                  child: Text(
                                                    formatNumber(
                                                      resultListViewTransactionsRecord
                                                          .amount,
                                                      formatType:
                                                          FormatType.decimal,
                                                      decimalType: DecimalType
                                                          .commaDecimal,
                                                    ),
                                                    style: FlutterFlowTheme
                                                        .subtitle2,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(5, 0, 0, 0),
                                                  child: Text(
                                                    'for',
                                                    style: FlutterFlowTheme
                                                        .subtitle2,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(5, 0, 0, 0),
                                                  child: Text(
                                                    resultListViewTransactionsRecord
                                                        .quantity
                                                        .toString(),
                                                    style: FlutterFlowTheme
                                                        .subtitle2,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(5, 0, 0, 0),
                                                  child: Text(
                                                    'items',
                                                    style: FlutterFlowTheme
                                                        .subtitle2,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: AlignmentDirectional(1, 0),
                                        child: InkWell(
                                          onTap: () async {
                                            await Navigator.push(
                                              context,
                                              PageTransition(
                                                type: PageTransitionType.fade,
                                                child:
                                                    FlutterFlowExpandedImageView(
                                                  image: CachedNetworkImage(
                                                    imageUrl:
                                                        resultListViewTransactionsRecord
                                                            .receiptUrl,
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
                                                bottomRight:
                                                    Radius.circular(10),
                                                topLeft: Radius.circular(0),
                                                topRight: Radius.circular(10),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    resultListViewTransactionsRecord
                                                        .receiptUrl,
                                                width: 80,
                                                height: 100,
                                                fit: BoxFit.cover,
                                              ),
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
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
