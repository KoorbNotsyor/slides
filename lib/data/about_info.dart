import 'package:slides/constants.dart';

// This info is READ-ONLY with defaults if no such info in preferences...

class AboutInfo {

  final Map <String, String> _values = {
    Constants.ABOUT_EMAIL_TO : "towhom@wherever.url",
    Constants.ABOUT_EMAIL_SUBJECT : "Contact us - say what you think!",
    Constants.ABOUT_EMAIL_BODY : "< BODY >",
    Constants.ABOUT_WEBSITE_INTRO : "Visit...",
    Constants.ABOUT_WEBSITE : "",
    Constants.ABOUT_COFFEE_TEXT : "Please, please buy me a coffee...",
    Constants.ABOUT_COFFEE : "https://buymeacoffee.com"
  };

  AboutInfo();

  fromJson(Map<String, dynamic> json) {

    if (json.containsKey(Constants.ABOUT_EMAIL_TO)) {
      _values[Constants.ABOUT_EMAIL_TO] = json[Constants.ABOUT_EMAIL_TO];
    }

    if (json.containsKey(Constants.ABOUT_EMAIL_SUBJECT)) {
      _values[Constants.ABOUT_EMAIL_SUBJECT] = json[Constants.ABOUT_EMAIL_SUBJECT];
    }

    if (json.containsKey(Constants.ABOUT_EMAIL_BODY)) {
      _values[Constants.ABOUT_EMAIL_BODY] = json[Constants.ABOUT_EMAIL_BODY];
    }

    if (json.containsKey(Constants.ABOUT_WEBSITE_INTRO)) {
      _values[Constants.ABOUT_WEBSITE_INTRO] = json[Constants.ABOUT_WEBSITE_INTRO];
    }

    if (json.containsKey(Constants.ABOUT_WEBSITE)) {
      _values[Constants.ABOUT_WEBSITE] = json[Constants.ABOUT_WEBSITE];
    }

    if (json.containsKey(Constants.ABOUT_COFFEE_TEXT)) {
      _values[Constants.ABOUT_COFFEE_TEXT] = json[Constants.ABOUT_COFFEE_TEXT];
    }

    if (json.containsKey(Constants.ABOUT_COFFEE)) {
      _values[Constants.ABOUT_COFFEE] = json[Constants.ABOUT_COFFEE];
    }

  }

  String getValue(String key) {
    String returnValue = '';
    if (_values.containsKey(key)) {
      returnValue = _values[key] ?? '';
    }
    return returnValue;
  }
}