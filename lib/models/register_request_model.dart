class RegisterRequestModel {
  String? fullname;
  String? address;
  String? taluka;
  String? village;
  String? pincode;
  String? dateofbirth;
  String? phone;
  String? email;
  String? password;

  RegisterRequestModel({this.fullname, this.address, this.taluka, this.village, this.pincode, this.dateofbirth, this.phone, this.email, this.password});

  RegisterRequestModel.fromJson(Map<String, dynamic> json) {
    fullname = json['full_name'];
    address = json['address'];
    taluka = json['taluka'];
    village = json['village'];
    pincode = json['pincode'];
    dateofbirth = json['date_of_birth'];
    phone = json['phone'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['full_name'] = fullname;
    data['address'] = address;
    data['taluka'] = taluka;
    data['village'] = village;
    data['pincode'] = pincode;
    data['date_of_birth'] = dateofbirth;
    data['phone'] = phone;
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}