class ServiceDetailsDataModel {
  final int serviceId;
  final int categoryId;
  final String serviceName;
  final String iconUrl;

  ServiceDetailsDataModel(
      {required this.serviceId,
      required this.serviceName,
      required this.categoryId,
      required this.iconUrl});

  factory ServiceDetailsDataModel.fromJson(Map<String, dynamic> json) {
    return ServiceDetailsDataModel(
        serviceId: json['id'],
        serviceName: json['name'],
        categoryId: json['category'],
        iconUrl: json['service_icon']);
  }
}
