import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/modul/boarding/model.dart';

class DefaultTextFormField extends StatelessWidget {
  final String labelText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double radius;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final GestureTapCallback? onTap;
  final bool obscureText;
  final TextInputType? keyboardType;
  final VoidCallback? onEditingComplete;
  final bool readOnly;

  const DefaultTextFormField({
    required this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.radius = 10.0,
    this.controller,
    this.validator,
    this.onTap,
    this.obscureText = false,
    this.keyboardType,
    this.onEditingComplete,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      controller: controller,
      validator: validator,
      onTap: onTap,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: prefixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        suffixIcon: suffixIcon,
      ),
      onEditingComplete: onEditingComplete,
    );
  }
}

class DefaultButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const DefaultButton({
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Colors.blue,
      minWidth: double.infinity,
      height: 45.0,
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

Widget boardingItem(Model model) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage(
              '${model.url}',
            ),
          ),
        ),
        Text(
          '${model.title}',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 15.0,
        ),
        Text(
          '${model.body}',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );

Color colorFun(ToastState toastState) {
  switch (toastState) {
    case ToastState.SUCCESS:
      return Colors.green;
    case ToastState.WARRING:
      return Colors.amber;
    case ToastState.ERROR:
      return Colors.red;
  }
}

void showToastComponent({required String msg, ToastState? toastState}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.SNACKBAR,
      timeInSecForIosWeb: 5,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}

enum ToastState { SUCCESS, WARRING, ERROR }

void navigateToAndFinish({required context, required widget}) =>
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => widget), (route) => false);

void navigateTo({required context, required widget}) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}
