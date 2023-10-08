import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fuodz/constants/api.dart';
import 'package:fuodz/models/api_response.dart';
import 'package:fuodz/models/gallery.dart';
import 'package:fuodz/services/auth.service.dart';
import 'package:fuodz/services/http.service.dart';

class GalleryRequest  extends HttpService {



  Future<List<Gallery>> getVendorGallery() async {
    final vendorId = (await AuthServices.getCurrentUser(force: true)).vendor_id;
    final apiResult = await get(
      Api.vendorsgallery+"/$vendorId",
    );

    List<Gallery> r = [];



    if(apiResult.statusCode == 200)
    {
      for (var d in apiResult.data["body"])
      {
        //print(d.toString());
        r.add(Gallery.fromJson(d));
      }
    }

    return r;

  }


  Future<dynamic> upload(String path ) async {

    try{
      final postBody = {

        "vendor_id": AuthServices.currentVendor.id,
      };

      FormData formData = FormData.fromMap(postBody);
      Map fileMap = {};
      File file = File(path);
      String fileName = "images";
      fileMap["images"] =
          MultipartFile(file.openRead(), await file.length(), filename: fileName);
/*
        formData = FormData.fromMap({
        "images":fileMap
        });
      */
      formData.files.addAll([
        MapEntry("images[]", await MultipartFile.fromFile(file.path)),
      ]);

      final respons =    await postWithFiles( Api.vendorsgallery , null , formData: formData , includeHeaders: true );


      print(respons.statusCode);
      print(respons.data.toString());

    }catch (e) {
    print("Image picker error " + e.toString());
    }
  }

  Future<dynamic> deleteImage(dynamic id) async {
    final apiResult = await delete(
      Api.vendorsgallery+"/$id",
    );
  }

  Future<dynamic> getVendorDetails() async {
    final vendorId = (await AuthServices.getCurrentUser(force: true)).vendor_id;
    final apiResult = await get(
      Api.vendorDetails.replaceFirst("id", vendorId.toString()),
    );

    //
    final apiResponse = ApiResponse.fromResponse(apiResult);
    if (apiResponse.allGood) {
      return apiResponse.body;
    } else {
      throw apiResponse.message;
    }
  }

}