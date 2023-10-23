import 'package:flutter/cupertino.dart';
import 'package:fuodz/constants/api.dart';
import 'package:fuodz/models/api_response.dart';
import 'package:fuodz/models/user.dart';
import 'package:fuodz/models/vendor.dart';
import 'package:fuodz/services/http.service.dart';

class TableReservation extends HttpService {
  //

  Future<List<Book>> getReservation(
      {int page = 1, Map<String, dynamic>? params}) async {
    final apiResult = await get(
      Api.getTableReservation,
      queryParameters: {
        "page": page,
        ...(params != null ? params : {}),
      },
    );

    //
    debugPrint(apiResult.toString());
    final apiResponse = ApiResponse.fromResponse(apiResult);

    if (apiResponse.allGood) {
      List<Book> orders = [];
      List<dynamic> jsonArray =
          (apiResponse.body is List) ? apiResponse.body : apiResponse.data;
      for (var jsonObject in jsonArray) {
        try {
          orders.add(Book.fromJSON(jsonObject));
        } catch (e) {
          print(e);
        }
      }

      return orders;
    } else {
      throw apiResponse.message!;
    }
  }

  //

  //
  Future<String> updateOrder(
      {int? id, String? status, String? guest, String? vendorId}) async {
    print(vendorId);
    final apiResult = await put(Api.upadteTableReservation + "/$id", {
      'vendor_id': vendorId,
      "status": status,
      "number_of_guests": int.parse(guest ?? '0'),
    });
    //
    final apiResponse = ApiResponse.fromResponse(apiResult);
    if (apiResponse.allGood) {
      return apiResponse.message!;
    } else {
      throw apiResponse.message!;
    }
  }
}

class Book {
  int? id;
  String? time;
  String? vendor_id;
  Vendor? vendor;
  User? user;

  String? number;
  String? status;
  String? notes;

  Book();

  factory Book.fromJSON(dynamic json) {
    final book = Book();
    book.id = json["id"];
    book.time = json["arrival_time"];
    book.status = "${json["status"]}";
    book.notes = "${json["notes"]}";
    book.vendor_id = json['vendor_id'].toString();
    book.number = "${json["number_of_guests"]}";
    book.vendor =
        json["vendor"] != null ? Vendor.fromJson(json["vendor"]) : null;
    book.user = json["user"] != null ? User.fromJson(json["user"]) : null;

    return book;
  }
}
