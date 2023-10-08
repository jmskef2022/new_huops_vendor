import 'package:dio/dio.dart';
import 'package:fuodz/constants/api.dart';
import 'package:fuodz/models/coupons.dart';
import 'package:fuodz/services/auth.service.dart';
import 'package:fuodz/services/http.service.dart';

class CouponsRequest  extends HttpService {


  Future<List<Coupons>> getVendorCoupons() async {
    final vendorId = (await AuthServices.getCurrentUser(force: true)).vendor_id;
    final apiResult = await get(
      Api.vendorcoupons,
    );

    List<Coupons> r = [];


    print(apiResult.data.toString());
    if(apiResult.statusCode == 200)
    {

      for (var d in apiResult.data["body"])
      {

        r.add(Coupons.fromJson(d));
      }
    }

    return r;

  }


  Future<Response> createCoupons (
        dynamic code ,
        dynamic Description ,
        dynamic Discount ,
        dynamic MinimumOrderAmount ,
        dynamic Maximumcouponamount ,
        dynamic TimesPerCustomer ,
        dynamic ExpiresOn ,


      ) async {


    Map<String , dynamic> map = Map<String , dynamic>();

    map["code"] = code;
    map["description"] = Description;
    map["discount"] = Discount;
    map["min_order_amount"] = MinimumOrderAmount;
    map["max_coupon_amount"] = Maximumcouponamount;
    map["times"] = TimesPerCustomer;
    map["expires_on"] = ExpiresOn;

    final apiResult = await post(
      Api.vendorcoupons,
        map, includeHeaders: true
    );



    return apiResult;

  }




  Future<dynamic> deleteCoupons(dynamic id) async {
    final apiResult = await delete(
      Api.vendorcoupons+"/$id",
    );
  }
}