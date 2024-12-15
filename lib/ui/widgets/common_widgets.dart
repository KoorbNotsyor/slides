import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';

InputDecoration inputDecorator({
  InputBorder? enabledBorder,
  InputBorder? border,
  Color? fillColor,
  bool? filled,
  Widget? prefixIcon,
  String? hintText,
  String? labelText,
  Widget? suffixIcon,
}) =>
    InputDecoration(
        enabledBorder: enabledBorder ??
            OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey, width: 2.0)),
        border: border ?? OutlineInputBorder(borderSide: BorderSide()),
        fillColor: fillColor ?? Colors.white,
        filled: filled ?? true,
        prefixIcon: prefixIcon,
        hintText: hintText,
        labelText: labelText,
        suffixIcon: suffixIcon
    );

Widget buildLogo() {
  return Padding(
    padding: const EdgeInsets.only(top: 10),
    child: Image.asset(
      "assets/images/tb.jpg",
      height: 100,
      width: 100,
    ),
  );
}

Widget buildIntroText(String text) {
  return Column(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 30),
        child: Text(
          text,
          style: TextStyle(
              color: Colors.black54,
              fontSize: 18.0,
              fontWeight: FontWeight.bold),
        ),
      ),
    ],
  );
}

Widget buildSpinnningCircle(BuildContext context, String message) {
  return Scaffold(
      body: Center(
          child: Padding(padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
            child: Column (
              children: [
                const SizedBox(height: 48),
                RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(
                          text: message,
                          style: TextStyle(
                            color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold,),
                        ),
                      ],
                    )
                ),
                const SizedBox(height: 48),
                CircularProgressIndicator(),
                const SizedBox(height: 48),
               ],
            ),
          )
      )
  );
}

Widget buildMessageWithOK(BuildContext context, String message) {
  return Scaffold(
    body: Center(
    child: Padding(padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
      child: Column (
        children: [
          const SizedBox(height: 48),
          RichText(
            text: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: <TextSpan>[
              TextSpan(
                text: message,
                style: TextStyle(
                    color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold,),
                ),
              ],
            )
          ),
          const SizedBox(height: 48),
          ElevatedButton(
              child: Text(
                'OK',
                style: TextStyle(
                    color: Colors.black, fontSize: 24, fontWeight: FontWeight.w600),
              ),
              onPressed: () {
                Navigator.pop(context,);
              },
            ),
          ],
        ),
      )
    )
  );
}

Widget buildHomeButton(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: 10.0),
    child: Align(
      alignment: Alignment.centerRight,
      child: IconButton(
          icon: Icon(Icons.home),
          onPressed: () {
            Navigator.pushNamed(context,'/');
          }
       ),
    ),
  );
}

Widget IntegerBoxField(
{
    String? labelText,
    int initialVale = 0,
    int minValue = 0,
    int maxValue = 0,
    TextEditingController? tec,
    FocusNode? fn,
    required ValueChanged<int> onChanged,
    String? Function(String?)? validationFunction
}
    ) {
  tec?.text = initialVale.toString();
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
    child: TextFormField(
      autofocus: false,
      controller: tec,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      textInputAction: TextInputAction.next,
      validator: validationFunction,
      decoration: new InputDecoration(
            border: OutlineInputBorder(),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always
      ),
      focusNode: fn,
      onChanged:  (value) {
        onChanged(int.tryParse(value) ?? 0);
      }
     )
  );
}