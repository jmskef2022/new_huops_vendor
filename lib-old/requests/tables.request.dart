import 'package:flutter/material.dart';
import 'package:fuodz/constants/api.dart';
import 'package:fuodz/models/api_response.dart';
import 'package:fuodz/models/order.dart';
import 'package:fuodz/models/tablesModel.dart';
import 'package:fuodz/services/auth.service.dart';
import 'package:fuodz/services/http.service.dart';

class TablesRequest extends HttpService {
  //
  Future<List<tablesModel>> getTables({
    int page = 1,
    String status,
    String type,
  }) async {
    final vendorId = (await AuthServices.getCurrentUser()).vendor_id;

    final apiResult = await get(
      Api.tables,
      queryParameters: {
        "vendor_id": vendorId,
        "page": page,
        "status": status,
      },
    );



    final apiResponse = ApiResponse.fromResponse(apiResult);
    if (apiResponse.allGood) {
      return apiResponse.data.map((jsonObject) {

        return tablesModel.fromJson(jsonObject);
      }).toList();
    } else {
      throw apiResponse.message;
    }
  }


  Future createTable(int number) async{
    final vendorId = (await AuthServices.getCurrentUser()).vendor_id;
    final apiResult = await post(Api.tables, {
      "vendor_id": vendorId,
      "number" : number ,
    });
    debugPrint(apiResult.data.toString());
    final apiResponse = ApiResponse.fromResponse(apiResult);




  }


}
