import 'package:wallet_apps/index.dart';

class MyInputField extends StatelessWidget {
  @override
  // ignore: overridden_fields
  final Key key;
  final String labelText;
  final String prefixText;
  final String textColor;
  final int maxLine;
  final double pLeft, pTop, pRight, pBottom;
  final bool obcureText;
  final bool enableInput;
  final List<TextInputFormatter> textInputFormatter;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final TextEditingController controller;
  final void Function() onTap;
  final FocusNode focusNode;
  final IconButton icon;
  final String Function(String) validateField;
  final String Function(String) onChanged;
  final Function onSubmit;

  const MyInputField(
      {/* User Input Field */
      this.key,
      this.labelText,
      this.prefixText,
      this.pLeft = 16.0,
      this.pTop = 5.0,
      this.pRight = 16.0,
      this.pBottom = 0,
      this.obcureText = false,
      this.enableInput = true,
      this.textInputFormatter,
      this.inputType = TextInputType.text,
      this.inputAction,
      this.maxLine = 1,
      this.onTap,
      @required this.controller,
      @required this.focusNode,
      this.icon,
      this.textColor = "#FFFFFF",
      this.validateField,
      this.onChanged,
      @required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(pLeft, pTop, pRight, pBottom),
        child: TextFormField(
          key: key,
          enabled: enableInput,
          focusNode: focusNode,
          keyboardType: inputType,
          obscureText: obcureText,
          controller: controller,
          onTap: onTap,
          textInputAction:
              // ignore: prefer_if_null_operators
              inputAction == null ? TextInputAction.next : inputAction,
          style: TextStyle(color: hexaCodeToColor(textColor), fontSize: 18.0),
          validator: validateField,
          maxLines: maxLine,
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: TextStyle(
                fontSize: 18.0,
                color: focusNode.hasFocus || controller.text != ""
                    ? hexaCodeToColor("#FFFFF").withOpacity(0.3)
                    : hexaCodeToColor(AppColors.textColor)),
            prefixText: prefixText,
            prefixStyle: TextStyle(
                color: hexaCodeToColor(AppColors.textColor), fontSize: 18.0),
            /* Prefix Text */
            filled: true,
            fillColor: hexaCodeToColor(AppColors.cardColor),
            enabledBorder: myTextInputBorder(controller.text != ""
                ? hexaCodeToColor("#FFFFFF").withOpacity(0.3)
                : Colors.transparent),
            /* Enable Border But Not Show Error */
            border: errorOutline(),
            /* Show Error And Red Border */
            focusedBorder:
                myTextInputBorder(hexaCodeToColor("#FFFFFF").withOpacity(0.3)),
            /* Default Focuse Border Color*/
            focusColor: hexaCodeToColor("#ffffff"),
            /* Border Color When Focusing */
            contentPadding: const  EdgeInsets.fromLTRB(
                21, 23, 21, 23), // Default padding = -10.0 px
            suffixIcon: icon,
          ),
          inputFormatters: textInputFormatter,
          /* Limit Length Of Text Input */
          onChanged: onChanged,
          onFieldSubmitted: (value) {
            onSubmit();
          },
        ));
  }
}

/* User input Outline Border */
OutlineInputBorder myTextInputBorder(Color borderColor) {
  return OutlineInputBorder(
      borderSide: BorderSide(color: borderColor,),
      borderRadius: BorderRadius.circular(8));
}
