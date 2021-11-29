import '../backend/backend.dart';
import '../components/back_nav_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../transaction_page/transaction_page_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomerDetailPageWidget extends StatefulWidget {
  CustomerDetailPageWidget({
    Key key,
    this.userRef,
  }) : super(key: key);

  final DocumentReference userRef;

  @override
  _CustomerDetailPageWidgetState createState() =>
      _CustomerDetailPageWidgetState();
}

class _CustomerDetailPageWidgetState extends State<CustomerDetailPageWidget> {
  bool _loadingButton1 = false;
  bool _loadingButton2 = false;
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
          backgroundColor: Color(0xFFF5F5F5),
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
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 180,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.tertiaryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              customerDetailPageUsersRecord.uid,
                              style: FlutterFlowTheme.bodyText1,
                            ),
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
                                )
                              ],
                            ),
                            Text(
                              customerDetailPageUsersRecord.phoneNumber,
                              style: FlutterFlowTheme.subtitle1,
                            ),
                            Text(
                              customerDetailPageUsersRecord.point.toString(),
                              style: FlutterFlowTheme.subtitle1,
                            )
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
                            setState(() => _loadingButton1 = true);
                            try {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TransactionPageWidget(
                                    userRef: widget.userRef,
                                    creditBool: false,
                                    onlineOrder: false,
                                    transAmount: 0,
                                  ),
                                ),
                              );
                            } finally {
                              setState(() => _loadingButton1 = false);
                            }
                          },
                          text: 'Nap tien',
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
                          loading: _loadingButton1,
                        ),
                        FFButtonWidget(
                          onPressed: () async {
                            setState(() => _loadingButton2 = true);
                            try {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TransactionPageWidget(
                                    userRef: widget.userRef,
                                    creditBool: true,
                                    onlineOrder: false,
                                    transAmount: 0,
                                  ),
                                ),
                              );
                            } finally {
                              setState(() => _loadingButton2 = false);
                            }
                          },
                          text: 'Thanh toan',
                          options: FFButtonOptions(
                            width: 130,
                            height: 40,
                            color: Color(0xFFA93F3F),
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
                          loading: _loadingButton2,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'History',
                          style: FlutterFlowTheme.title1,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                      child: StreamBuilder<List<TransactionsRecord>>(
                        stream: queryTransactionsRecord(
                          queryBuilder: (transactionsRecord) =>
                              transactionsRecord
                                  .where('customer_id',
                                      isEqualTo: widget.userRef)
                                  .orderBy('time', descending: true),
                          limit: 5,
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
                              listViewTransactionsRecordList = snapshot.data;
                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: listViewTransactionsRecordList.length,
                            itemBuilder: (context, listViewIndex) {
                              final listViewTransactionsRecord =
                                  listViewTransactionsRecordList[listViewIndex];
                              return Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                                child: Material(
                                  color: Colors.transparent,
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.tertiaryColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(0),
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(0),
                                          ),
                                          child: CachedNetworkImage(
                                            imageUrl: listViewTransactionsRecord
                                                .receiptUrl,
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20, 0, 0, 0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                dateTimeFormat(
                                                    'd/M h:m a',
                                                    listViewTransactionsRecord
                                                        .time),
                                                style:
                                                    FlutterFlowTheme.subtitle1,
                                              ),
                                              Text(
                                                listViewTransactionsRecord
                                                    .amount
                                                    .toString(),
                                                style:
                                                    FlutterFlowTheme.bodyText1,
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
