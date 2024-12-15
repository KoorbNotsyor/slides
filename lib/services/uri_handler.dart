import 'package:url_launcher/url_launcher.dart';

Future<void> _launch(theUri) async {
  if (!await launchUrl(theUri)) {
    throw Exception('Could not launch ${theUri}');
  }
}

// The built-in query builder will only work correctly for http/https.
// For anything else, the following should be used, otherwise you will have
// "+" instead of spaces:
String? encodeQueryParameters(Map<String, String> params) {
  return params.entries
      .map((MapEntry<String, String> e) =>
  '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      .join('&');
}

void sendEmail({required String toWhom, required String subject, String? body }){
  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: toWhom,
    query: encodeQueryParameters({
      'subject': subject,
      'body': body ?? ''
    }),
  );
  _launch(emailLaunchUri);
}

void openWebsite({required String webSite}){
  final Uri _url = Uri.parse(webSite);
  _launch(_url);
}