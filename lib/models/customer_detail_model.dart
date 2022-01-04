class CustomerDetailsModel {
  final String name;
  final String mobileNumber;
  final String profileImgLink;

  CustomerDetailsModel(
      {this.name = '', this.mobileNumber = '', this.profileImgLink = ''});

  factory CustomerDetailsModel.fromJson(Map<String, dynamic> json) {
    return CustomerDetailsModel(
        name: json['name'],
        mobileNumber: json['mobile_number'],
        profileImgLink: json['profile_img']);
  }
}
