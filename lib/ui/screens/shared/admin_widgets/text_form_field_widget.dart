import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/responsive.dart';
import '../values/colors.dart';
import '../values/sizes.dart';

class TextFormFieldsWidget extends StatefulWidget {
  final String title;
  final String? description;
  final bool autoFocus;
  final String? labelText;
  final String hintText;
  final bool dynamicColor;
  final IconData? prefixIcon;
  final String? prefixText;
  final IconData? suffixIcon;
  final String? suffixText;
  final int maxLines;
  final int? minLines;
  final int? maxLength;
  final bool counterVisible;
  final bool filled;
  final bool enabled;
  final bool obscureText; // This is the initial state of obscureText
  final bool mpinField;
  final bool amountField;
  final bool mobileNumberField;
  final bool accountNumberField;
  final bool remittanceCodeField;
  final bool enableInteractiveSelection;
  final ValueChanged<String>? onFieldSubmitted;
  final bool denySpacing;
  final bool isAlipay;
  final TextAlign textAlign;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextEditingController controller;
  final List<TextInputFormatter> inputFormatters;
  final Function()? onTap;
  final Function(String?)? onSaved;
  final Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final Function()? onEditingComplete;
  final FocusNode? focusNode;
  final bool isUsername;
  final bool autofocus;
  final bool accountsNumberField;
  final bool loanReference;
  final bool accountNameField;

  const TextFormFieldsWidget({
    super.key,
    this.onFieldSubmitted,
    this.title = '',
    this.description,
    this.autoFocus = false,
    this.labelText,
    this.hintText = '',
    this.dynamicColor = true,
    this.prefixIcon,
    this.prefixText,
    this.suffixIcon,
    this.suffixText,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.counterVisible = true,
    this.filled = false,
    this.enabled = true,
    this.obscureText = false, // Initial state of obscureText
    this.mpinField = false,
    this.amountField = false,
    this.mobileNumberField = false,
    this.accountNumberField = false,
    this.remittanceCodeField = false,
    this.enableInteractiveSelection = true,
    this.denySpacing = false,
    this.textAlign = TextAlign.left,
    required this.keyboardType,
    required this.textInputAction,
    required this.controller,
    this.onTap,
    this.onSaved,
    this.onChanged,
    this.onEditingComplete,
    required this.validator,
    this.inputFormatters = const [],
    this.focusNode,
    this.isUsername = false,
    this.autofocus = false,
    this.isAlipay = false,
    this.accountsNumberField = false,
    this.loanReference = false,
    this.accountNameField = false,
  });

  @override
  State<TextFormFieldsWidget> createState() => _TextFormFieldsWidgetState();
}

class _TextFormFieldsWidgetState extends State<TextFormFieldsWidget> {
  bool isTextVisible = false; // Local state to manage text visibility

