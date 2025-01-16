import 'package:fav_movies/core/themes/app_colors.dart';
import 'package:fav_movies/core/themes/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DefaultTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final String? errorText;
  final bool isRequired;
  final bool obscureText;
  final List<TextInputFormatter> formatters;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool showObscureTextIcon;
  final bool isValidated;
  final bool hasError;
  final void Function()? onEditingComplete;
  final void Function()? onTap;
  final TextInputType? keyboardType;
  final bool underlinedBorder;
  final double borderWidth;
  final Color? fillColor;
  final Color borderAndIconColor;
  final Color errorColor;
  final Color mainColor;
  final Color labelColor;
  final Color validatedColor;
  final Color? readOnlyFillColor;
  final Color? readOnlyTextColor;
  final bool enableInteractiveSelection;
  final bool enableSuggestions;
  final int maxLines;
  final Widget? suffixIcon;
  final bool readOnly;
  final int? errorMaxLines;
  final TextInputAction textInputAction;
  final FocusNode? focusNode;
  final EdgeInsets margin;
  final double? height;
  final bool autofocus;
  final int? maxLength;

  const DefaultTextField({
    super.key,
    this.controller,
    this.labelText,
    this.margin = const EdgeInsets.only(top: 15, left: 15, right: 15),
    this.hintText,
    this.textInputAction = TextInputAction.done,
    this.errorText,
    this.isRequired = false,
    this.obscureText = false,
    this.formatters = const [],
    this.enableInteractiveSelection = true,
    this.enableSuggestions = false,
    this.onChanged,
    this.keyboardType,
    this.validator,
    this.isValidated = false,
    this.showObscureTextIcon = false,
    this.onEditingComplete,
    this.onTap,
    this.underlinedBorder = false,
    this.readOnly = false,
    this.maxLines = 1,
    this.borderWidth = 1,
    this.hasError = false,
    this.fillColor = AppColors.secundaryColor,
    this.errorColor = Colors.red,
    this.borderAndIconColor = AppColors.primaryColorLight,
    this.mainColor = Colors.black,
    this.validatedColor = AppColors.primaryColorLight,
    this.labelColor = AppColors.primaryColorLight,
    this.readOnlyFillColor,
    this.readOnlyTextColor,
    this.suffixIcon,
    this.errorMaxLines,
    this.focusNode,
    this.height,
    this.autofocus = false,
    this.maxLength,
  });

  @override
  State<StatefulWidget> createState() => _DefaultTextFieldState();
}

class _DefaultTextFieldState extends State<DefaultTextField> {
  late InputBorder inputBorder;

  requiredLabel() => Text(widget.isRequired ? ' *' : '',
      style: const TextStyle(color: Colors.red));

  bool showObscureText = false;

  @override
  void initState() {
    showObscureText = widget.obscureText;
    inputBorder = widget.underlinedBorder
        ? UnderlineInputBorder(
            borderSide:
                BorderSide(width: widget.borderWidth, color: Colors.black))
        : OutlineInputBorder(
            borderSide:
                BorderSide(width: widget.borderWidth, color: Colors.black));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.hasError ? null : widget.height,
      margin: widget.margin,
      child: TextFormField(
          validator: widget.validator,
          textAlign: TextAlign.start,
          autofocus: widget.autofocus,
          textAlignVertical: TextAlignVertical.bottom,
          inputFormatters: widget.formatters,
          onChanged: widget.onChanged,
          enableInteractiveSelection: widget.enableInteractiveSelection,
          enableSuggestions: widget.enableSuggestions,
          readOnly: widget.readOnly,
          focusNode: widget.focusNode,
          keyboardType: widget.keyboardType,
          maxLength: widget.maxLength,
          textInputAction: widget.textInputAction,
          controller: widget.controller,
          onTap: widget.onTap,
          style: AppTextStyles.bodyMedium.copyWith(
              fontSize: 15,
              color: widget.isValidated
                  ? widget.validatedColor
                  : widget.readOnly && widget.readOnlyTextColor != null
                      ? widget.readOnlyTextColor
                      : widget.mainColor),
          obscureText: showObscureText,
          maxLines: widget.maxLines,
          onEditingComplete: widget.onEditingComplete,
          decoration: InputDecoration(
            filled: widget.readOnly || widget.fillColor != null,
            fillColor: widget.readOnly
                ? widget.readOnlyFillColor ?? widget.fillColor
                : widget.fillColor,
            suffixIcon: widget.suffixIcon ??
                (widget.showObscureTextIcon
                    ? IconButton(
                        color: widget.borderAndIconColor,
                        onPressed: () =>
                            setState(() => showObscureText = !showObscureText),
                        icon: showObscureText
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility))
                    : null),
            focusedBorder: inputBorder.copyWith(
                borderSide: BorderSide(
                    width: widget.borderWidth,
                    color: widget.isValidated
                        ? widget.validatedColor
                        : widget.hasError
                            ? widget.errorColor
                            : widget.borderAndIconColor)),
            focusedErrorBorder: inputBorder.copyWith(
                borderSide: BorderSide(
                    color:
                        widget.hasError ? widget.errorColor : widget.errorColor,
                    width: widget.borderWidth)),
            errorBorder: inputBorder.copyWith(
                borderSide: BorderSide(
                    color: widget.hasError
                        ? widget.errorColor
                        : widget.borderAndIconColor,
                    width: widget.borderWidth)),
            error: widget.hasError
                ? Text(
                    widget.errorText ?? '',
                    softWrap: true,
                    maxLines: widget.errorMaxLines,
                    style: AppTextStyles.bodyMedium.copyWith(
                        color: widget.errorColor,
                        overflow: TextOverflow.visible),
                  )
                : null,
            enabledBorder: inputBorder.copyWith(
                borderSide: BorderSide(
                    width: widget.borderWidth,
                    color: widget.isValidated
                        ? widget.validatedColor
                        : widget.hasError
                            ? widget.errorColor
                            : widget.borderAndIconColor)),
            border: inputBorder.copyWith(
                borderSide: BorderSide(
                    width: widget.borderWidth,
                    color: widget.borderAndIconColor)),
            hintText: widget.hintText,
            hintStyle: const TextStyle(color: Colors.grey),
            label: widget.labelText != null
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                          child: Text(
                        widget.labelText!,
                        style: TextStyle(
                            color: widget.labelColor,
                            fontSize: 16,
                            overflow: TextOverflow.clip),
                      )),
                      requiredLabel()
                    ],
                  )
                : null,
          )),
    );
  }
}
