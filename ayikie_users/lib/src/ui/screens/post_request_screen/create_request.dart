import 'package:ayikie_users/src/api/api_calls.dart';
import 'package:ayikie_users/src/app_colors.dart';
import 'package:ayikie_users/src/models/buyerRequest.dart';
import 'package:ayikie_users/src/models/dropdown.dart';
import 'package:ayikie_users/src/ui/screens/drawer_screen/drawer_screen.dart';
import 'package:ayikie_users/src/ui/screens/notification_screen/notification_screen.dart';
import 'package:ayikie_users/src/ui/widget/custom_form_field.dart';
import 'package:ayikie_users/src/ui/widget/primary_button.dart';
import 'package:ayikie_users/src/ui/widget/progress_view.dart';
import 'package:ayikie_users/src/utils/alerts.dart';
import 'package:ayikie_users/src/utils/validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateRequestScreen extends StatefulWidget {
  final BuyerRequest? buyerRequest;

  CreateRequestScreen({Key? key, this.buyerRequest}) : super(key: key);

  @override
  _CreateRequestScreenState createState() => _CreateRequestScreenState();
}

class _CreateRequestScreenState extends State<CreateRequestScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _periodController = TextEditingController();
  TextEditingController _budgetController = TextEditingController();

  List<Dropdown> serviceCategories = [];
  List<Dropdown> serviceSubCategories = [];

  late Dropdown selectedServiceCategory;
  late Dropdown selectedSubServiceCategory;

  bool _isLoading = true;
  bool _isUpdate = false;

  @override
  void initState() {
    super.initState();
    if (widget.buyerRequest != null) {
      setBuyerDetails();
    }
    _getServiceCategory();
  }

  void setBuyerDetails() {
    _titleController.text = widget.buyerRequest!.title;
    _locationController.text = widget.buyerRequest!.location;
    _descriptionController.text = widget.buyerRequest!.description;
    _periodController.text = widget.buyerRequest!.duration.toString();
    _budgetController.text = widget.buyerRequest!.price.toString();
    setState(() {
      _isUpdate = true;
    });
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
          if(_isUpdate && dropdown.id == widget.buyerRequest!.categoryId){
            selectedServiceCategory=dropdown;
          }
          serviceCategories.add(dropdown);
        }
        if(!_isUpdate){
          selectedServiceCategory = serviceCategories[0];
        }
        _getSubServiceCategory(selectedServiceCategory.id);
      } else {
        Alerts.showMessage(context, "Something went wrong. Please try again.",
            title: "Oops!");
      }
    });
  }

  void _getSubServiceCategory(int categoryId) async {
    await ApiCalls.getSubServicesDropdown(categoryId: categoryId)
        .then((response) {
      if (!mounted) {
        return;
      }
      if (response.isSuccess) {
        var data = response.jsonBody;
        serviceSubCategories.clear();
        for (var item in data) {
          Dropdown dropdown = Dropdown.fromJson(item);
          if(_isUpdate && dropdown.id == widget.buyerRequest!.subCategoryId){
            selectedSubServiceCategory=dropdown;
          }
          serviceSubCategories.add(dropdown);
        }
        if(!_isUpdate){
          selectedSubServiceCategory = serviceSubCategories[0];
        }
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
    _titleController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    _periodController.dispose();
    _budgetController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.black),
        backgroundColor: AppColors.white,
        elevation: 0,
        title: Text(
          _isUpdate?'Update Post':'Post a Request',
          style: TextStyle(color: Colors.black),
        ),
        leading: Container(
          width: 24,
          height: 24,
          child: new IconButton(
            icon: new Icon(
              Icons.arrow_back_ios,
              color: AppColors.black,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        actions: [
          Builder(
            builder: (context) => GestureDetector(
              onTap: () => Scaffold.of(context).openEndDrawer(),
              child: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return NotificationScreen();
                          }),
                        );
                      },
                      child: Container(
                        width: 26,
                        height: 26,
                        child: new Icon(
                          Icons.notifications_none,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: 26,
                      height: 26,
                      child: RotationTransition(
                        turns: AlwaysStoppedAnimation(180 / 360),
                        child: Image.asset(
                          'asserts/icons/menu.png',
                          scale: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      endDrawer: DrawerScreen(),
      body: _isLoading
          ? Center(
              child: ProgressView(),
            )
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(left: 16, right: 16, top: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.only(top: 20, bottom: 10, left: 5),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Title',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700),
                      ),
                    ),
                    CustomFormField(
                      controller: _titleController,
                      hintText: 'Enter title here',
                      inputType: TextInputType.text,
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 10,bottom: 10, left: 5),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Location',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700),
                      ),
                    ),
                    CustomFormField(
                      controller: _locationController,
                      hintText: 'Enter your location',
                      inputType: TextInputType.text,
                    ),
                    Container(
                      padding:
                          const EdgeInsets.only(top: 20, bottom: 10, left: 5),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Category',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700),
                      ),
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
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
                    ),
                    Container(
                      padding:
                          const EdgeInsets.only(top: 20, bottom: 10, left: 5),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Sub Category',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700),
                      ),
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
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
                            selectedSubServiceCategory = newValue!;
                          },
                        ),
                      ),
                    ),
                    Container(
                      padding:
                          const EdgeInsets.only(top: 20, bottom: 10, left: 5),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Description',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700),
                      ),
                    ),
                    CustomFormField(
                      controller: _descriptionController,
                      hintText: 'Enter description here',
                      inputType: TextInputType.text,
                    ),
                    Container(
                      padding:
                          const EdgeInsets.only(top: 20, bottom: 10, left: 5),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Delivery Period',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700),
                      ),
                    ),
                    CustomFormField(
                      controller: _periodController,
                      hintText: 'Enter delivery period here',
                      inputType: TextInputType.number,
                    ),
                    Container(
                      padding:
                          const EdgeInsets.only(top: 20, bottom: 10, left: 5),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Budget',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700),
                      ),
                    ),
                    CustomFormField(
                      controller: _budgetController,
                      hintText: 'Enter your budget here',
                      inputType: TextInputType.number,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    PrimaryButton(
                        text: _isUpdate?'Update Post':'Post',
                        fontSize: 16, clickCallback: _addService),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  void _addService() async {
    String title = _titleController.text.trim();
    String location = _locationController.text.trim();
    String des = _descriptionController.text.trim();
    String budget = _budgetController.text.trim();
    String period = _periodController.text.trim();

    if (!Validations.validateString(title)) {
      Alerts.showMessage(context, "Enter your title");
      return;
    }
    if (!Validations.validateString(location)) {
      Alerts.showMessage(context, "Enter your Location");
      return;
    }
    if (!Validations.validateString(des)) {
      Alerts.showMessage(context, "Enter your short description");
      return;
    }
    if (!Validations.validateString(period)) {
      Alerts.showMessage(context, "Enter your delivery Period");
      return;
    }
    if (!Validations.validateString(budget)) {
      Alerts.showMessage(context, "Enter your budget");
      return;
    }

    setState(() {
      _isLoading = true;
    });
    (!_isUpdate)
        ? ApiCalls.createBuyerRequest(
                title: title,
                location: location,
                description: des,
                price: double.parse(budget),
                duration: period,
                categoryId: selectedServiceCategory.id,
                subCategoryId: selectedSubServiceCategory.id)
            .then((response) async {
            if (!mounted) {
              return;
            }
            if (response.isSuccess) {
              Alerts.showMessage(context, "Request updated successfully.",
                  title: "Success!",
                  onCloseCallback: () =>
                      {Navigator.pop(context), Navigator.pop(context)});
            } else {
              Alerts.showMessageForResponse(context, response);
              setState(() {
                _isLoading = false;
              });
            }
          })
        : ApiCalls.updateBuyerRequest(
                requestId: widget.buyerRequest!.id,
                title: title,
                location: location,
                description: des,
                price: double.parse(budget),
                duration: period,
                categoryId: selectedServiceCategory.id,
                subCategoryId: selectedSubServiceCategory.id)
            .then((response) async {
            if (!mounted) {
              return;
            }
            if (response.isSuccess) {
              Alerts.showMessage(context, "Request added successfully.",
                  title: "Success!",
                  onCloseCallback: () =>
                      {Navigator.pop(context), Navigator.pop(context)});
            } else {
              Alerts.showMessageForResponse(context, response);
              setState(() {
                _isLoading = false;
              });
            }
          });
  }
}
