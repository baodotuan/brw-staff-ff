import '../auth/auth_util.dart';
import '../backend/api_requests/api_calls.dart';
import '../backend/backend.dart';
import '../backend/firebase_storage/storage.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/upload_media.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class TransactionPageWidget extends StatefulWidget {
  const TransactionPageWidget({
    Key key,
    this.creditBool,
    this.userRef,
    this.transAmount,
    this.onlineOrder,
    this.orderRef,
    this.transQuantity,
  }) : super(key: key);

  final bool creditBool;
  final DocumentReference userRef;
  final int transAmount;
  final bool onlineOrder;
  final DocumentReference orderRef;
  final int transQuantity;

  @override
  _TransactionPageWidgetState createState() => _TransactionPageWidgetState();
}

class _TransactionPageWidgetState extends State<TransactionPageWidget> {
  String uploadedFileUrl = '';
  TextEditingController textController1;
  TextEditingController textController2;
  TransactionsRecord createdTran;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController1 =
        TextEditingController(text: widget.transAmount.toString());
    textController2 =
        TextEditingController(text: widget.transQuantity.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: StreamBuilder<UsersRecord>(
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
          final transactionPageUsersRecord = snapshot.data;
          return Scaffold(
            key: scaffoldKey,
            backgroundColor: Color(0xFFF5F5F5),
            body: SafeArea(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                            child: Container(
                              width: double.infinity,
                              height: 150,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.tertiaryColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        transactionPageUsersRecord.lastName,
                                        style: FlutterFlowTheme.subtitle1,
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            5, 0, 0, 0),
                                        child: Text(
                                          transactionPageUsersRecord.firstName,
                                          style: FlutterFlowTheme.subtitle1,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    transactionPageUsersRecord.phoneNumber,
                                    style: FlutterFlowTheme.subtitle2,
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Point: ',
                                        style: FlutterFlowTheme.subtitle2,
                                      ),
                                      Text(
                                        formatNumber(
                                          transactionPageUsersRecord.point,
                                          formatType: FormatType.decimal,
                                          decimalType: DecimalType.commaDecimal,
                                        ),
                                        style: FlutterFlowTheme.subtitle2,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Loyalty Point: ',
                                        style: FlutterFlowTheme.subtitle2,
                                      ),
                                      Text(
                                        transactionPageUsersRecord
                                            .loyaltyCardPoint
                                            .toString(),
                                        style: FlutterFlowTheme.subtitle2,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 10, 0, 10),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 5, 0),
                                  child: Text(
                                    'Trans Type:',
                                    style: FlutterFlowTheme.subtitle1,
                                  ),
                                ),
                                if (widget.creditBool ?? true)
                                  Text(
                                    'Thanh Toan',
                                    style: FlutterFlowTheme.title3,
                                  ),
                                if (!(widget.creditBool) ?? true)
                                  Text(
                                    'Nap Tien',
                                    style: FlutterFlowTheme.title3,
                                  ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 1, 0, 10),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'Amount: ',
                                  style: FlutterFlowTheme.subtitle1,
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: AlignmentDirectional(0, 0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 0, 0, 0),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.tertiaryColor,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border: Border.all(
                                            color:
                                                FlutterFlowTheme.primaryColor,
                                            width: 1,
                                          ),
                                        ),
                                        alignment: AlignmentDirectional(0, 0),
                                        child: TextFormField(
                                          controller: textController1,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            enabledBorder: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                          ),
                                          style: FlutterFlowTheme.title3,
                                          textAlign: TextAlign.center,
                                          maxLines: 1,
                                          keyboardType: TextInputType.number,
                                          validator: (val) {
                                            if (val.isEmpty) {
                                              return 'required';
                                            }

                                            return null;
                                          },
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
                                EdgeInsetsDirectional.fromSTEB(10, 1, 0, 10),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'Total Quantity:',
                                  style: FlutterFlowTheme.subtitle1,
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: AlignmentDirectional(0, 0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 0, 0, 0),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.tertiaryColor,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border: Border.all(
                                            color:
                                                FlutterFlowTheme.primaryColor,
                                            width: 1,
                                          ),
                                        ),
                                        alignment: AlignmentDirectional(0, 0),
                                        child: TextFormField(
                                          controller: textController2,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            enabledBorder: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                          ),
                                          style: FlutterFlowTheme.title3,
                                          textAlign: TextAlign.center,
                                          maxLines: 1,
                                          keyboardType: TextInputType.number,
                                          validator: (val) {
                                            if (val.isEmpty) {
                                              return 'required';
                                            }

                                            return null;
                                          },
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
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Align(
                                    alignment: AlignmentDirectional(0, 0),
                                    child: InkWell(
                                      onTap: () async {
                                        final selectedMedia = await selectMedia(
                                          maxWidth: 1000.00,
                                          maxHeight: 1000.00,
                                        );
                                        if (selectedMedia != null &&
                                            validateFileFormat(
                                                selectedMedia.storagePath,
                                                context)) {
                                          showUploadMessage(
                                              context, 'Uploading file...',
                                              showLoading: true);
                                          final downloadUrl = await uploadData(
                                              selectedMedia.storagePath,
                                              selectedMedia.bytes);
                                          ScaffoldMessenger.of(context)
                                              .hideCurrentSnackBar();
                                          if (downloadUrl != null) {
                                            setState(() =>
                                                uploadedFileUrl = downloadUrl);
                                            showUploadMessage(
                                                context, 'Success!');
                                          } else {
                                            showUploadMessage(context,
                                                'Failed to upload media');
                                            return;
                                          }
                                        }
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        height: 180,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFEEEEEE),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: Image.asset(
                                              'assets/images/camera_placeholder.jpeg',
                                            ).image,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                            color:
                                                FlutterFlowTheme.primaryColor,
                                            width: 1,
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Image.network(
                                            uploadedFileUrl,
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.fitWidth,
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
                                EdgeInsetsDirectional.fromSTEB(10, 5, 10, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Text(
                                    '* yêu cầu hóa đơn có phương thức thanh toán BRW.POINT',
                                    style: FlutterFlowTheme.bodyText1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 5, 10, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Text(
                                    '*hóa đơn tích điểm yêu cầu \"Amount\" = 0',
                                    style: FlutterFlowTheme.bodyText1,
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
                        if (functions.returnFalseIfEmpty(uploadedFileUrl) ??
                            true)
                          Expanded(
                            child: InkWell(
                              onTap: () async {
                                if (!formKey.currentState.validate()) {
                                  return;
                                }
                                if (!(functions.returnFalseIfNegative(
                                    functions.addOrSubstractTwoInteger(
                                        transactionPageUsersRecord.point,
                                        int.parse(textController1.text),
                                        !(widget.creditBool))))) {
                                  await showDialog(
                                    context: context,
                                    builder: (alertDialogContext) {
                                      return AlertDialog(
                                        title: Text('not enough credit'),
                                        content: Text('Please top-up first'),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(
                                                alertDialogContext),
                                            child: Text('Ok'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                                if (functions.returnFalseIfNegative(
                                    functions.addOrSubstractTwoInteger(
                                        transactionPageUsersRecord.point,
                                        int.parse(textController1.text),
                                        !(widget.creditBool)))) {
                                  await showDialog(
                                    context: context,
                                    builder: (alertDialogContext) {
                                      return AlertDialog(
                                        title: Text('Transaction processed'),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(
                                                alertDialogContext),
                                            child: Text('Ok'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  return;
                                }
                                final transactionsCreateData =
                                    createTransactionsRecordData(
                                  amount: int.parse(textController1.text),
                                  customerId: widget.userRef,
                                  credit: widget.creditBool,
                                  time: getCurrentTimestamp,
                                  receiptUrl: uploadedFileUrl,
                                  quantity: int.parse(textController2.text),
                                  initialPoint:
                                      transactionPageUsersRecord.point,
                                );
                                final transactionsRecordReference =
                                    TransactionsRecord.collection.doc();
                                await transactionsRecordReference
                                    .set(transactionsCreateData);
                                createdTran =
                                    TransactionsRecord.getDocumentFromData(
                                        transactionsCreateData,
                                        transactionsRecordReference);

                                final usersUpdateData = createUsersRecordData(
                                  point: functions.addOrSubstractTwoInteger(
                                      transactionPageUsersRecord.point,
                                      int.parse(textController1.text),
                                      !(widget.creditBool)),
                                  loyaltyCardPoint:
                                      functions.setLimitToInterger(
                                          functions.addOrSubstractTwoInteger(
                                              transactionPageUsersRecord
                                                  .loyaltyCardPoint,
                                              int.parse(textController2.text),
                                              true),
                                          10),
                                );
                                await widget.userRef.update(usersUpdateData);
                                if (widget.onlineOrder) {
                                  final ordersUpdateData =
                                      createOrdersRecordData(
                                    transactionId: createdTran.reference,
                                    transacted: true,
                                  );
                                  await widget.orderRef
                                      .update(ordersUpdateData);
                                }
                                await sendNotiToCustomerCall(
                                  uid: transactionPageUsersRecord.uid,
                                  tittle: 'New transaction was created!',
                                  message: 'Go to Brw.app for more details',
                                );
                                Navigator.pop(context);

                                setState(() {});
                              },
                              child: Container(
                                width: 100,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.primaryColor,
                                ),
                                alignment: AlignmentDirectional(0, 0),
                                child: Text(
                                  'Process',
                                  style: FlutterFlowTheme.subtitle2.override(
                                    fontFamily: 'Roboto',
                                    color: FlutterFlowTheme.tertiaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        Expanded(
                          child: InkWell(
                            onTap: () async {
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
              ),
            ),
          );
        },
      ),
    );
  }
}
