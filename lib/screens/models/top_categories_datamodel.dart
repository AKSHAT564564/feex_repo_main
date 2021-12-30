class TopCategoriesDataModel {
  final int id;
  final String Category;

  TopCategoriesDataModel({required this.id, required this.Category});
  factory TopCategoriesDataModel.fromJson(Map<String, dynamic> json) {
    return TopCategoriesDataModel(id: json['id'], Category: json['name']);
  }
}
