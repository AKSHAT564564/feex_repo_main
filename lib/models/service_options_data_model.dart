class ServiceOptionsDataModel {
  final int id;
  final String title;
  final int price;

  ServiceOptionsDataModel(
      {required this.id, required this.title, required this.price});
  factory ServiceOptionsDataModel.fromJson(Map<String, dynamic> json) {
    return ServiceOptionsDataModel(
        id: json['id'], title: json['title'], price: json['price']);
  }
}
