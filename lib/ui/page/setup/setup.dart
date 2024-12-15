import 'package:flutter/material.dart';
import 'package:slides/control/service_locator.dart';
import 'package:slides/control/app_state.dart';
import 'package:slides/ui/page/settings/settings_form.dart';
import 'package:slides/ui/widgets/common_widgets.dart';
import 'package:slides/ui/page/front/front.dart';


class Setup extends StatefulWidget {
  const Setup({super.key});

  @override
  State<Setup> createState() => _SetupState();
}

class _SetupState extends State<Setup> {

  _SetupState();

  final appState = getIt.get<AppState>();
  late final Future setupFuture;
  String messagePrecursor = '';

  @override
  void initState() {
    super.initState();
    setupFuture = appState.setup();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: setupFuture,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Waiting...
            return buildSpinnningCircle(context, 'Initialising...');
          } else {
            // NOT waiting...
            //print('[Setup] final snapshot C(${snapshot.connectionState}) E(${snapshot.hasError}) D(${snapshot.hasData})');
            if (snapshot.hasError) {
              return buildMessageWithOK(context, "$messagePrecursor Error: ${snapshot.error}");
            } else if (snapshot.hasData) {
              // Presumably setup OK...
              //print('[Setup] final snapshot data [${snapshot.data}]');
              appState.setAppState(AppStatus.initialised);
              if (appState.showInfo.value.hasFolderPath()){
                return Front();
              }
              else {
                return SettingsForm();
              }
             } else {
              // Done, no error, no data ?
              return buildMessageWithOK(context, "$messagePrecursor Error: possible network problem?");
            }
          }
        }
    );
  }

}