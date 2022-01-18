class CustomerDetailsModel {
  final String name;
  final String mobileNumber;
  final String profileImgLink;
  final String email;
  var id;

  CustomerDetailsModel(
      {this.name = '',
      this.mobileNumber = '',
      this.profileImgLink = '',
      this.email = '',
      this.id = ''});

  factory CustomerDetailsModel.fromJson(Map<String, dynamic> json) {
    return CustomerDetailsModel(
        name: json['name'],
        mobileNumber: json['mobile_number'],
        email: json['email'],
        id: json['id'],
        profileImgLink: json['profile_img']);
  }
}
