import 'dart:io';

import 'package:ayikie_service/src/api/api_calls.dart';
import 'package:ayikie_service/src/app_colors.dart';
import 'package:ayikie_service/src/models/dropdown.dart';
import 'package:ayikie_service/src/models/location.dart';
import 'package:ayikie_service/src/ui/widget/custom_form_field.dart';
import 'package:ayikie_service/src/ui/widget/image_source_dialog.dart';
import 'package:ayikie_service/src/ui/widget/primary_button.dart';
import 'package:ayikie_service/src/ui/widget/progress_view.dart';
import 'package:ayikie_service/src/utils/alerts.dart';
import 'package:ayikie_service/src/utils/validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class AddItemsScreen extends StatefulWidget {
  const AddItemsScreen({Key? key}) : super(key: key);

  @override
  _AddItemsScreenState createState() => _AddItemsScreenState();
}

class _AddItemsScreenState extends State<AddItemsScreen> {
  bool _isLoading = true;
  int _value = 1;
  bool _checkBoxValue = false;

  late File _servicePhoto;
  late File _productPhoto;
  bool isUploaded = false;

  List<Dropdown> serviceCategories = [];
  List<Dropdown> productCategories = [];
  List<Dropdown> serviceSubCategories = [];
  List<Dropdown> productSubCategories = [];
  List<Dropdown> statesDropdown = [];
  List<Dropdown> city = [];

  late Dropdown selectedServiceCategory;
  late Dropdown selectedProductCategory;
  late Dropdown selectedSubServiceCategory;
  late Dropdown selectedSubProductCategory;
  late Dropdown selectedState;
  late Dropdown selectedCity;

