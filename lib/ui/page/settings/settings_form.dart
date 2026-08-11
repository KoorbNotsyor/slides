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

const double DIVIDER_HEIGHT = 8.0;

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  late AppState appState;
  late SlideshowInfo _showInfo;

  late GlobalKey<FormState> theFormKey;

  late AutovalidateMode autoValidate;

  String? _folder;

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
    //_showInfo.display('OUT');
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

  String? _checkMinValue(String? v , min) {
    int? value = int.tryParse(v ?? '0');
    value = value ?? 0;
    final bool ok = value >= min;
    if (ok) {
      return null;
    } else {
      return '[Minimum $min]';
    }
  }

  int _setMaxValue(int initialValue , min) {
    if (initialValue >= min) {
      return initialValue;
    } else {
      return min;
    }
  }

  @override
  void initState() {
    super.initState();

    appState = getIt.get<AppState>();
    _showInfo = SlideshowInfo.copy(appState.slideShowInfo);
    //_showInfo.display('IN');

    theFormKey = GlobalKey<FormState>();
    autoValidate = AutovalidateMode.disabled;   //disabled; // No validation on every change at first...
  }


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //_showInfo.display();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 28,
        title: const Text('',
                          style: TextStyle(
                            fontSize: 12,
                            height: 12
                          ),
        )
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        padding:const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
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
                      title: const Text('Slides Folder', style: TextStyle(fontWeight: FontWeight.bold)),
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

                    const Divider(height: DIVIDER_HEIGHT),

                    ListTile(
                      title: const Text('Media File Extensions', style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2),
                        child:
                        TextFormField(
                            enabled: true,
                            autofocus: false,
                            selectAllOnFocus: false,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            initialValue: _showInfo.mediaTypeExtensions.isNotEmpty ? _showInfo.mediaTypeExtensions : Constants.IMAGE_FILE_EXTENSIONS,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              //print('Validate file extensions value [$value]');
                              return null;
                            },
                            onChanged:  (value) {
                              setState(() {
                                //print ('BEFORE: [${_showInfo.mediaTypeExtensions}]');
                                //print('Changed file extensions value [$value]');
                                _showInfo.mediaTypeExtensions = value;
                              });
                            },
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: '',
                                floatingLabelBehavior: FloatingLabelBehavior.always
                            )
                        )
                      )
                    ),

                    const Divider(height: DIVIDER_HEIGHT),

                    ListTile(
                        title: const Text('Random varying intervals', style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text('from ${(_showInfo.minDuration.toDouble()/1000.0).toString()} (s) to ${(_showInfo.maxDuration.toDouble()/1000.0).toString()} (s)'),
                        trailing:Checkbox(
                          value: _showInfo.random,
                          onChanged: (value) {
                            setState(() {
                              _showInfo.random = value;
                            });
                          },
                        )
                    ),

                    Row(
                      children: [
                        Expanded(child:
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2),
                            child:
                            TextFormField(
                              enabled: _showInfo.random,
                              autofocus: false,
                              selectAllOnFocus: false,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              initialValue: '${_showInfo.minDuration}',
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                return _checkMinValue(value,Constants.MINIMUM_DURATION);
                              },
                              onChanged:  (value) {
                                setState(() {
                                  _showInfo.minDuration = int.tryParse(value) ?? 0;
                                });
                              },
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Random min (ms)',
                                  floatingLabelBehavior: FloatingLabelBehavior.always
                              )
                            )
                        ),
                        ),

                        Expanded(child:
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2),
                            child:
                            TextFormField(
                              enabled: _showInfo.random,
                              autofocus: false,
                              selectAllOnFocus: false,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              initialValue: '${_showInfo.maxDuration}',
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                return _checkMinValue(value,_showInfo.minDuration);
                              },
                              onChanged:  (value) {
                                setState(() {
                                  _showInfo.maxDuration = int.tryParse(value) ?? 0;
                                });
                              },
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Random max (ms)',
                                  floatingLabelBehavior: FloatingLabelBehavior.always
                              )
                            )
                        ),
                        )
                      ]
                    ),

                    const Divider(height: DIVIDER_HEIGHT),

                    ListTile(
                      title: const Text('Duration', style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('(ms): ${_showInfo.duration.toString()} - (s) ${(_showInfo.duration.toDouble()/1000.0).toString()}'),
                    ),

                    Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2),
                    child:
                    TextFormField(
                      enabled: !_showInfo.random,
                      autofocus: false,
                      selectAllOnFocus: false,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      initialValue: '${_showInfo.duration}',
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        return _checkMinValue(value,Constants.MINIMUM_DURATION);
                      },
                      onChanged:  (value) {
                        setState(() {
                          _showInfo.duration = int.tryParse(value) ?? 0;
                        });
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: '',
                          floatingLabelBehavior: FloatingLabelBehavior.always
                      )
                    )
                    ),

                    const Divider(height: DIVIDER_HEIGHT/2),

                    ListTile(
                        title: const Text('Shuffle slide show'),
                        trailing:Checkbox(
                          value: _showInfo.shuffle,
                          onChanged: (value) {
                            setState(() {
                              _showInfo.shuffle = value;
                            });
                          },
                        )
                    ),

                    const Divider(height: DIVIDER_HEIGHT/2),

                    ListTile(
                        title: const Text('Repeat slide show'),
                        trailing:Checkbox(
                          value: _showInfo.repeat,
                          onChanged: (value) {
                            setState(() {
                              _showInfo.repeat = value;
                            });
                          },
                        )
                    ),

                    const Divider(height: DIVIDER_HEIGHT/2),

                    ListTile(
                        title: const Text('Show label'),
                        trailing:Checkbox(
                          value: _showInfo.showLabel,
                          onChanged: (value) {
                            setState(() {
                              _showInfo.showLabel = value;
                            });
                          },
                        )
                    ),

                    const Divider(height: DIVIDER_HEIGHT/2),

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
              ],
            ),
          )
      )
    );
  }
}
