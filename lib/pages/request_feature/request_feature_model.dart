import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import 'request_feature_widget.dart' show RequestFeatureWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RequestFeatureModel extends FlutterFlowModel<RequestFeatureWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController;
  List<String>? get choiceChipsValues => choiceChipsValueController?.value;
  set choiceChipsValues(List<String>? val) {
    choiceChipsValueController?.value = val;
    debugLogWidgetClass(this);
  }

  // State field(s) for Slider widget.
  double? _sliderValue;
  set sliderValue(double? value) {
    _sliderValue = value;
    debugLogWidgetClass(this);
  }

  double? get sliderValue => _sliderValue;

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode3;
  TextEditingController? textController3;
  String? Function(BuildContext, String?)? textController3Validator;
  // State field(s) for Switch widget.
  bool? _switchValue;
  set switchValue(bool? value) {
    _switchValue = value;
    debugLogWidgetClass(this);
  }

  bool? get switchValue => _switchValue;

  final Map<String, DebugDataField> debugGeneratorVariables = {};
  final Map<String, DebugDataField> debugBackendQueries = {};
  final Map<String, FlutterFlowModel> widgetBuilderComponents = {};
  @override
  void initState(BuildContext context) {
    debugLogWidgetClass(this);
  }

  @override
  void dispose() {
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    textFieldFocusNode2?.dispose();
    textController2?.dispose();

    textFieldFocusNode3?.dispose();
    textController3?.dispose();
  }

  @override
  WidgetClassDebugData toWidgetClassDebugData() => WidgetClassDebugData(
        widgetStates: {
          'textFieldText1': debugSerializeParam(
            textController1?.text,
            ParamType.String,
            link:
                'https://app.flutterflow.io/project/krishi-b5r9t8?tab=uiBuilder&page=requestFeature',
            name: 'String',
            nullable: true,
          ),
          'textFieldText2': debugSerializeParam(
            textController2?.text,
            ParamType.String,
            link:
                'https://app.flutterflow.io/project/krishi-b5r9t8?tab=uiBuilder&page=requestFeature',
            name: 'String',
            nullable: true,
          ),
          'choiceChipsValues': debugSerializeParam(
            choiceChipsValues,
            ParamType.String,
            isList: true,
            link:
                'https://app.flutterflow.io/project/krishi-b5r9t8?tab=uiBuilder&page=requestFeature',
            name: 'String',
            nullable: true,
          ),
          'sliderValue': debugSerializeParam(
            sliderValue,
            ParamType.double,
            link:
                'https://app.flutterflow.io/project/krishi-b5r9t8?tab=uiBuilder&page=requestFeature',
            name: 'double',
            nullable: true,
          ),
          'textFieldText3': debugSerializeParam(
            textController3?.text,
            ParamType.String,
            link:
                'https://app.flutterflow.io/project/krishi-b5r9t8?tab=uiBuilder&page=requestFeature',
            name: 'String',
            nullable: true,
          ),
          'switchValue': debugSerializeParam(
            switchValue,
            ParamType.bool,
            link:
                'https://app.flutterflow.io/project/krishi-b5r9t8?tab=uiBuilder&page=requestFeature',
            name: 'bool',
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
            'https://app.flutterflow.io/project/krishi-b5r9t8/tab=uiBuilder&page=requestFeature',
        searchReference:
            'reference=Og5yZXF1ZXN0RmVhdHVyZVABWg5yZXF1ZXN0RmVhdHVyZQ==',
        widgetClassName: 'requestFeature',
      );
}
