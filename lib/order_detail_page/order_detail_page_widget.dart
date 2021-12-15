import '../auth/auth_util.dart';
import '../backend/api_requests/api_calls.dart';
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
  const OrderDetailPageWidget({
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
        final orderDetailPageUsersRecord = snapshot.data;
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
                            'Order Detail',
                            style: FlutterFlowTheme.title1,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.vertical,
                        children: [
                          Row(
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
                                                  orderDetailPageUsersRecord
                                                      .lastName,
                                                  style: FlutterFlowTheme
                                                      .subtitle1,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(5, 0, 0, 0),
                                                child: Text(
                                                  orderDetailPageUsersRecord
                                                      .firstName,
                                                  style: FlutterFlowTheme
                                                      .subtitle1,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            orderDetailPageUsersRecord
                                                .phoneNumber,
                                            style: FlutterFlowTheme.subtitle1,
                                          ),
                                          Divider(),
                                          if (columnOrdersRecord.pickup ?? true)
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 0, 10, 0),
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
                                                ),
                                              ],
                                            ),
                                          if (columnOrdersRecord.delivery ??
                                              true)
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 0, 10, 0),
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
                                                ),
                                              ],
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(20, 10, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'Items:',
                                  style: FlutterFlowTheme.title3,
                                ),
                              ],
                            ),
                          ),
                          Builder(
                            builder: (context) {
                              final item =
                                  columnOrdersRecord.items?.toList() ?? [];
                              return Column(
                                mainAxisSize: MainAxisSize.max,
                                children:
                                    List.generate(item.length, (itemIndex) {
                                  final itemItem = item[itemIndex];
                                  return StreamBuilder<OrderItemsRecord>(
                                    stream:
                                        OrderItemsRecord.getDocument(itemItem),
                                    builder: (context, snapshot) {
                                      // Customize what your widget looks like when it's loading.
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: SizedBox(
                                            width: 40,
                                            height: 40,
                                            child: SpinKitDoubleBounce(
                                              color:
                                                  FlutterFlowTheme.primaryColor,
                                              size: 40,
                                            ),
                                          ),
                                        );
                                      }
                                      final rowOrderItemsRecord = snapshot.data;
                                      return Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              width: 100,
                                              height: 80,
                                              decoration: BoxDecoration(
                                                color: FlutterFlowTheme
                                                    .tertiaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(0),
                                              ),
                                              child: Align(
                                                alignment:
                                                    AlignmentDirectional(0, 0),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(20, 20, 20, 20),
                                                  child: StreamBuilder<
                                                      MenuItemsRecord>(
                                                    stream: MenuItemsRecord
                                                        .getDocument(
                                                            rowOrderItemsRecord
                                                                .item),
                                                    builder:
                                                        (context, snapshot) {
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
                                                      final columnMenuItemsRecord =
                                                          snapshot.data;
                                                      return Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
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
                                                              ),
                                                            ],
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        10,
                                                                        0,
                                                                        0,
                                                                        5),
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
                                                                  child: Text(
                                                                    rowOrderItemsRecord
                                                                        .note,
                                                                    style: FlutterFlowTheme
                                                                        .bodyText1,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Divider(
                                                            height: 10,
                                                            thickness: 1,
                                                            color: Color(
                                                                0xFF818181),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }),
                              );
                            },
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 20, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'Total: ',
                                  style: FlutterFlowTheme.subtitle1,
                                ),
                                Text(
                                  formatNumber(
                                    columnOrdersRecord.total,
                                    formatType: FormatType.decimal,
                                    decimalType: DecimalType.commaDecimal,
                                  ),
                                  style: FlutterFlowTheme.subtitle1,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(20, 10, 20, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Payment: ',
                                  style: FlutterFlowTheme.subtitle1,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    if (columnOrdersRecord.pointPayment ?? true)
                                      Text(
                                        'Brw.point',
                                        style: FlutterFlowTheme.subtitle1,
                                      ),
                                    if (columnOrdersRecord.cashPayment ?? true)
                                      Text(
                                        'Tiền mặt',
                                        style: FlutterFlowTheme.subtitle1,
                                      ),
                                  ],
                                ),
                                if (!(columnOrdersRecord.transacted) ?? true)
                                  Expanded(
                                    child: Align(
                                      alignment: AlignmentDirectional(1, 0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            20, 0, 0, 0),
                                        child: InkWell(
                                          onTap: () async {
                                            await showModalBottomSheet(
                                              isScrollControlled: true,
                                              context: context,
                                              builder: (context) {
                                                return Padding(
                                                  padding:
                                                      MediaQuery.of(context)
                                                          .viewInsets,
                                                  child: Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.3,
                                                    child: PaymentMethodWidget(
                                                      cash: columnOrdersRecord
                                                          .cashPayment,
                                                      point: columnOrdersRecord
                                                          .pointPayment,
                                                      orderRef: widget.orderRef,
                                                    ),
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
                                                color: FlutterFlowTheme
                                                    .primaryColor,
                                                shape: BoxShape.circle,
                                              ),
                                              alignment:
                                                  AlignmentDirectional(0, 0),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(10, 10, 10, 10),
                                                child: Icon(
                                                  Icons.edit,
                                                  color: FlutterFlowTheme
                                                      .tertiaryColor,
                                                  size: 24,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          Padding(
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 10, 0),
                                        child: Text(
                                          'Status: ',
                                          style: FlutterFlowTheme.subtitle1,
                                        ),
                                      ),
                                      if (columnOrdersRecord.transacted ?? true)
                                        Text(
                                          'Đã ',
                                          style: FlutterFlowTheme.subtitle1,
                                        ),
                                      if (!(columnOrdersRecord.transacted) ??
                                          true)
                                        Text(
                                          'Chưa ',
                                          style: FlutterFlowTheme.subtitle1,
                                        ),
                                      Text(
                                        'thanh toán và tích điểm',
                                        style: FlutterFlowTheme.subtitle1,
                                      ),
                                    ],
                                  ),
                                ),
                                if (!(columnOrdersRecord.transacted) ?? true)
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 10, 0, 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        if (columnOrdersRecord.pointPayment ??
                                            true)
                                          FFButtonWidget(
                                            onPressed: () async {
                                              await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      TransactionPageWidget(
                                                    creditBool: true,
                                                    userRef: columnOrdersRecord
                                                        .userId,
                                                    transAmount:
                                                        columnOrdersRecord
                                                            .total,
                                                    onlineOrder: true,
                                                    orderRef: widget.orderRef,
                                                    transQuantity:
                                                        columnOrdersRecord
                                                            .totalQuantity,
                                                  ),
                                                ),
                                              );
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
                                          ),
                                        if (columnOrdersRecord.cashPayment ??
                                            true)
                                          FFButtonWidget(
                                            onPressed: () async {
                                              await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      TransactionPageWidget(
                                                    creditBool: true,
                                                    userRef: columnOrdersRecord
                                                        .userId,
                                                    transAmount: 0,
                                                    onlineOrder: true,
                                                    orderRef: widget.orderRef,
                                                    transQuantity:
                                                        columnOrdersRecord
                                                            .totalQuantity,
                                                  ),
                                                ),
                                              );
                                            },
                                            text: 'Tích Điểm',
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
                                          ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        if (columnOrdersRecord.statusProcessing ?? true)
                          Expanded(
                            child: InkWell(
                              onTap: () async {
                                final ordersUpdateData = createOrdersRecordData(
                                  statusProcessing: false,
                                  statusReady: true,
                                );
                                await widget.orderRef.update(ordersUpdateData);
                                await sendNotiToCustomerCall(
                                  uid: orderDetailPageUsersRecord.uid,
                                  message: 'check your order at Brw.app',
                                  tittle: 'YOUR ORDER IS READY!',
                                );
                                Navigator.pop(context);
                              },
                              child: Container(
                                width: 100,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.secondaryColor,
                                ),
                                alignment: AlignmentDirectional(0, 0),
                                child: Text(
                                  'Order Ready',
                                  style: FlutterFlowTheme.subtitle2.override(
                                    fontFamily: 'Roboto',
                                    color: FlutterFlowTheme.tertiaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        if (columnOrdersRecord.statusReady ?? true)
                          Expanded(
                            child: InkWell(
                              onTap: () async {
                                final ordersUpdateData = createOrdersRecordData(
                                  statusReady: false,
                                  statusDone: true,
                                );
                                await widget.orderRef.update(ordersUpdateData);

                                final usersUpdateData = {
                                  'processing_order':
                                      FieldValue.arrayRemove([widget.orderRef]),
                                };
                                await widget.userRef.update(usersUpdateData);
                                await sendNotiToCustomerCall(
                                  uid: orderDetailPageUsersRecord.uid,
                                  tittle: 'YOUR ORDER IS FINISHED!',
                                  message: 'check your order at Brw.app',
                                );
                                Navigator.pop(context);
                              },
                              child: Container(
                                width: 100,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.primaryColor,
                                ),
                                alignment: AlignmentDirectional(0, 0),
                                child: Text(
                                  'Order Finished',
                                  style: FlutterFlowTheme.subtitle2.override(
                                    fontFamily: 'Roboto',
                                    color: FlutterFlowTheme.tertiaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        if (columnOrdersRecord.transacted ?? true)
                          Expanded(
                            child: InkWell(
                              onTap: () async {
                                await widget.orderRef.delete();
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
                                  'Delete Order',
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
                );
              },
            ),
          ),
        );
      },
    );
  }
}
