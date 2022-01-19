import '../backend/backend.dart';
import '../components/back_nav_widget.dart';
import '../components/trans_detail_comp_widget.dart';
import '../flutter_flow/flutter_flow_expanded_image_view.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../transaction_page/transaction_page_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class CustomerDetailPageWidget extends StatefulWidget {
  const CustomerDetailPageWidget({
    Key key,
    this.userRef,
  }) : super(key: key);

  final DocumentReference userRef;

  @override
  _CustomerDetailPageWidgetState createState() =>
      _CustomerDetailPageWidgetState();
}

class _CustomerDetailPageWidgetState extends State<CustomerDetailPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UsersRecord>(
      stream: UsersRecord.getDocument(widget.userRef),
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
        final customerDetailPageUsersRecord = snapshot.data;
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.tertiaryColor,
          body: SafeArea(
            child: Align(
              alignment: AlignmentDirectional(0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BackNavWidget(),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 130,
                      decoration: BoxDecoration(
                        color: Color(0xFFF7F7F7),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 5, 0),
                                  child: Text(
                                    customerDetailPageUsersRecord.lastName,
                                    style: FlutterFlowTheme.subtitle1,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5, 0, 0, 0),
                                  child: Text(
                                    customerDetailPageUsersRecord.firstName,
                                    style: FlutterFlowTheme.subtitle1,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              customerDetailPageUsersRecord.phoneNumber,
                              style: FlutterFlowTheme.subtitle1,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Point:',
                                  style: FlutterFlowTheme.subtitle1,
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5, 0, 0, 0),
                                  child: Text(
                                    formatNumber(
                                      customerDetailPageUsersRecord.point,
                                      formatType: FormatType.decimal,
                                      decimalType: DecimalType.commaDecimal,
                                    ),
                                    style: FlutterFlowTheme.subtitle1,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Loyalty point:',
                                  style: FlutterFlowTheme.subtitle1,
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5, 0, 0, 0),
                                  child: Text(
                                    customerDetailPageUsersRecord
                                        .loyaltyCardPoint
                                        .toString(),
                                    style: FlutterFlowTheme.subtitle1,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FFButtonWidget(
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.fade,
                                duration: Duration(milliseconds: 0),
                                reverseDuration: Duration(milliseconds: 0),
                                child: TransactionPageWidget(
                                  userRef: widget.userRef,
                                  creditBool: false,
                                  onlineOrder: false,
                                  transAmount: 0,
                                  transQuantity: 0,
                                ),
                              ),
                            );
                          },
                          text: 'Nạp Tiền',
                          options: FFButtonOptions(
                            width: 130,
                            height: 40,
                            color: Color(0xFF689C27),
                            textStyle: FlutterFlowTheme.subtitle2.override(
                              fontFamily: 'Roboto',
                              color: Colors.white,
                            ),
                            elevation: 4,
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            ),
                            borderRadius: 20,
                          ),
                        ),
                        FFButtonWidget(
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.fade,
                                duration: Duration(milliseconds: 0),
                                reverseDuration: Duration(milliseconds: 0),
                                child: TransactionPageWidget(
                                  userRef: widget.userRef,
                                  creditBool: true,
                                  onlineOrder: false,
                                  transAmount: 0,
                                  transQuantity: 1,
                                ),
                              ),
                            );
                          },
                          text: 'Thanh Toán',
                          options: FFButtonOptions(
                            width: 130,
                            height: 40,
                            color: FlutterFlowTheme.red1,
                            textStyle: FlutterFlowTheme.subtitle2.override(
                              fontFamily: 'Roboto',
                              color: Colors.white,
                            ),
                            elevation: 4,
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            ),
                            borderRadius: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FFButtonWidget(
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.fade,
                                duration: Duration(milliseconds: 0),
                                reverseDuration: Duration(milliseconds: 0),
                                child: TransactionPageWidget(
                                  userRef: widget.userRef,
                                  creditBool: false,
                                  onlineOrder: false,
                                  transAmount: 0,
                                  transQuantity: 1,
                                  tichDiem: true,
                                ),
                              ),
                            );
                          },
                          text: 'Tích Điểm',
                          options: FFButtonOptions(
                            width: 130,
                            height: 40,
                            color: FlutterFlowTheme.primaryColor,
                            textStyle: FlutterFlowTheme.subtitle2.override(
                              fontFamily: 'Roboto',
                              color: Colors.white,
                            ),
                            elevation: 4,
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            ),
                            borderRadius: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'History',
                          style: FlutterFlowTheme.title1,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: StreamBuilder<List<TransactionsRecord>>(
                      stream: queryTransactionsRecord(
                        queryBuilder: (transactionsRecord) => transactionsRecord
                            .where('customer_id', isEqualTo: widget.userRef)
                            .orderBy('time', descending: true),
                        limit: 50,
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
                            resultListViewTransactionsRecordList =
                            snapshot.data;
                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.vertical,
                          itemCount:
                              resultListViewTransactionsRecordList.length,
                          itemBuilder: (context, resultListViewIndex) {
                            final resultListViewTransactionsRecord =
                                resultListViewTransactionsRecordList[
                                    resultListViewIndex];
                            return Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(10, 0, 10, 5),
                              child: InkWell(
                                onTap: () async {
                                  await showModalBottomSheet(
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    barrierColor: Colors.transparent,
                                    context: context,
                                    builder: (context) {
                                      return Padding(
                                        padding:
                                            MediaQuery.of(context).viewInsets,
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
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
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF8F8F8),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10, 0, 0, 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            if (resultListViewTransactionsRecord
                                                    .credit ??
                                                true)
                                              Container(
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
                                            if (!(resultListViewTransactionsRecord
                                                    .credit) ??
                                                true)
                                              Container(
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
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
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
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                5, 0, 0, 0),
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
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                5, 0, 0, 0),
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
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                5, 0, 0, 0),
                                                    child: Text(
                                                      'for',
                                                      style: FlutterFlowTheme
                                                          .subtitle2,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                5, 0, 0, 0),
                                                    child: Text(
                                                      resultListViewTransactionsRecord
                                                          .quantity
                                                          .toString(),
                                                      style: FlutterFlowTheme
                                                          .subtitle2,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                5, 0, 0, 0),
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
                                        Expanded(
                                          child: Align(
                                            alignment:
                                                AlignmentDirectional(1, 0),
                                            child: InkWell(
                                              onTap: () async {
                                                await Navigator.push(
                                                  context,
                                                  PageTransition(
                                                    type:
                                                        PageTransitionType.fade,
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
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(0),
                                                    bottomRight:
                                                        Radius.circular(10),
                                                    topLeft: Radius.circular(0),
                                                    topRight:
                                                        Radius.circular(10),
                                                  ),
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        resultListViewTransactionsRecord
                                                            .receiptUrl,
                                                    width: 80,
                                                    height: 80,
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
