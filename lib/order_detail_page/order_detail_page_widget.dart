import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../components/back_nav_widget.dart';
import '../components/payment_method_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../transaction_page/transaction_page_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderDetailPageWidget extends StatefulWidget {
  OrderDetailPageWidget({
    Key key,
    this.orderRef,
    this.userRef,
  }) : super(key: key);

  final DocumentReference orderRef;
  final DocumentReference userRef;

  @override
  _OrderDetailPageWidgetState createState() => _OrderDetailPageWidgetState();
}

class _OrderDetailPageWidgetState extends State<OrderDetailPageWidget> {
  bool _loadingButton1 = false;
  bool _loadingButton2 = false;
  bool _loadingButton3 = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: StreamBuilder<OrdersRecord>(
          stream: OrdersRecord.getDocument(widget.orderRef),
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
            final columnOrdersRecord = snapshot.data;
            return Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                BackNavWidget(),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'Order detail',
                        style: FlutterFlowTheme.title1,
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: StreamBuilder<UsersRecord>(
                    stream: UsersRecord.getDocument(columnOrdersRecord.userId),
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
                      final listViewUsersRecord = snapshot.data;
                      return ListView(
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.vertical,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10, 0, 10, 0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.tertiaryColor,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            20, 10, 20, 10),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 0, 5, 0),
                                                  child: Text(
                                                    listViewUsersRecord
                                                        .lastName,
                                                    style: FlutterFlowTheme
                                                        .subtitle1,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(5, 0, 0, 0),
                                                  child: Text(
                                                    listViewUsersRecord
                                                        .firstName,
                                                    style: FlutterFlowTheme
                                                        .subtitle1,
                                                  ),
                                                )
                                              ],
                                            ),
                                            Text(
                                              listViewUsersRecord.phoneNumber,
                                              style: FlutterFlowTheme.subtitle1,
                                            ),
                                            Divider(),
                                            Visibility(
                                              visible:
                                                  columnOrdersRecord.pickup ??
                                                      true,
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 0, 10, 0),
                                                    child: Text(
                                                      'Pickup:',
                                                      style: FlutterFlowTheme
                                                          .subtitle1,
                                                    ),
                                                  ),
                                                  Text(
                                                    columnOrdersRecord
                                                        .pickupAddress,
                                                    style: FlutterFlowTheme
                                                        .subtitle1,
                                                  )
                                                ],
                                              ),
                                            ),
                                            Visibility(
                                              visible:
                                                  columnOrdersRecord.delivery ??
                                                      true,
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 0, 10, 0),
                                                    child: Text(
                                                      'Delivery:',
                                                      style: FlutterFlowTheme
                                                          .subtitle1,
                                                    ),
                                                  ),
                                                  Text(
                                                    columnOrdersRecord
                                                        .deliveryAddress,
                                                    style: FlutterFlowTheme
                                                        .subtitle1,
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                            child: Builder(
                              builder: (context) {
                                final item =
                                    columnOrdersRecord.items?.toList() ?? [];
                                return Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children:
                                      List.generate(item.length, (itemIndex) {
                                    final itemItem = item[itemIndex];
                                    return Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 5, 10, 0),
                                      child: StreamBuilder<OrderItemsRecord>(
                                        stream: OrderItemsRecord.getDocument(
                                            itemItem),
                                        builder: (context, snapshot) {
                                          // Customize what your widget looks like when it's loading.
                                          if (!snapshot.hasData) {
                                            return Center(
                                              child: SizedBox(
                                                width: 40,
                                                height: 40,
                                                child: SpinKitDoubleBounce(
                                                  color: FlutterFlowTheme
                                                      .primaryColor,
                                                  size: 40,
                                                ),
                                              ),
                                            );
                                          }
                                          final rowOrderItemsRecord =
                                              snapshot.data;
                                          return Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  width: 100,
                                                  height: 60,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFEEEEEE),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0, 0),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(10, 10,
                                                                  10, 10),
                                                      child: StreamBuilder<
                                                          MenuItemsRecord>(
                                                        stream: MenuItemsRecord
                                                            .getDocument(
                                                                rowOrderItemsRecord
                                                                    .item),
                                                        builder: (context,
                                                            snapshot) {
                                                          // Customize what your widget looks like when it's loading.
                                                          if (!snapshot
                                                              .hasData) {
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
                                                          final columnMenuItemsRecord =
                                                              snapshot.data;
                                                          return Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    columnMenuItemsRecord
                                                                        .name,
                                                                    style: FlutterFlowTheme
                                                                        .subtitle2,
                                                                  ),
                                                                  Text(
                                                                    rowOrderItemsRecord
                                                                        .quantity
                                                                        .toString(),
                                                                    style: FlutterFlowTheme
                                                                        .subtitle2,
                                                                  )
                                                                ],
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Text(
                                                                      'Note:',
                                                                      style: FlutterFlowTheme
                                                                          .bodyText1,
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                              5,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                      child:
                                                                          Text(
                                                                        rowOrderItemsRecord
                                                                            .note,
                                                                        style: FlutterFlowTheme
                                                                            .bodyText1,
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              )
                                                            ],
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          );
                                        },
                                      ),
                                    );
                                  }),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 20, 20, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'Total: ',
                                  style: FlutterFlowTheme.subtitle1,
                                ),
                                Text(
                                  columnOrdersRecord.total.toString(),
                                  style: FlutterFlowTheme.subtitle1,
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(20, 10, 20, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Payment: ',
                                  style: FlutterFlowTheme.subtitle1,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Visibility(
                                      visible:
                                          columnOrdersRecord.pointPayment ??
                                              true,
                                      child: Text(
                                        'Brw.point',
                                        style: FlutterFlowTheme.subtitle1,
                                      ),
                                    ),
                                    Visibility(
                                      visible: columnOrdersRecord.cashPayment ??
                                          true,
                                      child: Text(
                                        'Tiền mặt',
                                        style: FlutterFlowTheme.subtitle1,
                                      ),
                                    )
                                  ],
                                ),
                                InkWell(
                                  onTap: () async {
                                    await showModalBottomSheet(
                                      isScrollControlled: true,
                                      context: context,
                                      builder: (context) {
                                        return Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.3,
                                          child: PaymentMethodWidget(
                                            cash:
                                                columnOrdersRecord.cashPayment,
                                            point:
                                                columnOrdersRecord.pointPayment,
                                            orderRef: widget.orderRef,
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Material(
                                    color: Colors.transparent,
                                    elevation: 4,
                                    shape: const CircleBorder(),
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.primaryColor,
                                        shape: BoxShape.circle,
                                      ),
                                      alignment: AlignmentDirectional(0, 0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10, 10, 10, 10),
                                        child: Icon(
                                          Icons.edit,
                                          color: FlutterFlowTheme.tertiaryColor,
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Visibility(
                            visible: columnOrdersRecord.pointPayment ?? true,
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20, 0, 20, 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 10, 0),
                                          child: Text(
                                            'Status: ',
                                            style: FlutterFlowTheme.subtitle1,
                                          ),
                                        ),
                                        Visibility(
                                          visible:
                                              columnOrdersRecord.transacted ??
                                                  true,
                                          child: Text(
                                            'Đã thanh toán',
                                            style: FlutterFlowTheme.subtitle1,
                                          ),
                                        ),
                                        Visibility(
                                          visible: !(columnOrdersRecord
                                                  .transacted) ??
                                              true,
                                          child: Text(
                                            'Chưa thanh toán',
                                            style: FlutterFlowTheme.subtitle1,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Visibility(
                                    visible: !(columnOrdersRecord.transacted) ??
                                        true,
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 10, 0, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          FFButtonWidget(
                                            onPressed: () async {
                                              setState(
                                                  () => _loadingButton1 = true);
                                              try {
                                                await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        TransactionPageWidget(
                                                      creditBool: true,
                                                      userRef:
                                                          columnOrdersRecord
                                                              .userId,
                                                      transAmount:
                                                          columnOrdersRecord
                                                              .total,
                                                      onlineOrder: true,
                                                      orderRef: widget.orderRef,
                                                    ),
                                                  ),
                                                );
                                              } finally {
                                                setState(() =>
                                                    _loadingButton1 = false);
                                              }
                                            },
                                            text: 'Thanh Toán',
                                            options: FFButtonOptions(
                                              width: 130,
                                              height: 40,
                                              color:
                                                  FlutterFlowTheme.primaryColor,
                                              textStyle: FlutterFlowTheme
                                                  .subtitle2
                                                  .override(
                                                fontFamily: 'Roboto',
                                                color: Colors.white,
                                              ),
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                                width: 1,
                                              ),
                                              borderRadius: 12,
                                            ),
                                            loading: _loadingButton1,
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
                Visibility(
                  visible: columnOrdersRecord.statusProcessing ?? true,
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FFButtonWidget(
                          onPressed: () async {
                            setState(() => _loadingButton2 = true);
                            try {
                              final ordersUpdateData = createOrdersRecordData(
                                statusReady: true,
                                statusProcessing: false,
                              );
                              await widget.orderRef.update(ordersUpdateData);
                            } finally {
                              setState(() => _loadingButton2 = false);
                            }
                          },
                          text: 'Order is ready',
                          options: FFButtonOptions(
                            width: 150,
                            height: 40,
                            color: FlutterFlowTheme.primaryColor,
                            textStyle: FlutterFlowTheme.subtitle2.override(
                              fontFamily: 'Roboto',
                              color: Colors.white,
                            ),
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: 12,
                          ),
                          loading: _loadingButton2,
                        )
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: columnOrdersRecord.statusReady ?? true,
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FFButtonWidget(
                          onPressed: () async {
                            setState(() => _loadingButton3 = true);
                            try {
                              final usersUpdateData = {
                                'processing_order':
                                    FieldValue.arrayRemove([widget.orderRef]),
                              };
                              await widget.userRef.update(usersUpdateData);
                              await columnOrdersRecord.reference.delete();
                              Navigator.pop(context);
                            } finally {
                              setState(() => _loadingButton3 = false);
                            }
                          },
                          text: 'Hoàn Thành Đơn',
                          options: FFButtonOptions(
                            width: 150,
                            height: 40,
                            color: FlutterFlowTheme.primaryColor,
                            textStyle: FlutterFlowTheme.subtitle2.override(
                              fontFamily: 'Roboto',
                              color: Colors.white,
                            ),
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: 12,
                          ),
                          loading: _loadingButton3,
                        )
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
