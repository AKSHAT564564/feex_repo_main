



class CategoriesDataModel {
  final int id;
  final String Category;

  CategoriesDataModel({required this.id, required this.Category});
 
 //constructor for data model...return id and name of the category

  factory CategoriesDataModel.fromJson(Map<String, dynamic> json) {
    
    return CategoriesDataModel(id: json['id'], Category: json['name']);
  }
}
