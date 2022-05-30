import 'package:ayikie_service/src/models/images.dart';

class User {
  String name;
  String address;
  String email;
  String phone;
  int role;
  Images imgUrl;

  int verifyFb;
  int verifyLinkedIN;
  int verifyCreditCard;
  int verifyAddress;
  int verifyEmail;
  int verifyid;
  int verifyCompany;
  int verifyTax;
  int verifySkill;
  

  User(
      {required this.name,
      required this.address,
      required this.email,
      required this.phone,
      required this.role,
      required this.imgUrl,
      this.verifyAddress = 0,
      this.verifyEmail = 0,
      this.verifyCreditCard = 0,
      this.verifyFb = 0,
      this.verifyCompany = 0,
      this.verifyLinkedIN = 0,
      this.verifyTax = 0,
      this.verifySkill = 0,
      this.verifyid = 0});

  List<int> getVerifiedList() {
    List<int> getList = [];
    getList.add(verifyEmail);
    getList.add(verifyFb);
    getList.add(verifyLinkedIN);
    getList.add(verifyCreditCard);
    getList.add(verifyAddress);
    getList.add(verifyCompany);
    getList.add(verifyTax);
    getList.add(verifySkill);
    getList.add(verifyid);
    return getList;
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] == null ? "" : json['name'],
      address: json['address'] == null ? "" : json['address'],
      email: json['email'] == null ? "" : json['email'],
      phone: json['phone'] == null ? "" : json['phone'],
      verifyAddress: json['verify_address'],
      verifyCreditCard: json['verify_credit_card'],
      verifyFb: json['verify_facebook'],
      verifyLinkedIN: json['verify_linkedin'],
      verifyid: json['verify_id'],
      verifyEmail: json['verify_email'],
      verifyCompany: json['verify_company_registration'],
      verifySkill: json['verify_skill'],
      verifyTax: json['verify_tax'],
      role: json['role'],
      imgUrl: json['images'] != null ? Images.fromJson(json['images']):Images(id: 1, imageName: "https://ayikie.cyberelysium.app/img/logo/logo.png"),
    );
  }
}
