class Coupons {

  dynamic id;
  dynamic code;
  dynamic color;
  dynamic description;
  dynamic discount;
  dynamic min_order_amount;
  dynamic max_coupon_amount;
  dynamic percentage;
  dynamic expires_on;
  dynamic times;
  dynamic is_active;
  dynamic creator_id;
  dynamic vendor_type_id;

  Coupons({this.id,
    this.code,
    this.color,
    this.description,
    this.discount,
    this.min_order_amount,
    this.max_coupon_amount,
    this.percentage,
    this.expires_on,
    this.times,
    this.is_active,
    this.creator_id,
    this.vendor_type_id});


  factory Coupons.fromJson(dynamic jsonObject) {
    final category = Coupons();
    category.id = jsonObject["id"];
    category.code = jsonObject["code"];
    category.color = jsonObject["color"];
    category.description = jsonObject["description"];
    category.discount = jsonObject["discount"];
    category.min_order_amount = jsonObject["min_order_amount"];
    category.max_coupon_amount = jsonObject["max_coupon_amount"];
    category.percentage = jsonObject["percentage"];
    category.expires_on = jsonObject["expires_on"];
    category.times = jsonObject["times"];
    category.is_active = jsonObject["is_active"];
    category.creator_id = jsonObject["creator_id"];
    category.vendor_type_id = jsonObject["vendor_type_id"];

    return category;
  }

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "code": code,
        "color": color,
        "description": description,
        "discount": discount,
        "min_order_amount": min_order_amount,
        "max_coupon_amount": max_coupon_amount,
        "percentage": percentage,
        "expires_on": expires_on,
        "times": times,
        "is_active": is_active,
        "creator_id": creator_id,
        "vendor_type_id": vendor_type_id,


      };

}


class CreateCoupons {

  dynamic code;
  dynamic color;
  dynamic description;
  dynamic discount;
  dynamic min_order_amount;
  dynamic max_coupon_amount;
  dynamic percentage;
  dynamic expires_on;
  dynamic times;


  CreateCoupons({
    this.code,
    this.color,
    this.description,
    this.discount,
    this.min_order_amount,
    this.max_coupon_amount,
    this.percentage,
    this.expires_on,
    this.times
 });
}