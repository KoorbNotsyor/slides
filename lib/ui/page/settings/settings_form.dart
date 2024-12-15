import 'package:flutter/material.dart';
import 'package:slides/stringx.dart';
import 'package:flutter/services.dart';
import 'package:slides/control/service_locator.dart';
import 'package:slides/control/app_state.dart';
import 'package:file_picker/file_picker.dart';
import 'package:slides/data/slideshow_info.dart';
import 'package:slides/ui/widgets/common_widgets.dart';
import 'package:slides/constants.dart';
import 'package:slides/ui/app/drawer.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  late AppState appState;
  late SlideshowInfo _showInfo;

  late GlobalKey<FormState> theFormKey;

  late AutovalidateMode autoValidate;
  late TextEditingController? _durationTextController;
  late FocusNode _durationTextFocusNode;
  late TextEditingController? _durationMinTextController;
  late FocusNode _durationMinTextFocusNode;
  late TextEditingController? _durationMaxTextController;
  late FocusNode _durationMaxTextFocusNode;

  String? _folder;
  bool _repeat = false;
  int _duration = 0;

  navigateTo(BuildContext context, String route) {
     Navigator.pushNamed(context,route);
  }

  navigateOut(BuildContext context) {
    Navigator.pop(context); // Close the settings form...
    // if there is a slide show ready (or already there & cancel) go
    // else no...
    if (appState.slideShowInfo.hasFolderPath()) {
      navigateTo(context, '/front');
    } else {
      navigateTo(context, '/settings');
    }
  }

  void _cancelForm(BuildContext context) {
    // nothing to do....
    navigateOut(context);
  }

  void _processForm(BuildContext context) {
    appState.slideShowInfo = _showInfo;
    appState.saveSlideShowDetails();
    navigateOut(context);
  }

  String? _checkIntegerRange(String? v, min, max) {
    //print('__checkIntegerRange($value , $min , $max');
    bool ok = v?.inRange(minValue: min , maxValue: max) ?? false;
    if (ok) {
      return null;
    } else {
      return '[$min,$max]';
    };
  }

  int _setSliderMaxValue() {
    if (_showInfo.maxDuration < _showInfo.minDuration) {
      return _showInfo.minDuration;
    }
    return _showInfo.maxDuration;
  }

  int _setSliderMinValue() {
    if (_showInfo.minDuration > _showInfo.maxDuration) {
      return _showInfo.maxDuration;
    }
    return _showInfo.minDuration;
  }

  void _checkSliderDurationValue() {
    if (_showInfo.duration < _showInfo.minDuration) {
      _showInfo.duration = _showInfo.minDuration;
    }
    else if (_showInfo.duration > _showInfo.maxDuration) {
      _showInfo.duration = _showInfo.maxDuration;
    }
  }

  @override
  void initState() {
    super.initState();

    appState = getIt.get<AppState>();
    _showInfo = SlideshowInfo.copy(appState.slideShowInfo);

    theFormKey = GlobalKey<FormState>();
    autoValidate = AutovalidateMode.onUserInteraction;   //disabled; // No validation on every change at first...
    _durationTextController = TextEditingController();
    _durationTextFocusNode = FocusNode();
    _durationMinTextController = TextEditingController();
    _durationMinTextFocusNode = FocusNode();
    _durationMaxTextController = TextEditingController();
    _durationMaxTextFocusNode = FocusNode();

  }


  @override
  void dispose() {
    _durationMaxTextFocusNode.dispose();
    _durationMaxTextController?.dispose();
    _durationMinTextFocusNode.dispose();
    _durationMinTextController?.dispose();
    _durationTextFocusNode.dispose();
    _durationTextController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //_showInfo.display();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Slides'),
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        padding:EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Form(
            key: theFormKey,
            autovalidateMode: autoValidate,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Card(
                    elevation: 8,
                    child: Column(
                        children: <Widget>[

                          ListTile(
                            leading: const Icon(Icons.folder),
                            title: Text('Slides Folder'),
                            subtitle: Text(_showInfo.folderPath)
                          ),
                          ListTile(
                              leading: const Icon(Icons.launch),
                              title: ElevatedButton(
                                onPressed: () async {
                                  _folder = await FilePicker.platform.getDirectoryPath();
                                  if (_folder == null) {
                                    //print("No folder selected");
                                  } else {
                                    // Check if any images in folder???
                                    setState(() {
                                      _showInfo.folderPath = _folder;
                                      _showInfo.newFolder = true;
                                      //print(_folder);
                                    });
                                  }
                                },
                                child: const Text("Select slide folder..."),
                              ),
                          ),

                          const Divider(
                            height: 12.0,
                          ),

                          ListTile(
                            leading: const Icon(Icons.launch),
                            title: ElevatedButton(
                              onPressed: () async {
                                setState(() {
                                  _showInfo.folderPath = "";
                                  _showInfo.newFolder = true;
                                  //print(_folder);
                                });
                              },
                              child: const Text("Clear slide folder..."),
                            ),
                          ),

                          const Divider(
                            height: 12.0,
                          ),

                          Row(
                            children: [
                              Text(
                               'Interval (ms): ${_showInfo.duration.toString()} - (s) ${(_showInfo.duration.toDouble()/1000.0).toString()}',
                               style: TextStyle(fontWeight: FontWeight.bold)
                              )
                            ]
                          ),

                          const Divider(
                            height: 12.0,
                          ),

                          Row(
                            children: [
                              Expanded(child:
                              Container(
                                height: 80,
                                child:
                                  IntegerBoxField(
                                    labelText: "min",
                                    initialVale: _showInfo.minDuration,
                                    minValue: Constants.MINIMUM_DURATION,
                                    maxValue: Constants.MAXIMUM_DURATION,
                                    tec: _durationMinTextController,
                                    fn: _durationMinTextFocusNode,
                                    validationFunction:(value) {
                                      return _checkIntegerRange(value,Constants.MINIMUM_DURATION,Constants.MAXIMUM_DURATION);
                                    },
                                    onChanged: (value) {
                                      setState(() {
                                      _showInfo.minDuration = value;
                                      _checkSliderDurationValue();
                                      });
                                    }
                                  )
                                )
                              ),
                              Expanded(child:
                              Container(
                                height:80,
                                child:
                                  IntegerBoxField(
                                    labelText: "max",
                                    initialVale: _showInfo.maxDuration,
                                    minValue: Constants.MINIMUM_DURATION,
                                    maxValue: Constants.MAXIMUM_DURATION,
                                    tec: _durationMaxTextController,
                                    fn: _durationMaxTextFocusNode,
                                    validationFunction:(value) {
                                      return _checkIntegerRange(value,Constants.MINIMUM_DURATION,Constants.MAXIMUM_DURATION);
                                    },
                                    onChanged: (value) {
                                      setState(() {
                                        _showInfo.maxDuration = value;
                                        _checkSliderDurationValue();
                                      });
                                    }
                                  )
                                )
                              )
                            ]
                          ),

                          Slider(
                            min: _setSliderMinValue().toDouble(),
                            max: _setSliderMaxValue().toDouble(),
                            value: _showInfo.duration.toDouble(),
                            divisions: 10,
                            onChanged: (value) {
                              setState(() {
                                _showInfo.duration = value.round();
                              });
                            },
                          ),

                          const Divider(
                            height: 12.0,
                          ),

                          ListTile(
                              title: Text('Random varying intervals'),
                              trailing:Checkbox(
                                value: _showInfo.random,
                                onChanged: (value) {
                                  setState(() {
                                    _showInfo.random = value;
                                  });
                                },
                              )
                          ),

                          const Divider(
                            height: 4.0,
                          ),

                          ListTile(
                              title: Text('Repeat slide show'),
                              trailing:Checkbox(
                                value: _showInfo.repeat,
                                onChanged: (value) {
                                  setState(() {
                                    _showInfo.repeat = value;
                                  });
                                },
                              )
                          ),

                          const Divider(
                            height: 4.0,
                          ),

                          ListTile(
                              title: Text('Show label'),
                              trailing:Checkbox(
                                value: _showInfo.showLabel,
                                onChanged: (value) {
                                  setState(() {
                                    _showInfo.showLabel = value;
                                  });
                                },
                              )
                          ),

                          Row(
                            children: [

                              ElevatedButton(
                                onPressed: () async {
                                  _cancelForm(context);
                                },
                                child: const Text("Cancel"),
                              ),

                              ElevatedButton(
                                onPressed: () async {
                                  if (theFormKey.currentState!.validate()) {
                                    // Form is valid...
                                    //ScaffoldMessenger.of(context).showSnackBar(
                                    //  const SnackBar(content: Text('Processing Data')),
                                    //);
                                    _processForm(context);
                                   }
                                },
                                child: const Text("Save"),
                              ),

                            ]
                          )

                        ]
                    )
                ),
                //buildRegisterButton(context),
              ],
            ),
          )
      )
    );
  }
}
