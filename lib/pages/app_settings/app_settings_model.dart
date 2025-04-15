import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'app_settings_widget.dart' show AppSettingsWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AppSettingsModel extends FlutterFlowModel<AppSettingsWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for Switch widget.
  bool? _switchValue1;
  set switchValue1(bool? value) {
    _switchValue1 = value;
    debugLogWidgetClass(this);
  }

  bool? get switchValue1 => _switchValue1;

  // State field(s) for Switch widget.
  bool? _switchValue2;
  set switchValue2(bool? value) {
    _switchValue2 = value;
    debugLogWidgetClass(this);
  }

  bool? get switchValue2 => _switchValue2;

  // State field(s) for Switch widget.
  bool? _switchValue3;
  set switchValue3(bool? value) {
    _switchValue3 = value;
    debugLogWidgetClass(this);
  }

  bool? get switchValue3 => _switchValue3;

  final Map<String, DebugDataField> debugGeneratorVariables = {};
  final Map<String, DebugDataField> debugBackendQueries = {};
  final Map<String, FlutterFlowModel> widgetBuilderComponents = {};
  @override
  void initState(BuildContext context) {
    debugLogWidgetClass(this);
  }

  @override
  void dispose() {}

  @override
  WidgetClassDebugData toWidgetClassDebugData() => WidgetClassDebugData(
        widgetStates: {
          'switchValue1': debugSerializeParam(
            switchValue1,
            ParamType.bool,
            link:
                'https://app.flutterflow.io/project/krishi-b5r9t8?tab=uiBuilder&page=appSettings',
            name: 'bool',
            nullable: true,
          ),
          'switchValue2': debugSerializeParam(
            switchValue2,
            ParamType.bool,
            link:
                'https://app.flutterflow.io/project/krishi-b5r9t8?tab=uiBuilder&page=appSettings',
            name: 'bool',
            nullable: true,
          ),
          'switchValue3': debugSerializeParam(
            switchValue3,
            ParamType.bool,
            link:
                'https://app.flutterflow.io/project/krishi-b5r9t8?tab=uiBuilder&page=appSettings',
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
            'https://app.flutterflow.io/project/krishi-b5r9t8/tab=uiBuilder&page=appSettings',
        searchReference: 'reference=OgthcHBTZXR0aW5nc1ABWgthcHBTZXR0aW5ncw==',
        widgetClassName: 'appSettings',
      );
}
