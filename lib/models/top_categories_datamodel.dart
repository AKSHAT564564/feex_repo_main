
// Data is in form {
// 'id' : 1,
// 'name' : xyz
//   }  


class TopCategoriesDataModel {
  final int id;
  final String Category;

  TopCategoriesDataModel({required this.id, required this.Category});
 
 //constructor for data model...return id and name of the category

  factory TopCategoriesDataModel.fromJson(Map<String, dynamic> json) {
    
    return TopCategoriesDataModel(id: json['id'], Category: json['name']);
  }
}
