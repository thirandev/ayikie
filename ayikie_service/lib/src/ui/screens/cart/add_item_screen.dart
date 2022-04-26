import 'dart:io';

import 'package:ayikie_service/src/app_colors.dart';
import 'package:ayikie_service/src/ui/screens/drawer_screen/drawer_screen.dart';
import 'package:ayikie_service/src/ui/screens/notification_screen/notification_screen.dart';
import 'package:ayikie_service/src/ui/widget/custom_form_field.dart';
import 'package:ayikie_service/src/ui/widget/progress_view.dart';
import 'package:flutter/material.dart';

class AddItemsScreen extends StatefulWidget {
  const AddItemsScreen({Key? key}) : super(key: key);

  @override
  _AddItemsScreenState createState() => _AddItemsScreenState();
}

class _AddItemsScreenState extends State<AddItemsScreen> {
  bool _isLoading = false;
  int _value = 1;

  TextEditingController _titleController = TextEditingController();
  TextEditingController _shortDescriptionController = TextEditingController();
  TextEditingController _fullDescriptionController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Container(
            padding: EdgeInsets.only(left: 16, right: 16, top: 20),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select Your Type',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Spacer(),
                    Text('Product'),
                    SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      height: 20,
                      width: 20,
                      child: Radio<int>(
                        value: 2,
                        activeColor: AppColors.primaryButtonColor,
                        groupValue: _value,
                        onChanged: (value) {
                          setState(() {
                            _value = value!;
                          });
                        },
                      ),
                    ),
                    Spacer(),
                    Text('Service'),
                    SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      height: 20,
                      width: 20,
                      child: Radio<int>(
                        value: 1,
                        activeColor: AppColors.primaryButtonColor,
                        groupValue: _value,
                        onChanged: (value) {
                          setState(() {
                            _value = value!;
                          });
                        },
                      ),
                    ),
                    Spacer(),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Item Image',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.textFieldBackground,
                  ),
                  width: double.infinity,
                  height: 125,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.camera_alt_outlined),
                        Text('Photos'),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Title',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomFormField(
                  controller: _titleController,
                  hintText: 'Enter title here',
                  inputType: TextInputType.text,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Short Description',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomFormField(
                  controller: _shortDescriptionController,
                  hintText: 'Enter short description here',
                  inputType: TextInputType.text,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Full Description',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 100,
                  child: TextField(
                    maxLines: 9,
                    controller: _fullDescriptionController,
                    decoration: InputDecoration(
                        hintText: "Enter your description here",
                        fillColor: AppColors.transparent,
                        filled: true,
                        hintStyle: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w500),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(
                            color: AppColors.greyLightColor,
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(
                              color: AppColors.greyLightColor, width: 1.5),
                        ),
                        contentPadding: const EdgeInsets.only(
                          left: 15,
                          top: 30,
                        )),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Category',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomFormField(
                  controller: _shortDescriptionController,
                  hintText: 'Enter short description here',
                  inputType: TextInputType.text,
                  suffixEnable: true,
                  suffixIcon: Icon(Icons.keyboard_arrow_down_outlined),
                ),
                DropdownButton<String>(
                  items: <String>['A', 'B', 'C', 'D'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (_) {},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
