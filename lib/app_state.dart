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

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  bool _sensorDataFetch = false;
  bool get sensorDataFetch => _sensorDataFetch;
  set sensorDataFetch(bool value) {
    _sensorDataFetch = value;
  }

  bool _aiSearchButton = false;
  bool get aiSearchButton => _aiSearchButton;
  set aiSearchButton(bool value) {
    _aiSearchButton = value;
  }

  bool _voiceTrigger = false;
  bool get voiceTrigger => _voiceTrigger;
  set voiceTrigger(bool value) {
    _voiceTrigger = value;
  }

  bool _aiSendButton = false;
  bool get aiSendButton => _aiSendButton;
  set aiSendButton(bool value) {
    _aiSendButton = value;
  }

  String _usermessage = '';
  String get usermessage => _usermessage;
  set usermessage(String value) {
    _usermessage = value;
  }

  List<dynamic> _chatlist = [];
  List<dynamic> get chatlist => _chatlist;
  set chatlist(List<dynamic> value) {
    _chatlist = value;
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
  }

  String _Nvalue = '';
  String get Nvalue => _Nvalue;
  set Nvalue(String value) {
    _Nvalue = value;
  }

  String _Pvalue = '';
  String get Pvalue => _Pvalue;
  set Pvalue(String value) {
    _Pvalue = value;
  }

  String _Kvalue = '';
  String get Kvalue => _Kvalue;
  set Kvalue(String value) {
    _Kvalue = value;
  }

  String _ECvalue = '';
  String get ECvalue => _ECvalue;
  set ECvalue(String value) {
    _ECvalue = value;
  }

  String _moisturevalue = '';
  String get moisturevalue => _moisturevalue;
  set moisturevalue(String value) {
    _moisturevalue = value;
  }
}
