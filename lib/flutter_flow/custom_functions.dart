import 'package:url_launcher/url_launcher.dart';

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
