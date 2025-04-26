import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class WeatherCall {
  static Future<ApiCallResponse> call({
    String? lat = '',
    String? lon = '',
    String? exclude = 'minutely, hourly',
    String? apikey = 'bcd2f836d8f6ce1f0612672598449ee2',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'weather',
      apiUrl:
          'https://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${lon}&exclude=${exclude}&units=metric&APPID=${apikey}',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: true,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static double? currentTemp(dynamic response) =>
      castToType<double>(getJsonField(
        response,
        r'''$.main.temp''',
      ));
  static String? weatherDescription(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.weather[:].description''',
      ));
  static String? weatherIcon(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.weather[:].icon''',
      ));
  static String? weatherdescription(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.weather[:].main''',
      ));
  static int? humiditylevel(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.main.humidity''',
      ));
  static String? city(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.name''',
      ));
}

class UltronCall {
  static Future<ApiCallResponse> call({
    String? input = '',
  }) async {
    final ffApiRequestBody = '''
{
  "model": "deepseek/deepseek-r1:free",
  "messages": [
    {
      "role": "user",
      "content": "${escapeStringForJson(input)}"
    }
  ]
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Ultron',
      apiUrl: 'https://openrouter.ai/api/v1/chat/completions',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer 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',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: true,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? reasoning(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.choices[:].message.reasoning''',
      ));
  static String? reply(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.choices[:].message.content''',
      ));
}

class PaulCall {
  static Future<ApiCallResponse> call({
    String? input = '',
  }) async {
    final ffApiRequestBody = '''
{
  "systemInstruction": {
    "parts": [
      {
        "text": "You are a agriculture and farming expert from India. Provide answers in a beginner friendly simple language. Use examples in explaining things, if possible. If soil nutrients like NPK, Ph, soil moisture are entered as prompt, assess them and suggest ideal values, and most importantly give suggestions to reach from current reading to ideal readings. These suggestion can be in term of fertilizer(type, amount).Respond with proper headings and use bullet points. Respond in plain text without using Markdown formatting (e.g., no **bold**, *italics*, or # headings)."
      }
    ]
  },
  "contents": [
    {
      "parts": [
        {
          "text": "${escapeStringForJson(input)}"
        }
      ]
    }
  ],
  "generationConfig": {
    "temperature": 0.7,
    "topK": 40,
    "topP": 0.95,
    "maxOutputTokens": 1024
  }
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'paul',
      apiUrl:
          'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=AIzaSyDzyWLzPjSE_wcayC75XX1pJ2SQxGudI1Q',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: true,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? answer(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.candidates[:].content.parts[:].text''',
      ));
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  if (item is DocumentReference) {
    return item.path;
  }
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}

String? escapeStringForJson(String? input) {
  if (input == null) {
    return null;
  }
  return input
      .replaceAll('\\', '\\\\')
      .replaceAll('"', '\\"')
      .replaceAll('\n', '\\n')
      .replaceAll('\t', '\\t');
}
