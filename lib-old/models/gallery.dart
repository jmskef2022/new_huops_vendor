class Gallery {
  int id;
  int vendorId;
  int order;
  String path;
  String createdAt;
  String updatedAt;

  Gallery(
      {this.id,
        this.vendorId,
        this.order,
        this.path,
        this.createdAt,
        this.updatedAt});

  Gallery.fromJson(Map<String, dynamic> json) {
    //


    id = json['id'];
    vendorId = json['vendor_id'];
    order = json['order'];
    path = json['path'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vendor_id'] = this.vendorId;
    data['order'] = this.order;
    data['path'] = this.path;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}