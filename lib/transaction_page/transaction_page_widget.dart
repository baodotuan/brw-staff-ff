import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../backend/firebase_storage/storage.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/upload_media.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class TransactionPageWidget extends StatefulWidget {
  TransactionPageWidget({
    Key key,
    this.creditBool,
    this.userRef,
    this.transAmount,
    this.onlineOrder,
    this.orderRef,
  }) : super(key: key);

  final bool creditBool;
  final DocumentReference userRef;
  final int transAmount;
  final bool onlineOrder;
  final DocumentReference orderRef;

  @override
  _TransactionPageWidgetState createState() => _TransactionPageWidgetState();
}

class _TransactionPageWidgetState extends State<TransactionPageWidget> {
  String uploadedFileUrl = '';
  TextEditingController textController;
  TransactionsRecord createdTrans;
  bool _loadingButton1 = false;
  bool _loadingButton2 = false;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController = TextEditingController(text: widget.transAmount.toString());
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
                padding: EdgeInsetsDirectional.fromSTEB(10, 40, 10, 40),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.tertiaryColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 5, 0),
                                      child: Text(
                                        transactionPageUsersRecord.lastName,
                                        style: FlutterFlowTheme.subtitle1,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          5, 0, 0, 0),
                                      child: Text(
                                        transactionPageUsersRecord.firstName,
                                        style: FlutterFlowTheme.subtitle1,
                                      ),
                                    )
                                  ],
                                ),
                                Text(
                                  transactionPageUsersRecord.phoneNumber,
                                  style: FlutterFlowTheme.subtitle2,
                                ),
                                Text(
                                  transactionPageUsersRecord.point.toString(),
                                  style: FlutterFlowTheme.subtitle2,
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(10, 20, 0, 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Trans Type: ',
                                style: FlutterFlowTheme.subtitle1,
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                child: Text(
                                  functions.transactionType(widget.creditBool),
                                  style: FlutterFlowTheme.title3,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(10, 20, 0, 10),
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
                                      width: MediaQuery.of(context).size.width,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.tertiaryColor,
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(
                                          color: FlutterFlowTheme.primaryColor,
                                          width: 1,
                                        ),
                                      ),
                                      alignment: AlignmentDirectional(0, 0),
                                      child: TextFormField(
                                        controller: textController,
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
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: AlignmentDirectional(0, 0),
                                  child: InkWell(
                                    onTap: () async {
                                      final selectedMedia = await selectMedia();
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
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: FlutterFlowTheme.primaryColor,
                                          width: 1,
                                        ),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
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
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FFButtonWidget(
                          onPressed: () async {
                            setState(() => _loadingButton1 = true);
                            try {
                              if (!formKey.currentState.validate()) {
                                return;
                              }
                              final usersUpdateData = createUsersRecordData(
                                point: functions.getThenAddPoint(
                                    transactionPageUsersRecord.point,
                                    int.parse(textController.text),
                                    widget.creditBool),
                              );
                              await transactionPageUsersRecord.reference
                                  .update(usersUpdateData);

                              final transactionsCreateData =
                                  createTransactionsRecordData(
                                amount: int.parse(textController.text),
                                customerId: widget.userRef,
                                credit: widget.creditBool,
                                time: getCurrentTimestamp,
                                receiptUrl: uploadedFileUrl,
                              );
                              final transactionsRecordReference =
                                  TransactionsRecord.collection.doc();
                              await transactionsRecordReference
                                  .set(transactionsCreateData);
                              createdTrans =
                                  TransactionsRecord.getDocumentFromData(
                                      transactionsCreateData,
                                      transactionsRecordReference);
                              if (widget.onlineOrder) {
                                final ordersUpdateData = createOrdersRecordData(
                                  transacted: true,
                                  transactionId: createdTrans.reference,
                                );
                                await widget.orderRef.update(ordersUpdateData);
                              }
                              Navigator.pop(context);

                              setState(() {});
                            } finally {
                              setState(() => _loadingButton1 = false);
                            }
                          },
                          text: 'Process',
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
                          loading: _loadingButton1,
                        )
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FFButtonWidget(
                          onPressed: () async {
                            setState(() => _loadingButton2 = true);
                            try {
                              Navigator.pop(context);
                            } finally {
                              setState(() => _loadingButton2 = false);
                            }
                          },
                          text: 'Cancel',
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
                    )
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
