class ServiceTimeSlotModel {
  int id;
  String slot;

  ServiceTimeSlotModel({this.id = 0, this.slot = ''});

  factory ServiceTimeSlotModel.fromJson(Map<String, dynamic> json) {
    return ServiceTimeSlotModel(id: json['id'], slot: json['slot']);
  }
}
