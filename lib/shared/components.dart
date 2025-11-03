import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

// navigation widgets
void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );
void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      (Route<dynamic> route) => false,
    );

// toast
void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: ToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates { SUCCESS, ERROR, WARNING }

Color ToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

//
Widget button1(
  context, {
  double width = double.infinity,
  Color color = Colors.blue,
  required Function function,
  required String text,
}) =>
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: color,
      ),
      width: MediaQuery.of(context).size.width * 0.6,
      child: TextButton(
        onPressed: () {
          function();
        },
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
    );

// form fields
Widget formField00({
  required TextEditingController controller,
  required TextInputType type,
  Function? onsubmit,
  Function? onchanged,
  Function? ontap,
  var errorText,
  required Function validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  bool ispass = false,
  Function? suffixpressed,
  String? initialValue,
  bool? readOnly,
  int? maxLines = 1,
  int? maxLength,
}) =>
    TextFormField(
      maxLength: maxLength,
      maxLines: maxLines,
      cursorColor: Colors.blue,
      decoration: InputDecoration(
        errorText: errorText,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue, width: 2.0),
          borderRadius: BorderRadius.circular(5.0),
        ),
        labelText: label,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(prefix),
        suffixIcon: IconButton(
            onPressed: () {
              suffixpressed!();
            },
            icon: Icon(suffix)),
      ),
      onFieldSubmitted: (value) {
        if (onsubmit != null) {
          onsubmit(value);
        }
      },
      initialValue: initialValue,
      onChanged: (value) {
        if (onchanged != null) {
          onchanged(value);
        }
      },
      keyboardType: type,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(
            RegExp(r'[a-zA-Z]')), // Allow only digits
      ],
      obscureText: ispass,
      controller: controller,
      onTap: () {
        if (ontap != null) {
          ontap();
        }
      },
      validator: (value) {
        return validate(value);
      },
    );
Widget formField0({
  required TextEditingController controller,
  required TextInputType type,
  Function? onsubmit,
  Function? onchanged,
  Function? ontap,
  var errorText,
  required Function validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  bool ispass = false,
  Function? suffixpressed,
  String? initialValue,
  bool? readOnly,
  int? maxLines = 1,
  int? maxLength,
}) =>
    TextFormField(
      maxLength: maxLength,
      maxLines: maxLines,
      cursorColor: Colors.blue,
      decoration: InputDecoration(
        errorText: errorText,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue, width: 2.0),
          borderRadius: BorderRadius.circular(5.0),
        ),
        labelText: label,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(prefix),
        suffixIcon: IconButton(
            onPressed: () {
              suffixpressed!();
            },
            icon: Icon(suffix)),
      ),
      onFieldSubmitted: (value) {
        if (onsubmit != null) {
          onsubmit(value);
        }
      },
      initialValue: initialValue,
      onChanged: (value) {
        if (onchanged != null) {
          onchanged(value);
        }
      },
      keyboardType: type,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly, // Allow only digits
      ],
      obscureText: ispass,
      controller: controller,
      onTap: () {
        if (ontap != null) {
          ontap();
        }
      },
      validator: (value) {
        return validate(value);
      },
    );
Widget formField1({
  required TextEditingController controller,
  required TextInputType type,
  Function? onsubmit,
  Function? onchanged,
  Function? ontap,
  var errorText,
  required Function validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  bool ispass = false,
  Function? suffixpressed,
  String? initialValue,
  bool? readOnly,
  int? maxLines = 1,
  int? maxLength,
}) =>
    TextFormField(
      maxLength: maxLength,
      maxLines: maxLines,
      cursorColor: Colors.blue,
      decoration: InputDecoration(
        errorText: errorText,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue, width: 2.0),
          borderRadius: BorderRadius.circular(5.0),
        ),
        labelText: label,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(prefix),
        suffixIcon: IconButton(
            onPressed: () {
              suffixpressed!();
            },
            icon: Icon(suffix)),
      ),
      onFieldSubmitted: (value) {
        if (onsubmit != null) {
          onsubmit(value);
        }
      },
      initialValue: initialValue,
      onChanged: (value) {
        if (onchanged != null) {
          onchanged(value);
        }
      },
      keyboardType: type,
      obscureText: ispass,
      controller: controller,
      onTap: () {
        if (ontap != null) {
          ontap();
        }
      },
      validator: (value) {
        return validate(value);
      },
    );
Widget formField2({
  required TextEditingController controller,
  required TextInputType type,
  Function? onsubmit,
  Function? onchanged,
  Function? ontap,
  required Function validate,
  required String label,
  bool ispass = false,
  Function? suffixpressed,
  int? maxLines,
  int? maxLength,
}) =>
    TextFormField(
      maxLength: maxLength,
      maxLines: maxLines,
      cursorColor: Colors.blue,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue, width: 2.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1),
          borderRadius: BorderRadius.circular(10.0),
        ),
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onFieldSubmitted: (value) {
        if (onsubmit != null) {
          onsubmit(value);
        }
      },
      onChanged: (value) {
        if (onchanged != null) {
          onchanged(value);
        }
      },
      keyboardType: type,
      obscureText: ispass,
      controller: controller,
      onTap: () {
        if (ontap != null) {
          ontap();
        }
      },
      validator: (value) {
        return validate(value);
      },
    );
Widget button2({
  double width = double.infinity,
  Color color = Colors.blue,
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      color: color,
      child: TextButton(
        onPressed: () {
          function();
        },
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
    );
