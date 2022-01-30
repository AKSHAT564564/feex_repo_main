class CustomerDetailsModel {
  final String name;
  final String mobileNumber;
  final String profileImgLink;
  final String email;
  final String gender;
  var dob;
  int id;

  CustomerDetailsModel(
      {this.name = '',
      this.mobileNumber = '',
      this.profileImgLink = '',
      this.email = '',
      this.id = 0,
      this.dob = null,
      this.gender = ''});

  factory CustomerDetailsModel.fromJson(Map<String, dynamic> json) {
    return CustomerDetailsModel(
        name: json['name'],
        mobileNumber: json['mobile_number'],
        email: json['email'],
        id: json['id'],
        profileImgLink: json['profile_img'],
        gender: json['gender'],
        dob: json['dob']);
  }
}

// {
//     "id": 2,
//     "name": "usoof",
//     "mobile_number": "0563858825",
//     "email": "test@test.com",
//     "profile_img": "/media/profile_images/default_img.png"
// }
