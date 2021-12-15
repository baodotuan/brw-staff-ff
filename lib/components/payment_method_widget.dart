import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentMethodWidget extends StatefulWidget {
  const PaymentMethodWidget({
    Key key,
    this.cash,
    this.point,
    this.orderRef,
  }) : super(key: key);

  final bool cash;
  final bool point;
  final DocumentReference orderRef;

  @override
  _PaymentMethodWidgetState createState() => _PaymentMethodWidgetState();
}

class _PaymentMethodWidgetState extends State<PaymentMethodWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              'Payment Method',
              style: FlutterFlowTheme.title3,
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.point ?? true)
              InkWell(
                onTap: () async {
                  final ordersUpdateData = createOrdersRecordData(
                    cashPayment: true,
                    pointPayment: false,
                  );
                  await widget.orderRef.update(ordersUpdateData);
                  Navigator.pop(context);
                },
                child: Material(
                  color: Colors.transparent,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: AlignmentDirectional(0, 0),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                      child: Text(
                        'Change to Cash',
                        style: FlutterFlowTheme.subtitle2.override(
                          fontFamily: 'Roboto',
                          color: FlutterFlowTheme.tertiaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            if (widget.cash ?? true)
              InkWell(
                onTap: () async {
                  final ordersUpdateData = createOrdersRecordData(
                    pointPayment: true,
                    cashPayment: false,
                  );
                  await widget.orderRef.update(ordersUpdateData);
                  Navigator.pop(context);
                },
                child: Material(
                  color: Colors.transparent,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: AlignmentDirectional(0, 0),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                      child: Text(
                        'Change to Point',
                        style: FlutterFlowTheme.subtitle2.override(
                          fontFamily: 'Roboto',
                          color: FlutterFlowTheme.tertiaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