  TextEditingController _titleController = TextEditingController();
  TextEditingController _shortDescriptionController = TextEditingController();
  TextEditingController _fullDescriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _stockController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getServiceCategory();
  }

  void _getServiceCategory() async {
    await ApiCalls.getServicesDropdown().then((response) {
      if (!mounted) {
        return;
      }
      if (response.isSuccess) {
        var data = response.jsonBody;
        serviceCategories.clear();
        for (var item in data) {
          Dropdown dropdown = Dropdown.fromJson(item);
          serviceCategories.add(dropdown);
        }
        selectedServiceCategory = serviceCategories[0];
        _getSubServiceCategory(selectedServiceCategory.id);
      } else {
        Alerts.showMessage(context, "Something went wrong. Please try again.",
            title: "Oops!");
      }
    });
  }

  void _getSubServiceCategory(int categoryId) async {
    await ApiCalls.getSubServicesDropdown(categoryId: categoryId).then((
        response) {
      if (!mounted) {
        return;
      }
      if (response.isSuccess) {
        var data = response.jsonBody;
        serviceSubCategories.clear();
        for (var item in data) {
          Dropdown dropdown = Dropdown.fromJson(item);
          serviceSubCategories.add(dropdown);
        }
        selectedSubServiceCategory = serviceSubCategories[0];
      } else {
        Alerts.showMessage(context, "Something went wrong. Please try again.",
            title: "Oops!");
      }
      _getStates();
    });
  }

  void _getProductCategory() async {
    await ApiCalls.getProductsDropdown().then((response) {
      if (!mounted) {
        return;
      }
      if (response.isSuccess) {
        var data = response.jsonBody;
        productCategories.clear();
        for (var item in data) {
          Dropdown dropdown = Dropdown.fromJson(item);
          productCategories.add(dropdown);
        }
        selectedProductCategory = productCategories[0];
        _getSubProductCategory(selectedProductCategory.id);
      } else {
        Alerts.showMessage(context, "Something went wrong. Please try again.",
            title: "Oops!");
      }
    });
  }

  void _getSubProductCategory(int categoryId) async {
    await ApiCalls.getSubProductsDropdown(categoryId: categoryId).then((
        response) {
      if (!mounted) {
        return;
      }
      if (response.isSuccess) {
        var data = response.jsonBody;
        productSubCategories.clear();
        for (var item in data) {
          Dropdown dropdown = Dropdown.fromJson(item);
          productSubCategories.add(dropdown);
        }
        selectedSubProductCategory = productSubCategories[0];
      } else {
        Alerts.showMessage(context, "Something went wrong. Please try again.",
            title: "Oops!");
      }
      _getStates();
    });
  }

  void _getStates() async {
    await ApiCalls.getStates().then((
        response) {
      if (!mounted) {
        return;
      }
      if (response.isSuccess) {
        var data = response.jsonBody;
        statesDropdown.clear();
        int countId = 0;
        for (var item in data) {
          States states = States.fromJson(item);
          Dropdown dropdown = Dropdown(id: countId,name: states.state);
          countId++;
          statesDropdown.add(dropdown);
        }
        selectedState = statesDropdown[0];
      } else {
        Alerts.showMessage(context, "Something went wrong. Please try again.",
            title: "Oops!");
      }
      _getCities();
    });
  }

  void _getCities() async {
    await ApiCalls.getCities(selectedState.name).then((
        response) {
      if (!mounted) {
        return;
      }
      if (response.isSuccess) {
        var data = response.jsonBody;
        city.clear();
        int countId = 0;
        for (var item in data) {
          Cities cityRes = Cities.fromJson(item);
          Dropdown dropdown = Dropdown(id: countId,name: cityRes.city);
          countId++;
          city.add(dropdown);
        }
        selectedCity = city[0];
      } else {
        Alerts.showMessage(context, "Something went wrong. Please try again.",
            title: "Oops!");
      }
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _priceController.dispose();
    _shortDescriptionController.dispose();
    _fullDescriptionController.dispose();
    _titleController.dispose();
    _stockController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 16, right: 16, top: 20),
          child: _isLoading
              ? Center(
            child: ProgressView(),
          ) : Column(
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
                          _isLoading = true;
                          isUploaded = false;
                        });
                        if (_value == 1) {
                          _getServiceCategory();
                        } else {
                          _getProductCategory();
                        }
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
                          _isLoading = true;
                          isUploaded = false;
                        });
                        if (_value == 1) {
                          _getServiceCategory();
                        } else {
                          _getProductCategory();
                        }
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
              isUploaded ?
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.textFieldBackground,
                  ),
                  width: double.infinity,
                  height: 75,
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.center,
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      ),
                      Text('Uploaded Successfully'),
                    ],
                  )
              ) :
              GestureDetector(
                onTap: _updatePicture,
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.textFieldBackground,
                    ),
                    width: double.infinity,
                    height: 75,
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.center,
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: [
                        Icon(Icons.camera_alt_outlined),
                        Text('Photos'),
                      ],
                    )
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
                      hintStyle:
                      TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
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
              _value == 1 ? DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.all(Radius.circular(8)),
                  border: Border.all(
                      width: 1, //
                      color: AppColors
                          .greyLightColor //            <--- border width here
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: DropdownButton<Dropdown>(
                    value: selectedServiceCategory,
                    isExpanded: true,
                    iconEnabledColor: AppColors.primaryButtonColor,
                    items: serviceCategories.map((Dropdown value) {
                      return DropdownMenuItem<Dropdown>(
                        value: value,
                        child: Text(value.name),
                      );
                    }).toList(),
                    underline: SizedBox(
                      width: 120,
                    ),
                    icon: const Icon(Icons.keyboard_arrow_down),
                    onChanged: (Dropdown? newValue) {
                      setState(() {
                        selectedServiceCategory = newValue!;
                        _isLoading = true;
                      });
                      _getSubServiceCategory(selectedServiceCategory.id);
                    },
                  ),
                ),
              ) : DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.all(Radius.circular(8)),
                  border: Border.all(
                      width: 1, //
                      color: AppColors
                          .greyLightColor //            <--- border width here
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: DropdownButton<Dropdown>(
                    value: selectedProductCategory,
                    isExpanded: true,
                    iconEnabledColor: AppColors.primaryButtonColor,
                    items: productCategories.map((Dropdown value) {
                      return DropdownMenuItem<Dropdown>(
                        value: value,
                        child: Text(value.name),
                      );
                    }).toList(),
                    underline: SizedBox(
                      width: 120,
                    ),
                    icon: const Icon(Icons.keyboard_arrow_down),
                    onChanged: (Dropdown? newValue) {
                      setState(() {
                        selectedProductCategory = newValue!;
                        _isLoading = true;
                      });
                      _getSubProductCategory(selectedProductCategory.id);
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Sub Category',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 10,
              ),
              _value == 1 ?
              DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.all(Radius.circular(8)),
                  border: Border.all(
                      width: 1, //
                      color: AppColors
                          .greyLightColor //            <--- border width here
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: DropdownButton<Dropdown>(
                    value: selectedSubServiceCategory,
                    isExpanded: true,
                    iconEnabledColor: AppColors.primaryButtonColor,
                    items: serviceSubCategories.map((Dropdown value) {
                      return DropdownMenuItem<Dropdown>(
                        value: value,
                        child: Text(value.name),
                      );
                    }).toList(),
                    underline: SizedBox(
                      width: 120,
                    ),
                    icon: const Icon(Icons.keyboard_arrow_down),
                    onChanged: (Dropdown? newValue) {
                      setState(() {
                        selectedSubServiceCategory = newValue!;
                      });
                    },
                  ),
                ),
              )
                  :
              DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.all(Radius.circular(8)),
                  border: Border.all(
                      width: 1, //
                      color: AppColors
                          .greyLightColor //            <--- border width here
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: DropdownButton<Dropdown>(
                    value: selectedSubProductCategory,
                    isExpanded: true,
                    iconEnabledColor: AppColors.primaryButtonColor,
                    items: productSubCategories.map((Dropdown value) {
                      return DropdownMenuItem<Dropdown>(
                        value: value,
                        child: Text(value.name),
                      );
                    }).toList(),
                    underline: SizedBox(
                      width: 120,
                    ),
                    icon: const Icon(Icons.keyboard_arrow_down),
                    onChanged: (Dropdown? newValue) {
                      setState(() {
                        selectedSubProductCategory = newValue!;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'State',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 10,
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.all(Radius.circular(8)),
                  border: Border.all(
                      width: 1, //
                      color: AppColors
                          .greyLightColor //            <--- border width here
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: DropdownButton<Dropdown>(
                    value: selectedState,
                    isExpanded: true,
                    iconEnabledColor: AppColors.primaryButtonColor,
                    items: statesDropdown.map((Dropdown value) {
                      return DropdownMenuItem<Dropdown>(
                        value: value,
                        child: Text(value.name),
                      );
                    }).toList(),
                    underline: SizedBox(
                      width: 120,
                    ),
                    icon: const Icon(Icons.keyboard_arrow_down),
                    onChanged: (Dropdown? newValue) {
                      setState(() {
                        selectedState = newValue!;
                        _isLoading = true;
                      });
                      _getCities();
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'City',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 10,
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.all(Radius.circular(8)),
                  border: Border.all(
                      width: 1, //
                      color: AppColors
                          .greyLightColor //            <--- border width here
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: DropdownButton<Dropdown>(
                    value: selectedCity,
                    isExpanded: true,
                    iconEnabledColor: AppColors.primaryButtonColor,
                    items: city.map((Dropdown value) {
                      return DropdownMenuItem<Dropdown>(
                        value: value,
                        child: Text(value.name),
                      );
                    }).toList(),
                    underline: SizedBox(
                      width: 120,
                    ),
                    icon: const Icon(Icons.keyboard_arrow_down),
                    onChanged: (Dropdown? newValue) {
                      setState(() {
                        selectedCity = newValue!;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              _value == 2
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Stock Amount',
                    style: TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomFormField(
                    controller: _stockController,
                    hintText: 'Enter stock amount here',
                    inputType: TextInputType.number,
                    suffixEnable: false,
                    suffixIcon: Icon(Icons.keyboard_arrow_down_outlined),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Price',
                    style: TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomFormField(
                    controller: _priceController,
                    hintText: 'Enter price here',
                    inputType: TextInputType.number,
                    suffixEnable: false,
                    suffixIcon: Icon(Icons.keyboard_arrow_down_outlined),
                  ),
                ],
              )
                  : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Starting Price',
                    style: TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomFormField(
                    controller: _priceController,
                    hintText: 'Enter starting price here',
                    inputType: TextInputType.number,
                    suffixEnable: false,
                    suffixIcon: Icon(Icons.keyboard_arrow_down_outlined),
                  ),
                ],
              ),

              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Checkbox(
                    value: this._checkBoxValue,
                    onChanged: (bool? value) {
                      setState(() {
                        this._checkBoxValue = value!;
                      });
                    },
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text('I agree with the terms and conditions')
                ],
              ),
              SizedBox(
                height: 20,
              ),
              PrimaryButton(
                  text: 'Add Item',
                  clickCallback: _value==1?_addService:_addProduct
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updatePicture() {
    ImageSourceDialog.show(context, _selectPicture);
  }

  Future _selectPicture(int mode) async {
    if (mode == 1) {
      try {
        var image = await ImagePicker().getImage(
            source: ImageSource.camera, maxWidth: 400, maxHeight: 400);
        if (image != null) {
          _value == 1 ?
          _servicePhoto = File(image.path) :
          _productPhoto = File(image.path);
          setState(() {
            isUploaded = true;
          });
        }
      } on PlatformException catch (e) {
        Alerts.showMessage(context,
            "Access to the camera has been denied, please enable it to continue.");
      } catch (e) {
        Alerts.showMessage(context, e.toString());
      }
    } else {
      try {
        var image = await ImagePicker().getImage(
            source: ImageSource.gallery, maxWidth: 400, maxHeight: 400);
        if (image != null) {
          _value == 1 ?
          _servicePhoto = File(image.path) :
          _productPhoto = File(image.path);
          setState(() {
            isUploaded = true;
          });
          print('here');
        }
      } on PlatformException catch (e) {
        Alerts.showMessage(context,
            "Access to the gallery has been denied, please enable it to continue.");
      } catch (e) {
        Alerts.showMessage(context, e.toString());
      }
    }
  }

  void _addService() async {
    String title = _titleController.text.trim();
    String info = _shortDescriptionController.text.trim();
    String des = _fullDescriptionController.text.trim();
    String price = _priceController.text.trim();

    if (!Validations.validateString(title)) {
      Alerts.showMessage(context, "Enter your title");
      return;
    }
    if (!Validations.validateString(info)) {
      Alerts.showMessage(context, "Enter your short description");
      return;
    }
    if (!Validations.validateString(des)) {
      Alerts.showMessage(context, "Enter your description");
      return;
    }
    if (!Validations.validateString(price)) {
      Alerts.showMessage(context, "Enter your price");
      return;
    }
    if (!_checkBoxValue) {
      Alerts.showMessage(context, "Accept terms and Conditions");
      return;
    }

    setState(() {
      _isLoading = true;
    });
    ApiCalls.addService(
        title: title,
        introduction: info,
        description: des,
        location: selectedCity.name,
        state: selectedState.name,
        price: price,
        catId: selectedServiceCategory.id,
        subCatId: selectedSubServiceCategory.id,
        picture: _servicePhoto)
    .then((response) async {
    if (!mounted) {
    return;
    }
    if (response.isSuccess) {
    Alerts.showMessage(context, "Serive added sucessfully.",
    title: "Success!", onCloseCallback: ()=> Navigator.pushNamedAndRemoveUntil(
    context, '/ServiceScreen', (route) => false)
    );
    } else {

    Alerts.showMessageForResponse(context, response);
    setState(() {
    _isLoading = false;
    });
    }
    });
  }

  void _addProduct() async {
    String title = _titleController.text.trim();
    String info = _shortDescriptionController.text.trim();
    String des = _fullDescriptionController.text.trim();
    String price = _priceController.text.trim();
    String stock = _stockController.text.trim();

    if (!Validations.validateString(title)) {
      Alerts.showMessage(context, "Enter your title");
      return;
    }
    if (!Validations.validateString(info)) {
      Alerts.showMessage(context, "Enter your short description");
      return;
    }
    if (!Validations.validateString(des)) {
      Alerts.showMessage(context, "Enter your description");
      return;
    }
    if (!Validations.validateString(price)) {
      Alerts.showMessage(context, "Enter your price");
      return;
    }
    if (!Validations.validateString(stock)) {
      Alerts.showMessage(context, "Enter your stock");
      return;
    }
    if (!_checkBoxValue) {
      Alerts.showMessage(context, "Accept terms and Conditions");
      return;
    }

    setState(() {
      _isLoading = true;
    });
    ApiCalls.addProduct(
        title: title,
        introduction: info,
        description: des,
        location: selectedCity.name,
        state: selectedState.name,
        price: price,
        stock: stock,
        catId: selectedProductCategory.id,
        subCatId: selectedSubProductCategory.id,
        picture: _productPhoto)
        .then((response) async {
      if (!mounted) {
        return;
      }
      if (response.isSuccess) {
        Alerts.showMessage(context, "Product added sucessfully.",
            title: "Success!", onCloseCallback: ()=> Navigator.pushNamedAndRemoveUntil(
                context, '/ServiceScreen', (route) => false)
        );
      } else {
        Alerts.showMessageForResponse(context, response);
        setState(() {
          _isLoading = false;
        });
      }
    });
  }
}
