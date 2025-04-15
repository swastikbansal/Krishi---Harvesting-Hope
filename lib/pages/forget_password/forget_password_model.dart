import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'forget_password_widget.dart' show ForgetPasswordWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ForgetPasswordModel extends FlutterFlowModel<ForgetPasswordWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for resetemailAddress widget.
  FocusNode? resetemailAddressFocusNode;
  TextEditingController? resetemailAddressTextController;
  String? Function(BuildContext, String?)?
      resetemailAddressTextControllerValidator;

  final Map<String, DebugDataField> debugGeneratorVariables = {};
  final Map<String, DebugDataField> debugBackendQueries = {};
  final Map<String, FlutterFlowModel> widgetBuilderComponents = {};
  @override
  void initState(BuildContext context) {
    debugLogWidgetClass(this);
  }

  @override
  void dispose() {
    resetemailAddressFocusNode?.dispose();
    resetemailAddressTextController?.dispose();
  }

  @override
  WidgetClassDebugData toWidgetClassDebugData() => WidgetClassDebugData(
        widgetStates: {
          'resetemailAddressText': debugSerializeParam(
            resetemailAddressTextController?.text,
            ParamType.String,
            link:
                'https://app.flutterflow.io/project/krishi-b5r9t8?tab=uiBuilder&page=forgetPassword',
            name: 'String',
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
            'https://app.flutterflow.io/project/krishi-b5r9t8/tab=uiBuilder&page=forgetPassword',
        searchReference:
            'reference=Og5mb3JnZXRQYXNzd29yZFABWg5mb3JnZXRQYXNzd29yZA==',
        widgetClassName: 'forgetPassword',
      );
}
