import 'package:animated_text_field/animated_text_field.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {

  final String titleText;
  final TextAlign titleTextAlign;
  final bool isPassword;
  final bool readOnly;
  final bool enable;
  final bool disableValidation;
  final String hintText;
  final TextEditingController textController;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Function(String)? onChange;
  final TextInputType inputType;

  const TextFieldWidget(
      { Key? key,
        this.titleText = '',
        this.titleTextAlign = TextAlign.center,
        this.isPassword = false,
        this.readOnly = false,
        this.enable = true,
        this.disableValidation = false,
        this.hintText = '',
        this.prefixIcon,
        this.onChange,
        this.suffixIcon,
        this.inputType = TextInputType.text,
        required this.textController}) : super(key: key);

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool showPassword = false;

  @override
  void initState() {
    super.initState();
    showPassword = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // errorKey: 'password',
      onChanged: widget.onChange,
      controller: widget.textController,
      keyboardType: widget.inputType,
      obscureText: showPassword,
      enabled: widget.enable,
      readOnly: widget.readOnly,
      scrollPadding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).viewInsets.bottom),


      decoration: CustomTextInputDecoration(

        prefixIcon: widget.prefixIcon,
        hintText: widget.hintText,

        suffixIcon: widget.isPassword? IconButton(
          icon: Icon(
            showPassword
                ? Icons.visibility
                : Icons.visibility_off,
            color: Theme.of(context).primaryColorDark,
          ),
          onPressed: () {
            setState(() {
              showPassword = !showPassword;
            });
          },
        ): widget.suffixIcon,

        label: Text(widget.titleText),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 1,
          ),
        ),

        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 1,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(
            color: Colors.blue,
            width: 2,
          ),
        ),
      ),

      validator: (String? value) {
        if (widget.disableValidation) {
          return null;
        }

        if (value == '') {
            return "Can not be empty";
        }
        if (widget.isPassword && value!.length<8) {
          return "password need to be at least 6 ";
        }

        return null;
      },

    );
  }
}




