import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/auth/firebase_auth/auth_util.dart';

Future<void> openMap() async {
  final query = 'fertilizer suppliers near me';
  final url =
      Uri.parse('https://www.google.com/maps/search/?api=1&query=$query');

  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}

String latlontostring(
    LatLng latlon,
    bool islat,
    ) {
  return islat ? latlon.latitude.toString() : latlon.longitude.toString();
}
