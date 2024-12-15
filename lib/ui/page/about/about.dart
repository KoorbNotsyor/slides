import 'package:flutter/material.dart';
import 'package:slides/control/service_locator.dart';
import 'package:slides/control/app_state.dart';
import 'package:slides/services/uri_handler.dart';
import 'package:slides/constants.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';

/*
  Markdown to theme mapping...
  -------------------------
  p: theme.textTheme.body1,
  h1 theme.textTheme.headline,
  h2: theme.textTheme.title,
  h3: theme.textTheme.subhead,
  h4: theme.textTheme.body2,
  h5: theme.textTheme.body2,
  h6: theme.textTheme.body2,

 */

const double GAPSIZE = 12;

class About extends StatelessWidget {

  late AppState appState;
  late String _appName;
  late String _appVersion;
  late String _appBuild;
  late String _appVersionMarkDown;

  About({super.key}) {

    appState = getIt.get<AppState>();
    _appName = appState.appName;
    _appVersion = appState.version;
    _appBuild = appState.buildNumber;

    _appVersionMarkDown = """
# App name: $_appName 
# Version: $_appVersion
# Build: $_appBuild       
 """;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:SingleChildScrollView(child: Column(
            children: [

              Container(
                height: 40,
                padding: EdgeInsets.all(8),
                child: Image.asset('assets/slides-icon.png'),
              ),

              Container(
                  child: Center(
                      child: ListView(
                          shrinkWrap: true,
                          children: [
                            const SizedBox(height: GAPSIZE),
                            Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black, //color of border
                                    width: 1, //width of border
                                  ),
                                ),
                                child: Container (
                                    height: 200,
                                    child: Markdown(
                                    styleSheet: MarkdownStyleSheet.fromTheme(
                                        ThemeData(
                                            textTheme: TextTheme(
                                                bodyMedium: TextStyle(
                                                    fontSize: 40.0,
                                                    color: Colors.black
                                                )
                                            )
                                        )
                                    ),
                                    data: _appVersionMarkDown
                                  )
                                )
                            ),
                            const SizedBox(height: GAPSIZE),
                            Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black, //color of border
                                    width: 1, //width of border
                                  ),
                                ),
                                child: Text(
                                    'This is a first venture into using Flutter to develop multi-platform desktop apps.\n'
                                        '\n'
                                        'Why do slideshow apps always go full-screen?\n'
                                        '\n',
                                    style: Theme.of(context).textTheme.bodyMedium
                                )
                            ),
                            const SizedBox(height: GAPSIZE),
                            ListTile(
                              leading: const Icon(Icons.email_outlined),
                              title: const Text('Send us an email...'),
                              onTap: () {
                                sendEmail(toWhom: appState.aboutInfo.getValue(Constants.ABOUT_EMAIL_TO),
                                    subject: appState.aboutInfo.getValue(Constants.ABOUT_EMAIL_SUBJECT),
                                    body: appState.aboutInfo.getValue(Constants.ABOUT_EMAIL_BODY)
                                );
                              },
                            ),
                            const SizedBox(height: GAPSIZE),
                            ListTile(
                              leading: const Icon(Icons.web),
                              title: Text(appState.aboutInfo.getValue(Constants.ABOUT_WEBSITE_INTRO)),
                              onTap: () {
                                openWebsite(webSite: appState.aboutInfo.getValue(Constants.ABOUT_WEBSITE));
                              },
                            ),
                            const SizedBox(height: GAPSIZE),
                            ListTile(
                              leading: const Icon(Icons.coffee),
                              title: Text(
                                  appState.aboutInfo.getValue(Constants.ABOUT_COFFEE_TEXT),
                                  style: GoogleFonts.pacifico(
                                      color: Colors.black,
                                      backgroundColor: Colors.amber
                                  )
                              ),
                              onTap: () {
                                openWebsite(webSite: appState.aboutInfo.getValue(Constants.ABOUT_COFFEE));
                              },
                            ),
                          ]
                      )
                  )
              ),

              Container(
                height: 80,
                padding: EdgeInsets.all(8),
                child: ElevatedButton(
                    child: Text(
                      'OK',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        //fontWeight: FontWeight.w600
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context,);
                    }
                ),
              )

            ]
        )
    ));
  }

}