  @override
  void initState() {
    super.initState();
    // Initialize isTextVisible with the value of widget.obscureText
    isTextVisible = !widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Responsive(
        desktop: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            widget.title.isEmpty
                ? const SizedBox(height: 30,)
                : Padding(
              padding: const EdgeInsets.only(left: Sizes.PADDING_10),
              child: Text(
                ' ${widget.title}',
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: widget.title.isEmpty ? Sizes.PADDING_0 : Sizes.PADDING_10,
                bottom: widget.maxLength != null && widget.counterVisible ? Sizes.PADDING_0 : Sizes.PADDING_10,
                left: widget.maxLength != null && widget.counterVisible ? Sizes.PADDING_0 : Sizes.PADDING_10,
                right: widget.maxLength != null && widget.counterVisible ? Sizes.PADDING_0 : Sizes.PADDING_10,
              ),
              child: Column(
                children: [
                  TextFormField(
                    style: const TextStyle(fontSize: 15),
                    validator: widget.validator,
                    autofocus: widget.autoFocus,
                    focusNode: widget.focusNode,
                    controller: widget.controller,
                    textAlign: widget.textAlign,
                    enabled: widget.enabled,
                    maxLines: widget.maxLines,
                    minLines: widget.minLines,
                    maxLength: widget.mobileNumberField ? 10 : widget.maxLength,
                    obscureText: !isTextVisible, // Bind to local state
                    keyboardType: widget.keyboardType,
                    textInputAction: widget.textInputAction,
                    enableInteractiveSelection: widget.onTap != null ? false : widget.enableInteractiveSelection,
                    onTap: widget.onTap,
                    onChanged: widget.onChanged,
                    onEditingComplete: widget.onEditingComplete,
                    onSaved: widget.onSaved,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                      filled: widget.filled,
                      isDense: true,
                      prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
                      suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: widget.dynamicColor ? Colors.grey :Colors.grey),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: widget.dynamicColor ? Colors.grey : Colors.grey),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: AppColors.black),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: AppColors.red),
                      ),
                      errorStyle: TextStyle(color: Theme.of(context).colorScheme.error),
                      labelStyle: TextStyle(color: widget.dynamicColor ? Colors.green : Colors.green),
                      labelText: widget.labelText,
                      hintText: widget.hintText,
                      hintStyle: const TextStyle(color: Colors.black38, fontSize: 13),
                      prefixIcon: widget.prefixText != null
                          ? Container(
                        width: 35,
                        padding: const EdgeInsets.only(bottom: Sizes.PADDING_2),
                        child: Center(
                          child: Text(
                            widget.prefixText!,
                            style: TextStyle(
                              fontSize: 13,
                              color: widget.enabled ? Colors.green : Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                          : widget.prefixIcon != null
                          ? Container(
                        width: 35,
                        padding: const EdgeInsets.only(bottom: Sizes.PADDING_2),
                        child: Center(
                          child: Icon(
                            widget.prefixIcon,
                            size: 18.0,
                            color: widget.dynamicColor ? Color(0xFF630606) : Color(0xFF630606),
                          ),
                        ),
                      )
                          : const SizedBox(width: 10.0),
                      suffixIcon: widget.suffixText != null
                          ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: Sizes.PADDING_12),
                        child: Text(
                          widget.suffixText!,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                          : widget.obscureText
                          ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: Sizes.PADDING_12),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isTextVisible = !isTextVisible; // Toggle visibility
                            });
                          },
                          child: Icon(
                            isTextVisible ? Icons.visibility : Icons.visibility_off_outlined,
                            size: 17.0,
                            color: widget.dynamicColor ? Color(0xFF630606) : Color(0xFF630606),
                          ),
                        ),
                      )
                          : widget.suffixIcon != null
                          ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: Sizes.PADDING_12),
                        child: Icon(
                          widget.suffixIcon,
                          size: 17.0,
                          color: widget.dynamicColor ? Color(0xFF630606) : Color(0xFF630606),
                        ),
                      )
                          : SizedBox(height: 50,),
                    ),
                  ),
                  if (widget.description != null)
                    Container(
                      padding: const EdgeInsets.only(left: 2.0),
                      width: double.infinity,
                      child: Text(
                        '${widget.description}',
                        textAlign: TextAlign.start,
                        style: const TextStyle(fontSize: 9),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        mobile: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            widget.title.isEmpty
                ? SizedBox(height: 30,)
                : Padding(
              padding: const EdgeInsets.only(left: Sizes.PADDING_10),
              child: Text(
                ' ${widget.title}',
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: widget.title.isEmpty ? Sizes.PADDING_0 : Sizes.PADDING_10,
                bottom: widget.maxLength != null && widget.counterVisible ? Sizes.PADDING_0 : Sizes.PADDING_10,
                left: widget.maxLength != null && widget.counterVisible ? Sizes.PADDING_0 : Sizes.PADDING_10,
                right: widget.maxLength != null && widget.counterVisible ? Sizes.PADDING_0 : Sizes.PADDING_10,
              ),
              child: Column(
                children: [
                  TextFormField(
                    style: const TextStyle(fontSize: 15),
                    validator: widget.validator,
                    autofocus: widget.autoFocus,
                    focusNode: widget.focusNode,
                    controller: widget.controller,
                    textAlign: widget.textAlign,
                    enabled: widget.enabled,
                    maxLines: widget.maxLines,
                    minLines: widget.minLines,
                    maxLength: widget.mobileNumberField ? 10 : widget.maxLength,
                    obscureText: !isTextVisible, // Bind to local state
                    keyboardType: widget.keyboardType,
                    textInputAction: widget.textInputAction,
                    enableInteractiveSelection: widget.onTap != null ? false : widget.enableInteractiveSelection,
                    onTap: widget.onTap,
                    onChanged: widget.onChanged,
                    onEditingComplete: widget.onEditingComplete,
                    onSaved: widget.onSaved,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                      filled: widget.filled,
                      isDense: true,
                      prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
                      suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: widget.dynamicColor ? Colors.grey : Colors.grey),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: widget.dynamicColor ? Colors.grey : Colors.grey),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: AppColors.red),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: AppColors.red),
                      ),
                      errorStyle: TextStyle(color: Theme.of(context).colorScheme.error),
                      labelStyle: TextStyle(color: widget.dynamicColor ? Colors.green : Colors.green),
                      labelText: widget.labelText,
                      hintText: widget.hintText,
                      hintStyle: const TextStyle(color: Colors.black38, fontSize: 13),
                      prefixIcon: widget.prefixText != null
                          ? Container(
                        width: 35,
                        padding: const EdgeInsets.only(bottom: Sizes.PADDING_2),
                        child: Center(
                          child: Text(
                            widget.prefixText!,
                            style: TextStyle(
                              fontSize: 13,
                              color: widget.enabled ? Colors.green : Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                          : widget.prefixIcon != null
                          ? Container(
                        width: 35,
                        padding: const EdgeInsets.only(bottom: Sizes.PADDING_2),
                        child: Center(
                          child: Icon(
                            widget.prefixIcon,
                            size: 18.0,
                            color: widget.dynamicColor ? Colors.black : Colors.black,
                          ),
                        ),
                      )
                          : const SizedBox(width: 10.0),
                      suffixIcon: widget.suffixText != null
                          ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: Sizes.PADDING_12),
                        child: Text(
                          widget.suffixText!,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                          : widget.obscureText
                          ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: Sizes.PADDING_12),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isTextVisible = !isTextVisible; // Toggle visibility
                            });
                          },
                          child: Icon(
                            isTextVisible ? Icons.visibility : Icons.visibility_off_outlined,
                            size: 17.0,
                            color: widget.dynamicColor ? Color(0xFF630606) : Color(0xFF630606),
                          ),
                        ),
                      )
                          : widget.suffixIcon != null
                          ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: Sizes.PADDING_12),
                        child: Icon(
                          widget.suffixIcon,
                          size: 17.0,
                          color: widget.dynamicColor ? Color(0xFF630606) : Color(0xFF630606),
                        ),
                      )
                          : SizedBox(height: 50,),
                    ),
                  ),
                  if (widget.description != null)
                    Container(
                      padding: const EdgeInsets.only(left: 2.0),
                      width: double.infinity,
                      child: Text(
                        '${widget.description}',
                        textAlign: TextAlign.start,
                        style: const TextStyle(fontSize: 9),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}