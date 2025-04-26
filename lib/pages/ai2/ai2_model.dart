import '/backend/api_requests/api_calls.dart';
import '/components/ai_bottom_sheet/ai_bottom_sheet_widget.dart';
import '/components/sensor_data/sensor_data_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_toggle_icon.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'ai2_widget.dart' show Ai2Widget;
import 'package:aligned_tooltip/aligned_tooltip.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'ble_service.dart';

class Ai2Model extends FlutterFlowModel<Ai2Widget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for Column widget.
  ScrollController? columnController;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for ListView widget.
  ScrollController? listViewController;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // State field(s) for BLE sensor data
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  // BLE sensor data flag
  bool hasSensorData = false;
  // Stores action output result for [Backend Call - API (paul)] action in Icon widget.
  ApiCallResponse? _apiResulte8x;
  set apiResulte8x(ApiCallResponse? value) {
    _apiResulte8x = value;
    debugLogWidgetClass(this);
  }

  ApiCallResponse? get apiResulte8x => _apiResulte8x;

  // Speech to text variables
  stt.SpeechToText? speechToText;
  bool isListening = false;
  String recognizedText = '';

  final Map<String, DebugDataField> debugGeneratorVariables = {};
  final Map<String, DebugDataField> debugBackendQueries = {};
  final Map<String, FlutterFlowModel> widgetBuilderComponents = {};
  @override
  void initState(BuildContext context) {
    columnController = ScrollController();
    listViewController = ScrollController();
    speechToText = stt.SpeechToText();
  }

  @override
  void dispose() {
    listViewController?.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();
    textFieldFocusNode2?.dispose();
    textController2?.dispose();
    if (isListening) {
      speechToText?.stop();
    }
  }

  // Initialize speech recognition
  Future<bool> initSpeech() async {
    bool available = await speechToText?.initialize() ?? false;
    return available;
  }

  // Start listening to speech
  void startListening(Function(String) onResult) async {
    if (!isListening) {
      bool available = await initSpeech();
      if (available) {
        isListening = true;

        // Define a function to start listening that can be called recursively
        Future<void> listen() async {
          if (!isListening) return; // Safety check

          try {
            await speechToText?.listen(
              onResult: (result) {
                recognizedText = result.recognizedWords;
                onResult(recognizedText);
              },
              listenFor: Duration(
                  hours: 1), // Shorter duration to catch stops more reliably
              pauseFor:
                  Duration(seconds: 10), // Shorter pause to be more responsive
              partialResults: true,
              localeId: null, // This will use the device's default language
              cancelOnError: false,
              listenMode: stt.ListenMode.dictation,
            );

            // Add listener to restart if it stops
            speechToText?.statusListener = (status) {
              if (status == 'done' && isListening) {
                // Restart listening immediately when it stops
                Future.delayed(Duration(milliseconds: 200), () {
                  if (isListening) {
                    listen(); // Recursively call listen again
                  }
                });
              }
            };
          } catch (e) {
            print("Speech recognition error: $e");
            // Try to restart if there was an error
            if (isListening) {
              Future.delayed(Duration(seconds: 1), () {
                if (isListening) {
                  listen(); // Try again after error
                }
              });
            }
          }
        }

        // Start the initial listening session
        await listen();
      }
    }
  }

  // Stop listening to speech
  void stopListening() {
    if (isListening) {
      speechToText?.stop();
      isListening = false;
    }
  }

  @override
  WidgetClassDebugData toWidgetClassDebugData() => WidgetClassDebugData(
        widgetStates: {
          'textFieldText': debugSerializeParam(
            textController?.text,
            ParamType.String,
            link:
                'https://app.flutterflow.io/project/krishi-b5r9t8?tab=uiBuilder&page=ai2',
            name: 'String',
            nullable: true,
          ),
          'textFieldText2': debugSerializeParam(
            textController2?.text,
            ParamType.String,
            link:
                'https://app.flutterflow.io/project/krishi-b5r9t8?tab=uiBuilder&page=ai2',
            name: 'String',
            nullable: true,
          )
        },
        actionOutputs: {
          'apiResulte8x': debugSerializeParam(
            apiResulte8x,
            ParamType.ApiResponse,
            link:
                'https://app.flutterflow.io/project/krishi-b5r9t8?tab=uiBuilder&page=ai2',
            name: 'ApiCallResponse',
            nullable: true,
          )
        },
        generatorVariables: debugGeneratorVariables,
        backendQueries: debugBackendQueries,
        componentStates: {
          ...widgetBuilderComponents.map(
            (key, value) => MapEntry(
              key,
              value.toWidgetClassDebugData(),
            ),
          ),
        }.withoutNulls,
        link:
            'https://app.flutterflow.io/project/krishi-b5r9t8/tab=uiBuilder&page=ai2',
        searchReference: 'reference=OgNhaTJQAVoDYWky',
        widgetClassName: 'ai2',
      );
}
