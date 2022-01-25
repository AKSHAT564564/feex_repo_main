class ServiceDetailsDataModel {
  int serviceId;
  int categoryId;
  String serviceName;
  String iconUrl;

  ServiceDetailsDataModel(
      {required this.serviceId,
      required this.serviceName,
      this.categoryId = 0,
      this.iconUrl = ''});

  factory ServiceDetailsDataModel.fromJson(Map<String, dynamic> json) {
    
    return ServiceDetailsDataModel(
        serviceId: json['id'],
        serviceName: json['name'],
        categoryId: json['category'],
        iconUrl: json['service_icon']);
  }
}
