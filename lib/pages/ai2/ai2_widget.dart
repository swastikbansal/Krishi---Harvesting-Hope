import '/backend/api_requests/api_calls.dart';
import '/components/ai_bottom_sheet/ai_bottom_sheet_widget.dart';
import '/components/sensor_data/sensor_data_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_toggle_icon.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'dart:async';
import 'package:aligned_tooltip/aligned_tooltip.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'ai2_model.dart';
export 'ai2_model.dart';
import 'ble_service.dart';

/// This is where farmer will be able to communicate with our chatbot
///
class Ai2Widget extends StatefulWidget {
  const Ai2Widget({super.key});

  static String routeName = 'ai2';
  static String routePath = '/ai2';

  @override
  State<Ai2Widget> createState() => _Ai2WidgetState();
}

class _Ai2WidgetState extends State<Ai2Widget> with RouteAware {
  late Ai2Model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final BLEService _bleService = BLEService(); // Add BLE service
  StreamSubscription? _sensorDataSubscription; // Add subscription

  int Nvalue = 0;
  int Pvalue = 0;
  int Kvalue = 0;
  double ecValue = 0.0;
  double moistureValue = 0.0;
  int lastSensorReading = 0;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => Ai2Model());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'ai2'});
    _model.textController1 ??= TextEditingController()
      ..addListener(() {
        debugLogWidgetClass(_model);
      });
    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textController2 ??= TextEditingController()
      ..addListener(() {
        debugLogWidgetClass(_model);
      });
    _model.textFieldFocusNode2 ??= FocusNode();

    // Initialize BLE sensor data subscription
    _sensorDataSubscription = _bleService.sensorData.listen((data) {
      if (FFAppState().sensorDataFetch) {
        // Always extract and store sensor values in app state when data arrives
        _extractAndStoreSensorValues(data);
        
        // Show visually distinct sensor data text in the text field
        if (_model.textController2 != null) {
          setState(() {
            _model.textController2!.text = "📊 Sensor Data";
          });
        }
      }
    });
  }

  // Extract and store sensor values from the received data string
  void _extractAndStoreSensorValues(String sensorData) {
    try {
      print("Extracting sensor values from: $sensorData");
      
      // Extract N value
      RegExp nRegex = RegExp(r'Nitrogen \(N\): (\d+) mg\/kg');
      Match? nMatch = nRegex.firstMatch(sensorData);
      if (nMatch != null && nMatch.group(1) != null) {
        String nValue = nMatch.group(1)!;
        print("Extracted N value: $nValue");
        FFAppState().Nvalue = nValue;
      }
      
      // Extract P value
      RegExp pRegex = RegExp(r'Phosphorus \(P\): (\d+) mg\/kg');
      Match? pMatch = pRegex.firstMatch(sensorData);
      if (pMatch != null && pMatch.group(1) != null) {
        String pValue = pMatch.group(1)!;
        print("Extracted P value: $pValue");
        FFAppState().Pvalue = pValue;
      }
      
      // Extract K value
      RegExp kRegex = RegExp(r'Potassium \(K\): (\d+) mg\/kg');
      Match? kMatch = kRegex.firstMatch(sensorData);
      if (kMatch != null && kMatch.group(1) != null) {
        String kValue = kMatch.group(1)!;
        print("Extracted K value: $kValue");
        FFAppState().Kvalue = kValue;
      }
      
      // Extract EC value
      RegExp ecRegex = RegExp(r'Electrical Conductivity: ([\d.]+)');
      Match? ecMatch = ecRegex.firstMatch(sensorData);
      if (ecMatch != null && ecMatch.group(1) != null) {
        String ecValue = ecMatch.group(1)!;
        print("Extracted EC value: $ecValue");
        FFAppState().ECvalue = ecValue;
      }
      
      // Extract Moisture value
      RegExp moistureRegex = RegExp(r'Soil Moisture: ([\d.]+)%?');
      Match? moistureMatch = moistureRegex.firstMatch(sensorData);
      if (moistureMatch != null && moistureMatch.group(1) != null) {
        String moistureValue = moistureMatch.group(1)!;
        print("Extracted Moisture value: $moistureValue");
        FFAppState().moisturevalue = moistureValue; // Note: using correct variable name 'moisturevalue'
      }
      
      // Sensor values successfully stored in app state
      print("Sensor values stored in AppState successfully");
    } catch (e) {
      print("Error extracting sensor values: $e");
    }
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);

    _model.dispose();

    _sensorDataSubscription?.cancel(); // Cancel subscription
    _bleService.disconnect(); // Disconnect from BLE device

    super.dispose();
  }

  // Handle sensor toggle button press
  void _handleSensorToggle() async {
    bool previousState = FFAppState().sensorDataFetch;
    bool newState = !previousState;
    
    safeSetState(() => FFAppState().sensorDataFetch = newState);

    if (newState) {
      // When toggled ON, start scanning for BLE device
      print("Sensor toggle turned ON, starting scan...");
      await _bleService.startScan();
      _model.textController2!.text = "Connecting to sensor...";
      
      // After a short delay, update text to a visually distinct sensor data indicator
      await Future.delayed(Duration(seconds: 2));
      if (FFAppState().sensorDataFetch) { // Only update if still toggled on
        setState(() {
          _model.textController2!.text = "📊 Sensor Data";
        });
      }
    } else {
      // When toggled OFF, disconnect but preserve the data and sensor text
      print("Sensor toggle turned OFF, disconnecting...");
      await _bleService.disconnect();
      
      // Keep the sensor data text for AI prompting
      // The text will remain until user manually removes it
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = DebugModalRoute.of(context);
    if (route != null) {
      routeObserver.subscribe(this, route);
    }
    debugLogGlobalProperty(context);
  }

  @override
  void didPopNext() {
    if (mounted && DebugFlutterFlowModelContext.maybeOf(context) == null) {
      setState(() => _model.isRouteVisible = true);
      debugLogWidgetClass(_model);
    }
  }

  @override
  void didPush() {
    if (mounted && DebugFlutterFlowModelContext.maybeOf(context) == null) {
      setState(() => _model.isRouteVisible = true);
      debugLogWidgetClass(_model);
    }
  }

  @override
  void didPop() {
    _model.isRouteVisible = false;
  }

  @override
  void didPushNext() {
    _model.isRouteVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    DebugFlutterFlowModelContext.maybeOf(context)
        ?.parentModelCallback
        ?.call(_model);
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        drawer: Container(
          width: double.infinity,
          child: Drawer(
            elevation: 10.0,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primaryBackground,
                shape: BoxShape.rectangle,
              ),
              child: SingleChildScrollView(
                controller: _model.columnController,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FlutterFlowIconButton(
                            borderRadius: 8.0,
                            buttonSize: 50.0,
                            icon: Icon(
                              Icons.chevron_left,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 28.0,
                            ),
                            onPressed: () async {
                              logFirebaseEvent(
                                  'AI2_PAGE_chevron_left_ICN_ON_TAP');
                              context.safePop();
                            },
                          ),
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              child: TextFormField(
                                controller: _model.textController1,
                                focusNode: _model.textFieldFocusNode1,
                                onChanged: (_) => EasyDebounce.debounce(
                                  '_model.textController1',
                                  Duration(milliseconds: 2000),
                                  () => safeSetState(() {}),
                                ),
                                autofocus: false,
                                textCapitalization: TextCapitalization.words,
                                textInputAction: TextInputAction.done,
                                obscureText: false,
                                decoration: InputDecoration(
                                  isDense: true,
                                  labelText:
                                      FFLocalizations.of(context).getText(
                                    '1r3ivi7t' /* Search */,
                                  ),
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .labelMediumFamily,
                                        letterSpacing: 0.0,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(
                                                FlutterFlowTheme.of(context)
                                                    .labelMediumFamily),
                                      ),
                                  hintText: FFLocalizations.of(context).getText(
                                    '6vevojf5' /* Search */,
                                  ),
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .labelMediumFamily,
                                        letterSpacing: 0.0,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(
                                                FlutterFlowTheme.of(context)
                                                    .labelMediumFamily),
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(24.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(24.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(24.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(24.0),
                                  ),
                                  filled: true,
                                  fillColor: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  contentPadding: EdgeInsets.all(16.0),
                                  hoverColor: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 24.0,
                                  ),
                                  suffixIcon: _model
                                          .textController1!.text.isNotEmpty
                                      ? InkWell(
                                          onTap: () async {
                                            _model.textController1?.clear();
                                            safeSetState(() {});
                                          },
                                          child: Icon(
                                            Icons.clear,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            size: 22,
                                          ),
                                        )
                                      : null,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodyMediumFamily,
                                      letterSpacing: 0.0,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily),
                                      lineHeight: 2.0,
                                    ),
                                maxLines: 2,
                                minLines: 1,
                                cursorColor:
                                    FlutterFlowTheme.of(context).primaryText,
                                validator: _model.textController1Validator
                                    .asValidator(context),
                              ),
                            ),
                          ),
                          FlutterFlowIconButton(
                            borderRadius: 8.0,
                            buttonSize: 50.0,
                            icon: FaIcon(
                              FontAwesomeIcons.edit,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 24.0,
                            ),
                            onPressed: () {
                              print('IconButton pressed ...');
                            },
                          ),
                        ]
                            .divide(SizedBox(width: 8.0))
                            .around(SizedBox(width: 8.0)),
                      ),
                    ),
                  ]
                      .divide(SizedBox(height: 12.0))
                      .addToStart(SizedBox(height: 56.0))
                      .addToEnd(SizedBox(height: 12.0)),
                ),
              ),
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(12.0, 8.0, 0.0, 4.0),
            child: FlutterFlowIconButton(
              borderColor: FlutterFlowTheme.of(context).alternate,
              borderRadius: 12.0,
              borderWidth: 2.0,
              buttonSize: 40.0,
              fillColor: FlutterFlowTheme.of(context).secondaryBackground,
              hoverColor: FlutterFlowTheme.of(context).alternate,
              hoverIconColor: FlutterFlowTheme.of(context).primaryText,
              icon: Icon(
                Icons.manage_search,
                color: FlutterFlowTheme.of(context).primaryText,
                size: 26.0,
              ),
              onPressed: () async {
                logFirebaseEvent('AI2_PAGE_manage_search_ICN_ON_TAP');
                scaffoldKey.currentState!.openDrawer();
              },
            ),
          ),
          title: Text(
            FFLocalizations.of(context).getText(
              'bglmktn8' /* Krishi AI */,
            ),
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Space Grotesk',
                  letterSpacing: 0.0,
                  useGoogleFonts:
                      GoogleFonts.asMap().containsKey('Space Grotesk'),
                ),
          ),
          actions: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 12.0, 0.0),
              child: FlutterFlowIconButton(
                borderRadius: 12.0,
                buttonSize: 40.0,
                fillColor: FlutterFlowTheme.of(context).primaryBackground,
                hoverColor: FlutterFlowTheme.of(context).alternate,
                hoverIconColor: FlutterFlowTheme.of(context).primaryText,
                icon: FaIcon(
                  FontAwesomeIcons.edit,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 24.0,
                ),
                onPressed: () {
                  print('IconButton pressed ...');
                },
              ),
            ),
          ],
          centerTitle: false,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primaryBackground,
                  ),
                  child: Builder(
                    builder: (context) {
                      final chat = FFAppState().chatlist.toList();
                      _model.debugGeneratorVariables[
                              'chat${chat.length > 100 ? ' (first 100)' : ''}'] =
                          debugSerializeParam(
                        chat.take(100),
                        ParamType.JSON,
                        isList: true,
                        link:
                            'https://app.flutterflow.io/project/krishi-b5r9t8?tab=uiBuilder&page=ai2',
                        name: 'dynamic',
                        nullable: false,
                      );
                      debugLogWidgetClass(_model);

                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.vertical,
                        itemCount: chat.length,
                        itemBuilder: (context, chatIndex) {
                          final chatItem = chat[chatIndex];
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Align(
                                  alignment: AlignmentDirectional(
                                      valueOrDefault<double>(
                                        getJsonField(
                                          chatItem,
                                          r'''$.isuser''',
                                        )
                                            ? 1.0
                                            : -1.0,
                                        0.0,
                                      ),
                                      0.0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        30.0, 10.0, 30.0, 10.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: getJsonField(
                                          chatItem,
                                          r'''$.isuser''',
                                        )
                                            ? FlutterFlowTheme.of(context).misc2
                                            : FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10.0),
                                          bottomRight: Radius.circular(10.0),
                                          topLeft: Radius.circular(10.0),
                                          topRight: Radius.circular(10.0),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10.0, 8.0, 10.0, 8.0),
                                        child: Text(
                                          getJsonField(
                                            chatItem,
                                            r'''$.message''',
                                          ).toString(),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMediumFamily,
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                                useGoogleFonts: GoogleFonts
                                                        .asMap()
                                                    .containsKey(
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMediumFamily),
                                              ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                        controller: _model.listViewController,
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Material(
                  color: Colors.transparent,
                  elevation: 0.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  child: Container(
                    width: double.infinity,
                    constraints: BoxConstraints(
                      minWidth: double.infinity,
                      maxWidth: double.infinity,
                    ),
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 2.0,
                          color: FlutterFlowTheme.of(context).alternate,
                          offset: Offset(
                            0.0,
                            0.0,
                          ),
                          spreadRadius: 2.0,
                        )
                      ],
                      borderRadius: BorderRadius.circular(24.0),
                      border: Border.all(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        width: 2.0,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            child: TextFormField(
                              controller: _model.textController2,
                              focusNode: _model.textFieldFocusNode2,
                              autofocus: false,
                              textCapitalization: TextCapitalization.words,
                              textInputAction: TextInputAction.done,
                              obscureText: false,
                              onTap: () {
                                // Open sensor data bottom sheet when sensor data is available
                                if (_model.textController2!.text.contains("Sensor Data")) {
                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    enableDrag: true,
                                    useSafeArea: true,
                                    context: context,
                                    builder: (context) {
                                      return GestureDetector(
                                        onTap: () {
                                          FocusScope.of(context).unfocus();
                                          FocusManager.instance.primaryFocus?.unfocus();
                                        },
                                        child: Padding(
                                          padding: MediaQuery.viewInsetsOf(context),
                                          child: Container(
                                            height: MediaQuery.of(context).size.height * 0.6,
                                            child: SensorDataWidget(),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }
                              },
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodyMediumFamily,
                                    letterSpacing: 0.0,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey(
                                            FlutterFlowTheme.of(context)
                                                .bodyMediumFamily),
                                    lineHeight: 1.5,
                                    // Apply custom styling conditionally
                                    color: _model.textController2!.text == "📊 Sensor Data" 
                                        ? Color(0xFF3794FF) 
                                        : FlutterFlowTheme.of(context).primaryText,
                                    fontWeight: _model.textController2!.text == "📊 Sensor Data" 
                                        ? FontWeight.bold 
                                        : FontWeight.normal,
                                  ),
                              decoration: InputDecoration(
                                isDense: true,
                                hintText: FFLocalizations.of(context).getText(
                                  'fpi1xe94' /* Ask Anything... */,
                                ),
                                hintStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodyMediumFamily,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      letterSpacing: 0.0,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .bodyMediumFamily),
                                      lineHeight: 1.0,
                                    ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    width: 1.0,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    width: 1.0,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).error,
                                    width: 1.0,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).error,
                                    width: 1.0,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                                filled: true,
                                fillColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                contentPadding: EdgeInsets.all(12.0),
                                hoverColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              maxLines: 12,
                              minLines: 1,
                              cursorColor:
                                  FlutterFlowTheme.of(context).primaryText,
                              validator: _model.textController2Validator
                                  .asValidator(context),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AlignedTooltip(
                              content: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  FFLocalizations.of(context).getText(
                                    'f94n9pmr' /* Tap to capture images, upload ... */,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodyMediumFamily,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        letterSpacing: 0.0,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(
                                                FlutterFlowTheme.of(context)
                                                    .bodyMediumFamily),
                                      ),
                                ),
                              ),
                              offset: 4.0,
                              preferredDirection: AxisDirection.right,
                              borderRadius: BorderRadius.circular(12.0),
                              backgroundColor:
                                  FlutterFlowTheme.of(context).alternate,
                              elevation: 4.0,
                              tailBaseWidth: 24.0,
                              tailLength: 12.0,
                              waitDuration: Duration(milliseconds: 100),
                              showDuration: Duration(milliseconds: 1000),
                              triggerMode: TooltipTriggerMode.longPress,
                              child: FlutterFlowIconButton(
                                borderColor:
                                    FlutterFlowTheme.of(context).alternate,
                                borderRadius: 100.0,
                                buttonSize: 35.0,
                                fillColor: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                                hoverColor:
                                    FlutterFlowTheme.of(context).alternate,
                                hoverIconColor:
                                    FlutterFlowTheme.of(context).secondaryText,
                                icon: Icon(
                                  Icons.add,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 20.0,
                                ),
                                onPressed: () async {
                                  logFirebaseEvent('AI2_PAGE_add_ICN_ON_TAP');
                                  await showModalBottomSheet(
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    enableDrag: false,
                                    useSafeArea: true,
                                    context: context,
                                    builder: (context) {
                                      return GestureDetector(
                                        onTap: () {
                                          FocusScope.of(context).unfocus();
                                          FocusManager.instance.primaryFocus
                                              ?.unfocus();
                                        },
                                        child: Padding(
                                          padding:
                                              MediaQuery.viewInsetsOf(context),
                                          child: Container(
                                            height: 240.0,
                                            child: AiBottomSheetWidget(),
                                          ),
                                        ),
                                      );
                                    },
                                  ).then((value) => safeSetState(() {}));
                                },
                              ),
                            ),
                            AlignedTooltip(
                              content: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  FFLocalizations.of(context).getText(
                                    'ajwo8bhj' /* Toggle the button to fetch and... */,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodyMediumFamily,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        letterSpacing: 0.0,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(
                                                FlutterFlowTheme.of(context)
                                                    .bodyMediumFamily),
                                      ),
                                ),
                              ),
                              offset: 4.0,
                              preferredDirection: AxisDirection.up,
                              borderRadius: BorderRadius.circular(12.0),
                              backgroundColor:
                                  FlutterFlowTheme.of(context).alternate,
                              elevation: 4.0,
                              tailBaseWidth: 24.0,
                              tailLength: 12.0,
                              waitDuration: Duration(milliseconds: 100),
                              showDuration: Duration(milliseconds: 1500),
                              triggerMode: TooltipTriggerMode.longPress,
                              child: Container(
                                height: 35.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  borderRadius: BorderRadius.circular(24.0),
                                  border: Border.all(
                                    color:
                                        FlutterFlowTheme.of(context).alternate,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Stack(
                                      children: [
                                        ToggleIcon(
                                          onPressed: _handleSensorToggle,
                                          value: FFAppState().sensorDataFetch,
                                          onIcon: Icon(
                                            Icons.sensors,
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            size: 20.0,
                                          ),
                                          offIcon: Icon(
                                            Icons.sensors_off,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            size: 20.0,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  34.0, 8.0, 0.0, 0.0),
                                          child: Text(
                                            FFLocalizations.of(context).getText(
                                              'p8g3pv2v' /* Sensor Data */,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodySmall
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodySmallFamily,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  letterSpacing: 0.0,
                                                  useGoogleFonts: GoogleFonts
                                                          .asMap()
                                                      .containsKey(
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodySmallFamily),
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ].addToEnd(SizedBox(width: 12.0)),
                                ),
                              ),
                            ),
                            AlignedTooltip(
                              content: Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Text(
                                  FFLocalizations.of(context).getText(
                                    'xouxjgfa' /* Toggle the button to access da... */,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodyMediumFamily,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        letterSpacing: 0.0,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(
                                                FlutterFlowTheme.of(context)
                                                    .bodyMediumFamily),
                                      ),
                                ),
                              ),
                              offset: 4.0,
                              preferredDirection: AxisDirection.up,
                              borderRadius: BorderRadius.circular(12.0),
                              backgroundColor:
                                  FlutterFlowTheme.of(context).alternate,
                              elevation: 4.0,
                              tailBaseWidth: 24.0,
                              tailLength: 12.0,
                              waitDuration: Duration(milliseconds: 100),
                              showDuration: Duration(milliseconds: 1500),
                              triggerMode: TooltipTriggerMode.longPress,
                              child: Container(
                                height: 35.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  borderRadius: BorderRadius.circular(24.0),
                                  border: Border.all(
                                    color:
                                        FlutterFlowTheme.of(context).alternate,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Stack(
                                      children: [
                                        ToggleIcon(
                                          onPressed: () async {
                                            safeSetState(() => FFAppState()
                                                    .aiSearchButton =
                                                !FFAppState().aiSearchButton);
                                          },
                                          value: FFAppState().aiSearchButton,
                                          onIcon: Icon(
                                            Icons.travel_explore,
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            size: 20.0,
                                          ),
                                          offIcon: Icon(
                                            Icons.search_off,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            size: 20.0,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  34.0, 8.0, 0.0, 0.0),
                                          child: Text(
                                            FFLocalizations.of(context).getText(
                                              'qcrn2e9f' /* Search */,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodySmall
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodySmallFamily,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  letterSpacing: 0.0,
                                                  useGoogleFonts: GoogleFonts
                                                          .asMap()
                                                      .containsKey(
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodySmallFamily),
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ].addToEnd(SizedBox(width: 12.0)),
                                ),
                              ),
                            ),
                            AlignedTooltip(
                              content: Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Text(
                                  FFLocalizations.of(context).getText(
                                    '8u364mm9' /* Tap to give a voice input. */,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodySmall
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodySmallFamily,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        letterSpacing: 0.0,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(
                                                FlutterFlowTheme.of(context)
                                                    .bodySmallFamily),
                                      ),
                                ),
                              ),
                              offset: 4.0,
                              preferredDirection: AxisDirection.up,
                              borderRadius: BorderRadius.circular(12.0),
                              backgroundColor:
                                  FlutterFlowTheme.of(context).alternate,
                              elevation: 4.0,
                              tailBaseWidth: 24.0,
                              tailLength: 12.0,
                              waitDuration: Duration(milliseconds: 100),
                              showDuration: Duration(milliseconds: 1000),
                              triggerMode: TooltipTriggerMode.longPress,
                              child: ToggleIcon(
                                onPressed: () async {
                                  safeSetState(() => FFAppState().voiceTrigger =
                                      !FFAppState().voiceTrigger);
                                },
                                value: FFAppState().voiceTrigger,
                                onIcon: Icon(
                                  Icons.mic,
                                  color: FlutterFlowTheme.of(context).primary,
                                  size: 20.0,
                                ),
                                offIcon: Icon(
                                  Icons.mic_off,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  size: 20.0,
                                ),
                              ),
                            ),
                            AlignedTooltip(
                              content: Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Text(
                                  FFLocalizations.of(context).getText(
                                    'lku3o8bw' /* Tap to generate an AI response... */,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodySmall
                                      .override(
                                        fontFamily: FlutterFlowTheme.of(context)
                                            .bodySmallFamily,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        letterSpacing: 0.0,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(
                                                FlutterFlowTheme.of(context)
                                                    .bodySmallFamily),
                                      ),
                                ),
                              ),
                              offset: 4.0,
                              preferredDirection: AxisDirection.left,
                              borderRadius: BorderRadius.circular(12.0),
                              backgroundColor:
                                  FlutterFlowTheme.of(context).alternate,
                              elevation: 4.0,
                              tailBaseWidth: 24.0,
                              tailLength: 12.0,
                              waitDuration: Duration(milliseconds: 100),
                              showDuration: Duration(milliseconds: 1000),
                              triggerMode: TooltipTriggerMode.longPress,
                              child: Builder(
                                builder: (context) {
                                  if (!FFAppState().isLoading) {
                                    return Container(
                                      width: 35.0,
                                      height: 35.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        borderRadius:
                                            BorderRadius.circular(24.0),
                                        border: Border.all(
                                          color: FlutterFlowTheme.of(context)
                                              .alternate,
                                        ),
                                      ),
                                      child: ToggleIcon(
                                        onPressed: () async {
                                          safeSetState(() =>
                                              FFAppState().aiSendButton =
                                                  !FFAppState().aiSendButton);
                                          logFirebaseEvent(
                                              'AI2_PAGE_ToggleIcon_70xyhzzs_ON_TOGGLE');
                                          
                                          // Store original user message
                                          String originalMessage = _model.textController2!.text;
                                          FFAppState().usermessage = originalMessage;
                                          
                                          // Create prompt text that will show in the chat
                                          FFAppState().addToChatlist(<String, dynamic>{
                                            'message': originalMessage,
                                            'isuser': true,
                                          });
                                          
                                          // Clear text fields
                                          safeSetState(() {
                                            _model.textController2?.clear();
                                            _model.textController1?.clear();
                                          });
                                          
                                          // Create the actual prompt to send to AI with sensor readings if available
                                          String fullPrompt = originalMessage;
                                          
                                          // Check if the message contains sensor data reference
                                          if (originalMessage.contains("Sensor Data")) {
                                            // Create a detailed sensor data prompt to send to the API
                                            fullPrompt = originalMessage.replaceAll("📊 Sensor Data", "");
                                            fullPrompt += "\n\nSensor Readings:\n";
                                            fullPrompt += "Nitrogen (N): ${FFAppState().Nvalue} mg/kg\n";
                                            fullPrompt += "Phosphorus (P): ${FFAppState().Pvalue} mg/kg\n";
                                            fullPrompt += "Potassium (K): ${FFAppState().Kvalue} mg/kg\n";
                                            fullPrompt += "Electrical Conductivity: ${FFAppState().ECvalue} μs/cm\n";
                                            fullPrompt += "Soil Moisture: ${FFAppState().moisturevalue}%";
                                          }
                                          
                                          // Set loading state
                                          safeSetState(() => FFAppState().isLoading = true);
                                          
                                          // Make API call with the full prompt
                                          _model.apiResultyc4 = await UltronCall.call(
                                            input: fullPrompt,
                                          );
                                          
                                          if ((_model.apiResultyc4?.succeeded ??
                                              true)) {
                                            FFAppState().addToChatlist(<String,
                                                dynamic>{
                                              'message': getJsonField(
                                                (_model.apiResultyc4
                                                        ?.jsonBody ??
                                                    ''),
                                                r'''$.choices[0].message.content''',
                                              ),
                                              'isuser': false,
                                            });
                                            safeSetState(() {});
                                          }
                                          FFAppState().isLoading = false;
                                          safeSetState(() {});
                                          await _model.listViewController
                                              ?.animateTo(
                                            _model.listViewController!.position
                                                .maxScrollExtent,
                                            duration:
                                                Duration(milliseconds: 100),
                                            curve: Curves.ease,
                                          );

                                          safeSetState(() {});
                                        },
                                        value: FFAppState().aiSendButton,
                                        onIcon: Icon(
                                          Icons.square_rounded,
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          size: 20.0,
                                        ),
                                        offIcon: FaIcon(
                                          FontAwesomeIcons.arrowUp,
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          size: 20.0,
                                        ),
                                      ),
                                    );
                                  } else {
                                    return Lottie.asset(
                                      'assets/jsons/AI_Text_Animation_Krishi.json',
                                      width: 35.0,
                                      height: 35.0,
                                      fit: BoxFit.contain,
                                      animate: true,
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ]
                          .divide(SizedBox(height: 8.0))
                          .around(SizedBox(height: 8.0)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
