
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_plus/src/utils/utils.dart';

// ignore: must_be_immutable
class TextFormFieldBuilder extends StatefulWidget {
  TextFormFieldBuilder(
      {Key? key,
        this.controller,
        this.label,
        this.suffixIcon,
        this.onChanged,
        this.keyboardType,
        this.textCapitalization = TextCapitalization.none,
        this.inputFormatters,
        this.prefixText,
        this.hintText,
        this.obscureText = false,
        this.enabled = true,
        this.readOnly = false,
        this.maxLength,
        this.minLines,
        this.validator,
        this.onTap,
        this.autovalidateMode,
        this.maxLines = 1,
        this.focusNode,
        required this.fieldType,
        this.textInputAction})
      : super(key: key);

  final TextEditingController? controller;
  final Widget? label;
  final Widget? suffixIcon;
  final Function(String)? onChanged;
  TextInputType? keyboardType;
  final TextCapitalization textCapitalization;

  List<TextInputFormatter>? inputFormatters;
  final String? prefixText;
  final String? hintText;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final int? maxLength;
  final int? minLines;

  String? Function(String?)? validator;
  final Function()? onTap;
  final AutovalidateMode? autovalidateMode;

  final int? maxLines;
  final FocusNode? focusNode;
  final FieldType fieldType;

  final TextInputAction? textInputAction;


  @override
  State<TextFormFieldBuilder> createState() => TextFormFieldBuilderState();
}

class TextFormFieldBuilderState extends State<TextFormFieldBuilder> {

  bool isError = false;
  String? errorString = "";
  Color colorError = const Color.fromRGBO(234, 64, 110, 1);


  @override
  Widget build(BuildContext context) {
    createStyle();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                border: isError ? Border.all(
                  color:  colorError,
                ) : null,
              color: const Color.fromRGBO(246, 246, 246, 1)
            ),
            child: TextFormField(
              controller: widget.controller,
              //onChanged: widget.onChanged,
              textInputAction: widget.textInputAction,
              focusNode: widget.focusNode,
              autovalidateMode: widget.autovalidateMode,
              onTap: widget.onTap,
              readOnly: widget.readOnly,
              onChanged: widget.onChanged,
              keyboardType: widget.keyboardType,
              textCapitalization: widget.textCapitalization,
              inputFormatters: widget.inputFormatters,
              obscureText: widget.obscureText,
              enabled: widget.enabled,
              maxLines: widget.maxLines,
              maxLength: widget.maxLength, //
              minLines: widget.minLines,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: widget.enabled ? Colors.black : Colors.grey, fontSize: 13.sp),
              validator: (String? value) {
                if (widget.validator!(widget.controller!.text).toString().isNotEmpty) {
                  setState(() {
                    isError = true;
                    errorString = widget.validator!(widget.controller!.text);
                  });
                  return "";
                } else {
                  setState(() {
                    isError = false;
                    errorString = widget.validator!(widget.controller!.text);
                  });
                }

                return null;
              },
              decoration: InputDecoration(
                label: widget.label,
                counterText: '',
                suffixIcon: widget.suffixIcon,
                prefixText: widget.prefixText,
                hintText: widget.hintText,
                contentPadding: REdgeInsets.fromLTRB(14,16, 14, 16),
                labelStyle: const TextStyle(
                    height: 0.8, fontWeight: FontWeight.normal),
                errorStyle: TextStyle(
                    height: 0,
                    color: isError ? colorError : const Color(0xff778FAA)),
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                border: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            )
        ),
        Visibility(
          replacement: const SizedBox(),
          visible: isError ? true : false,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 14.0),
              child: Text(
                errorString!,
                style: TextStyle(color: colorError, fontSize: 12.0),
              ),
            ),
          ),
        )
      ],
    );
  }


  void createStyle() {
    switch(widget.fieldType){

      case FieldType.email:
        widget.inputFormatters = [
          LengthLimitingTextInputFormatter(60),
        ];
        widget.validator = (value) {
          if (value == null || value.isEmpty) {
            return '* Este campo es obligatorio para continuar';
          }
          if (!RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
              .hasMatch(value)) {
            return '* Debes de ingresa un correo válido';
          }
          return '';
        };
        break;
      case FieldType.password:
        widget.validator = (value) {
          if (value == null || value.isEmpty) {
            return '* Este campo es obligatorio para continuar';
          }
          return '';
        };
        break;
      case FieldType.normal:
        break;
      case FieldType.date:
        widget.inputFormatters = [
          FilteringTextInputFormatter.digitsOnly,
          MaskedInputFormatter('##/##/####'),
        ];
        break;
      case FieldType.phone:
        widget.keyboardType = const TextInputType.numberWithOptions(signed: true);
        widget.inputFormatters = [
          MaskedInputFormatter('## #### ####', allowedCharMatcher: RegExp(r"[0-9]")),
        ];
        break;
      case FieldType.underLine:
        break;
      case FieldType.number:
        widget.keyboardType = const TextInputType.numberWithOptions(signed: true);
        widget.inputFormatters = [
          FilteringTextInputFormatter.digitsOnly
        ];
        break;
    }
  }
}
