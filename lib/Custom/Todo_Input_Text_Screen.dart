import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:taskplus/Theme/Color_plate.dart';
import 'package:taskplus/Theme/Utils/Dimensions.dart';
import 'package:taskplus/Theme/Utils/text_theme.dart';

class TextInputField extends StatefulWidget {
  final String label;
  final String hintText;
  final IconData? prefixIcon;
  final Icon? suffixIcon;
  final bool isPassword;
  final bool showBorder;
  final bool obscureText;
  final int maxLength;
  final int maxLines;
  final bool isPhone;
  final bool isEmail;
  final double radius;
  final FocusNode? focusNode;
  final bool isEnable;
  final TextInputType inputType;
  final TextEditingController controller;
  const TextInputField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.prefixIcon,
    this.isPassword = false,
    this.showBorder = true,
    required this.inputType,
    this.suffixIcon,
    this.obscureText = false,
    this.maxLength = 10,
    this.isPhone = false,
    this.isEmail = false,
    this.radius = 45.00,
    this.isEnable = true,
    this.maxLines = 1,
    this.focusNode,
  });

  @override
  State<TextInputField> createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  bool _isPhoneValid(String value) {
    final RegExp phoneRegex = RegExp(
      r'^[0-9]{10}$',
    );

    return phoneRegex.hasMatch(value);
  }

  bool _isEmailValid(String value) {
    final RegExp emailRegex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
    );
    return emailRegex.hasMatch(value);
  }

  bool _obscureText = true;
  String? _validatePassword(String? value) {
    if (!widget.isPassword) {
      return null;
    }

    // if (value == null) {
    //   return 'Password is required';
    // }

    if (value == null || value.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    final RegExp regex = RegExp(
      r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@#$%^&+=!])(?![.\n])(?=.*[a-z]).*$',
    );

    if (!regex.hasMatch(value)) {
      return 'Password must be alphanumeric with at least one letter, one number, and one special character';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeThirtyFive),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: titleRegular,
          ),
          const SizedBox(height: 5),
          TextFormField(
            cursorColor: ColorPalate.DARK_PRIMERY,
            keyboardType: widget.inputType,
            focusNode: widget.focusNode,
            obscureText: widget.isPassword ? _obscureText : widget.obscureText,
            maxLength: widget.isPhone ? widget.maxLength : null,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'This field is required';
              }

              if (widget.inputType == TextInputType.phone) {
                return _isPhoneValid(value) ? null : 'Invalid phone number';
              }

              if (widget.inputType == TextInputType.emailAddress) {
                return _isEmailValid(value) ? null : 'Invalid email address';
              }

              if (widget.inputType == TextInputType.visiblePassword) {
                return _validatePassword(value);
              }

              return null;
            },

            // (value) {
            //   return widget.isPassword ? _validatePassword(value) : null;
            // },
            enabled: widget.isEnable,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10),
              fillColor: ColorPalate.DARK_PRIMERY.withOpacity(0.1),
              filled: true,
              hintText: widget.hintText,
              hintStyle: titilliumRegular,
              prefixIcon: widget.prefixIcon != null
                  ? Icon(
                      widget.prefixIcon,
                      size: 16,
                      color: ColorPalate.DARK_PRIMERY.withOpacity(0.5),
                    )
                  : null,
              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: Icon(
                        _obscureText
                            ? FontAwesomeIcons.eye
                            : FontAwesomeIcons.eyeSlash,
                        color: ColorPalate.DARK_PRIMERY.withOpacity(0.5),
                        size: 18,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    )
                  : widget.suffixIcon,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.radius),
                borderSide: BorderSide(
                    style: widget.showBorder
                        ? BorderStyle.solid
                        : BorderStyle.none,
                    width: 0.8,
                    color: ColorPalate.DARK_PRIMERY),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.radius),
                borderSide: BorderSide(
                    style: widget.showBorder
                        ? BorderStyle.solid
                        : BorderStyle.none,
                    width: 1,
                    color: ColorPalate.DARK_PRIMERY),
              ),
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(Dimensions.radiusMoreExtraLarge),
                borderSide: BorderSide(
                    style: widget.showBorder
                        ? BorderStyle.solid
                        : BorderStyle.none,
                    width: 0.8,
                    color: ColorPalate.DARK_PRIMERY),
              ),
            ),
            controller: widget.controller,
            maxLines: widget.maxLines,
          )
        ],
      ),
    );
  }
}
