import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../customer_detail_page/customer_detail_page_widget.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../login_page/login_page_widget.dart';
import '../manage_staff_page/manage_staff_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePageWidget extends StatefulWidget {
  HomePageWidget({Key key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  List<UsersRecord> algoliaSearchResults = [];
  TextEditingController textController;
  var qrResult = '';
  bool _loadingButton = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0x003474E0),
        iconTheme: IconThemeData(color: Color(0xFF303030)),
        automaticallyImplyLeading: true,
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Color(0xFFF5F5F5),
      drawer: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        child: Drawer(
          elevation: 16,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Align(
                alignment: AlignmentDirectional(0, 0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Text(
                            'STAFF 1',
                            style: FlutterFlowTheme.title1,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Divider(),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 1),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xFFEEEEEE),
                    border: Border.all(
                      color: Color(0x6F303030),
                    ),
                  ),
                  child: Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: Text(
                      'cashier',
                      style: FlutterFlowTheme.title3,
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xFFEEEEEE),
                  border: Border.all(
                    color: Color(0x6F303030),
                  ),
                ),
                child: Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: Text(
                    'manager',
                    style: FlutterFlowTheme.title3,
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ManageStaffPageWidget(),
                    ),
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xFFEEEEEE),
                    border: Border.all(
                      color: Color(0x6F303030),
                    ),
                  ),
                  child: Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: Text(
                      'admin',
                      style: FlutterFlowTheme.title3,
                    ),
                  ),
                ),
              ),
              FFButtonWidget(
                onPressed: () async {
                  setState(() => _loadingButton = true);
                  try {
                    await signOut();
                    await Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPageWidget(),
                      ),
                      (r) => false,
                    );
                  } finally {
                    setState(() => _loadingButton = false);
                  }
                },
                text: 'log out',
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
              )
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Search',
                    style: FlutterFlowTheme.title1,
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 50,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.tertiaryColor,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: textController,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'name / phone',
                                    labelStyle: FlutterFlowTheme.bodyText1,
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
                              ),
                              FlutterFlowIconButton(
                                borderColor: Colors.transparent,
                                borderRadius: 30,
                                borderWidth: 0,
                                buttonSize: 50,
                                icon: Icon(
                                  Icons.search,
                                  color: Color(0x6F303030),
                                  size: 20,
                                ),
                                onPressed: () async {
                                  setState(() => algoliaSearchResults = null);
                                  await UsersRecord.search(
                                    term: valueOrDefault<String>(
                                      textController.text,
                                      '*',
                                    ),
                                    maxResults: 5,
                                  )
                                      .then((r) => algoliaSearchResults = r)
                                      .onError(
                                          (_, __) => algoliaSearchResults = [])
                                      .whenComplete(() => setState(() {}));
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  FlutterFlowIconButton(
                    borderColor: Colors.transparent,
                    borderRadius: 30,
                    borderWidth: 1,
                    buttonSize: 60,
                    icon: Icon(
                      Icons.photo_camera,
                      color: Color(0xFF565656),
                      size: 30,
                    ),
                    onPressed: () async {
                      qrResult = await FlutterBarcodeScanner.scanBarcode(
                        '#C62828', // scanning line color
                        'Cancel', // cancel button text
                        true, // whether to show the flash icon
                        ScanMode.QR,
                      );

                      setState(() {});
                    },
                  )
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 40),
                child: FutureBuilder<List<UsersRecord>>(
                  future: UsersRecord.search(
                    term: textController.text,
                    maxResults: 5,
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
                    List<UsersRecord> resultListViewUsersRecordList =
                        snapshot.data;
                    // Customize what your widget looks like with no search results.
                    if (snapshot.data.isEmpty) {
                      return Container(
                        height: 100,
                        child: Center(
                          child: Text('No results.'),
                        ),
                      );
                    }
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      itemCount: resultListViewUsersRecordList.length,
                      itemBuilder: (context, resultListViewIndex) {
                        final resultListViewUsersRecord =
                            resultListViewUsersRecordList[resultListViewIndex];
                        return Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(10, 0, 10, 10),
                          child: InkWell(
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CustomerDetailPageWidget(
                                    userRef:
                                        resultListViewUsersRecord.reference,
                                  ),
                                ),
                              );
                            },
                            child: Material(
                              color: Colors.transparent,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Container(
                                width: 100,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.tertiaryColor,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 10, 10, 10),
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
                                          Text(
                                            'Name:',
                                            style: FlutterFlowTheme.subtitle1,
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    5, 0, 0, 0),
                                            child: Text(
                                              resultListViewUsersRecord
                                                  .firstName,
                                              style: FlutterFlowTheme.subtitle1,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    5, 0, 0, 0),
                                            child: Text(
                                              resultListViewUsersRecord
                                                  .lastName,
                                              style: FlutterFlowTheme.subtitle1,
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            'Point:',
                                            style: FlutterFlowTheme.title3,
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    5, 0, 0, 0),
                                            child: Text(
                                              resultListViewUsersRecord.point
                                                  .toString(),
                                              style: FlutterFlowTheme.title3,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
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
            )
          ],
        ),
      ),
    );
  }
}
