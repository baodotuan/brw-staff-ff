import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class ManageStaffPageWidget extends StatefulWidget {
  ManageStaffPageWidget({Key key}) : super(key: key);

  @override
  _ManageStaffPageWidgetState createState() => _ManageStaffPageWidgetState();
}

class _ManageStaffPageWidgetState extends State<ManageStaffPageWidget> {
  TextEditingController confirmPasswordTextController;
  bool passwordVisibility;
  TextEditingController emailTextController;
  bool _loadingButton = false;
  TextEditingController textFieldbController;
  bool textFieldbVisibility;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    confirmPasswordTextController = TextEditingController();
    passwordVisibility = false;
    emailTextController = TextEditingController();
    textFieldbController = TextEditingController();
    textFieldbVisibility = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.vertical,
          children: [
            FFButtonWidget(
              onPressed: () async {
                setState(() => _loadingButton = true);
                try {
                  if (textFieldbController.text !=
                      confirmPasswordTextController.text) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Passwords don't match!",
                        ),
                      ),
                    );
                    return;
                  }

                  final user = await createAccountWithEmail(
                    context,
                    emailTextController.text,
                    textFieldbController.text,
                  );
                  if (user == null) {
                    return;
                  }

                  final staffsCreateData = createStaffsRecordData(
                    role: '123',
                  );
                  await StaffsRecord.collection
                      .doc(user.uid)
                      .update(staffsCreateData);

                  await Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NavBarPage(initialPage: 'HomePage'),
                    ),
                    (r) => false,
                  );
                } finally {
                  setState(() => _loadingButton = false);
                }
              },
              text: 'Button',
              options: FFButtonOptions(
                width: 130,
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
              loading: _loadingButton,
            ),
            TextFormField(
              controller: emailTextController,
              obscureText: false,
              decoration: InputDecoration(
                hintText: '[Some hint text...]',
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
            ),
            TextFormField(
              controller: textFieldbController,
              obscureText: !textFieldbVisibility,
              decoration: InputDecoration(
                hintText: '[Some hint text...]',
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
                suffixIcon: InkWell(
                  onTap: () => setState(
                    () => textFieldbVisibility = !textFieldbVisibility,
                  ),
                  child: Icon(
                    textFieldbVisibility
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: Color(0xFF757575),
                    size: 22,
                  ),
                ),
              ),
              style: FlutterFlowTheme.bodyText1,
            ),
            TextFormField(
              controller: confirmPasswordTextController,
              obscureText: !passwordVisibility,
              decoration: InputDecoration(
                hintText: '[Some hint text...]',
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
                suffixIcon: InkWell(
                  onTap: () => setState(
                    () => passwordVisibility = !passwordVisibility,
                  ),
                  child: Icon(
                    passwordVisibility
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: Color(0xFF757575),
                    size: 22,
                  ),
                ),
              ),
              style: FlutterFlowTheme.bodyText1,
            )
          ],
        ),
      ),
    );
  }
}
