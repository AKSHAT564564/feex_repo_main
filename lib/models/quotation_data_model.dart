import 'dart:convert';

class QuotationDataModel {
  int id;
  List solution;
  String comment;
  int price;

  QuotationDataModel(
      {required this.id,
      required this.solution,
      required this.price,
      this.comment = ''});

  factory QuotationDataModel.fromJson(Map<String, dynamic> jsonData) {
    //first storing it as a list
    // see sample response

    return QuotationDataModel(
        id: jsonData['id'],
        solution: jsonData['solution'],
        price: jsonData['price'],
        comment: jsonData['comments']);
  }
}

// {
//     "id": 2,
//     "solution": [
//         "1 - compressor",
//         "Change fan",
//         "Fix electric parts"
//     ],
//     "comments": "Needs a lot of changes",
//     "price": 200
// }
