class tablesModel {
  int id;
  int vendorId;
  int tableNumber;

  tablesModel({this.id, this.vendorId, this.tableNumber});

  tablesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['vendor_id'];
    tableNumber = json['table_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vendor_id'] = this.vendorId;
    data['table_number'] = this.tableNumber;
    return data;
  }
}