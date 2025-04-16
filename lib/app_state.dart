import 'package:flutter/material.dart';
import '/backend/backend.dart';
import '/backend/api_requests/api_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'dart:convert';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() async {
    _instance = FFAppState._internal();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('Nvalue');
    await prefs.remove('Pvalue');
    await prefs.remove('Kvalue');
    await prefs.remove('ECvalue');
    await prefs.remove('moisturevalue');
  }

  Future initializePersistedState() async {
    final prefs = await SharedPreferences.getInstance();
    _Nvalue = prefs.getString('Nvalue') ?? '';
    _Pvalue = prefs.getString('Pvalue') ?? '';
    _Kvalue = prefs.getString('Kvalue') ?? '';
    _ECvalue = prefs.getString('ECvalue') ?? '';
    _moisturevalue = prefs.getString('moisturevalue') ?? '';
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  bool _sensorDataFetch = false;
  bool get sensorDataFetch => _sensorDataFetch;
  set sensorDataFetch(bool value) {
    _sensorDataFetch = value;

    debugLogAppState(this);
  }

  bool _aiSearchButton = false;
  bool get aiSearchButton => _aiSearchButton;
  set aiSearchButton(bool value) {
    _aiSearchButton = value;

    debugLogAppState(this);
  }

  bool _voiceTrigger = false;
  bool get voiceTrigger => _voiceTrigger;
  set voiceTrigger(bool value) {
    _voiceTrigger = value;

    debugLogAppState(this);
  }

  bool _aiSendButton = false;
  bool get aiSendButton => _aiSendButton;
  set aiSendButton(bool value) {
    _aiSendButton = value;

    debugLogAppState(this);
  }

  String _usermessage = '';
  String get usermessage => _usermessage;
  set usermessage(String value) {
    _usermessage = value;

    debugLogAppState(this);
  }

  late LoggableList<dynamic> _chatlist = LoggableList([]);
  List<dynamic> get chatlist =>
      _chatlist?..logger = () => debugLogAppState(this);
  set chatlist(List<dynamic> value) {
    if (value != null) {
      _chatlist = LoggableList(value);
    }

    debugLogAppState(this);
  }

  void addToChatlist(dynamic value) {
    chatlist.add(value);
  }

  void removeFromChatlist(dynamic value) {
    chatlist.remove(value);
  }

  void removeAtIndexFromChatlist(int index) {
    chatlist.removeAt(index);
  }

  void updateChatlistAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    chatlist[index] = updateFn(_chatlist[index]);
  }

  void insertAtIndexInChatlist(int index, dynamic value) {
    chatlist.insert(index, value);
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;

    debugLogAppState(this);
  }

  String _Nvalue = '';
  String get Nvalue => _Nvalue;
  set Nvalue(String value) {
    _Nvalue = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('Nvalue', value);
    });
    debugLogAppState(this);
  }

  String _Pvalue = '';
  String get Pvalue => _Pvalue;
  set Pvalue(String value) {
    _Pvalue = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('Pvalue', value);
    });
    debugLogAppState(this);
  }

  String _Kvalue = '';
  String get Kvalue => _Kvalue;
  set Kvalue(String value) {
    _Kvalue = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('Kvalue', value);
    });
    debugLogAppState(this);
  }

  String _ECvalue = '';
  String get ECvalue => _ECvalue;
  set ECvalue(String value) {
    _ECvalue = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('ECvalue', value);
    });
    debugLogAppState(this);
  }

  String _moisturevalue = '';
  String get moisturevalue => _moisturevalue;
  set moisturevalue(String value) {
    _moisturevalue = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('moisturevalue', value);
    });
    debugLogAppState(this);
  }

  Map<String, DebugDataField> toDebugSerializableMap() => {
        'sensorDataFetch': debugSerializeParam(
          sensorDataFetch,
          ParamType.bool,
          link:
              'https://app.flutterflow.io/project/krishi-b5r9t8?tab=appValues&appValuesTab=state',
          searchReference:
              'reference=CiMKGwoPc2Vuc29yRGF0YUZldGNoEgg4ang3amc4MHICCAV6AFoPc2Vuc29yRGF0YUZldGNo',
          name: 'bool',
          nullable: false,
        ),
        'aiSearchButton': debugSerializeParam(
          aiSearchButton,
          ParamType.bool,
          link:
              'https://app.flutterflow.io/project/krishi-b5r9t8?tab=appValues&appValuesTab=state',
          searchReference:
              'reference=CiIKGgoOYWlTZWFyY2hCdXR0b24SCGRucmw0cGRpcgIIBXoAWg5haVNlYXJjaEJ1dHRvbg==',
          name: 'bool',
          nullable: false,
        ),
        'voiceTrigger': debugSerializeParam(
          voiceTrigger,
          ParamType.bool,
          link:
              'https://app.flutterflow.io/project/krishi-b5r9t8?tab=appValues&appValuesTab=state',
          searchReference:
              'reference=CiAKGAoMdm9pY2VUcmlnZ2VyEgg1NWd6MzNxNXICCAV6AFoMdm9pY2VUcmlnZ2Vy',
          name: 'bool',
          nullable: false,
        ),
        'aiSendButton': debugSerializeParam(
          aiSendButton,
          ParamType.bool,
          link:
              'https://app.flutterflow.io/project/krishi-b5r9t8?tab=appValues&appValuesTab=state',
          searchReference:
              'reference=CiAKGAoMYWlTZW5kQnV0dG9uEghlNmFnbGpocHICCAV6AFoMYWlTZW5kQnV0dG9u',
          name: 'bool',
          nullable: false,
        ),
        'usermessage': debugSerializeParam(
          usermessage,
          ParamType.String,
          link:
              'https://app.flutterflow.io/project/krishi-b5r9t8?tab=appValues&appValuesTab=state',
          searchReference:
              'reference=Ch8KFwoLdXNlcm1lc3NhZ2USCGhjemo4ZGFvcgIIA3oAWgt1c2VybWVzc2FnZQ==',
          name: 'String',
          nullable: false,
        ),
        'chatlist': debugSerializeParam(
          chatlist,
          ParamType.JSON,
          isList: true,
          link:
              'https://app.flutterflow.io/project/krishi-b5r9t8?tab=appValues&appValuesTab=state',
          searchReference:
              'reference=Ch4KFAoIY2hhdGxpc3QSCDl6OGcyNG1icgQSAggJegBaCGNoYXRsaXN0',
          name: 'dynamic',
          nullable: false,
        ),
        'isLoading': debugSerializeParam(
          isLoading,
          ParamType.bool,
          link:
              'https://app.flutterflow.io/project/krishi-b5r9t8?tab=appValues&appValuesTab=state',
          searchReference:
              'reference=Ch0KFQoJaXNMb2FkaW5nEgh0Nmo3NDFxcXICCAV6AFoJaXNMb2FkaW5n',
          name: 'bool',
          nullable: false,
        ),
        'Nvalue': debugSerializeParam(
          Nvalue,
          ParamType.String,
          link:
              'https://app.flutterflow.io/project/krishi-b5r9t8?tab=appValues&appValuesTab=state',
          searchReference:
              'reference=ChoKEgoGTnZhbHVlEghhaXFzY2JxdHICCAN6AFoGTnZhbHVl',
          name: 'String',
          nullable: false,
        ),
        'Pvalue': debugSerializeParam(
          Pvalue,
          ParamType.String,
          link:
              'https://app.flutterflow.io/project/krishi-b5r9t8?tab=appValues&appValuesTab=state',
          searchReference:
              'reference=ChoKEgoGUHZhbHVlEgg3eW05aG8wZnICCAN6AFoGUHZhbHVl',
          name: 'String',
          nullable: false,
        ),
        'Kvalue': debugSerializeParam(
          Kvalue,
          ParamType.String,
          link:
              'https://app.flutterflow.io/project/krishi-b5r9t8?tab=appValues&appValuesTab=state',
          searchReference:
              'reference=ChoKEgoGS3ZhbHVlEgh1NDc4OGl1a3ICCAN6AFoGS3ZhbHVl',
          name: 'String',
          nullable: false,
        ),
        'ECvalue': debugSerializeParam(
          ECvalue,
          ParamType.String,
          link:
              'https://app.flutterflow.io/project/krishi-b5r9t8?tab=appValues&appValuesTab=state',
          searchReference:
              'reference=ChsKEwoHRUN2YWx1ZRIIajhpbDRydGRyAggDegBaB0VDdmFsdWU=',
          name: 'String',
          nullable: false,
        ),
        'moisturevalue': debugSerializeParam(
          moisturevalue,
          ParamType.String,
          link:
              'https://app.flutterflow.io/project/krishi-b5r9t8?tab=appValues&appValuesTab=state',
          searchReference:
              'reference=CiEKGQoNbW9pc3R1cmV2YWx1ZRIIa2hqejJuYjZyAggDegBaDW1vaXN0dXJldmFsdWU=',
          name: 'String',
          nullable: false,
        )
      };
}
