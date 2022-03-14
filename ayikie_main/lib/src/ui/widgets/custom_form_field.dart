import 'package:ayikie_main/src/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final TextInputType? inputType;
  final Function? suffixCallback;
  final Function? pickFromContact;
  final bool isObsucure;
  final bool isEnabled;
  final bool prefixEnable;
  final bool pickFromContactEnable;
  final bool suffixEnable;
  final String? prefixText;
  final String? suffixUrl;
  final int? maxLength;
  final String? regX;
  final EdgeInsetsGeometry? margin;
  final double marginLeft;
  final double marginRight;
  final double marginBottom;
  final double marginTop;
  final EdgeInsetsGeometry? padding;
  final double paddingLeft;
  final double paddingRight;
  final double paddingBottom;
  final double paddingTop;
  final double? height;
  final Alignment alignment;
  final double? suffixMargin;
  final List<TextInputFormatter>? textInputFormatter;
  final Function? onChange;
  final TextCapitalization? textCapitalization;

  const CustomFormField({
    Key? key,
    required this.controller,
    this.isEnabled = false,
    this.prefixEnable = false,
    this.suffixEnable = false,
    this.pickFromContactEnable = false,
    this.isObsucure = false,
    this.hintText,
    this.suffixUrl,
    this.inputType,
    this.suffixCallback,
    this.maxLength,
    this.pickFromContact,
    this.regX,
    this.marginLeft = 0,
    this.marginRight = 0,
    this.marginBottom = 0,
    this.marginTop = 0,
    this.paddingLeft = 0,
    this.paddingRight = 0,
    this.paddingBottom = 0,
    this.paddingTop = 0,
    this.alignment = Alignment.centerLeft,
    this.margin,
    this.padding,
    this.suffixMargin = 0,
    this.height = 42.5,
    this.textInputFormatter,
    this.onChange,
    this.textCapitalization,
    this.prefixText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height!,
      alignment: alignment,
      margin: margin ??
          EdgeInsets.fromLTRB(
            marginLeft,
            marginTop,
            marginRight,
            marginBottom,
          ),
      padding: padding ??
          EdgeInsets.fromLTRB(
            paddingLeft,
            paddingTop,
            paddingRight,
            paddingBottom,
          ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              obscureText: isObsucure,
              onChanged: (value) {
                if (onChange != null) {
                  onChange!(value);
                }
              },
              inputFormatters: (regX != null)
                  ? [WhitelistingTextInputFormatter(RegExp(regX!))]
                  : (textInputFormatter) ?? [],
              maxLength: maxLength ?? null,
              readOnly: isEnabled,
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText ?? "",
                hintStyle: TextStyle(
                  fontSize: 13.0,
                ),
                filled: true,
                fillColor: AppColors.textFieldBackground,
                suffixIcon: (suffixEnable)
                    ? GestureDetector(
                        onTap: () {
                          if (suffixCallback != null) {
                            suffixCallback!();
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.only(top: 7.5, bottom: 7.5),
                          margin: EdgeInsets.all(suffixMargin!),
                          child: Container(
                              width: 7.5,
                              height: 7.5,
                              child: Image.asset(suffixUrl!)),
                        ),
                      )
                    : null,
                prefixIcon: (prefixEnable)
                    ? Container(
                        height: 42.5,
                        margin: const EdgeInsets.only(right: 15),
                        width: 65,
                        decoration: const BoxDecoration(
                          color: AppColors.primaryButtonColor,
                          borderRadius:
                              BorderRadius.horizontal(left: Radius.circular(8)),
                        ),
                        child: Center(
                            child:
                                (prefixText != null && prefixText!.isNotEmpty)
                                    ? Text(
                                        prefixText!,
                                        style: TextStyle(
                                            color: AppColors.white,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400),
                                      )
                                    : Container()))
                    : null,
                contentPadding: (prefixEnable)
                    ? const EdgeInsets.only(left: 15, top: 0, right: 0)
                    : const EdgeInsets.only(left: 25, top: 0, right: 0),
                border: OutlineInputBorder(
                  borderRadius: (pickFromContactEnable)
                      ? BorderRadius.horizontal(left: Radius.circular(8))
                      : BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              keyboardType: inputType ?? TextInputType.text,
              textCapitalization: textCapitalization ?? TextCapitalization.none,
              style: const TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
