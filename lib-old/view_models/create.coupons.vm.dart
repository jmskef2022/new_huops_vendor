import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fuodz/view_models/base.view_model.dart';
import 'package:fuodz/views/pages/coupons/coupons_page.dart';
import 'base.view_model.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/requests/coupons.request.dart';

class CreateCouponsViewModel extends MyBaseViewModel
{

  CouponsRequest couponsRequest = CouponsRequest();
  CreateCouponsViewModel(BuildContext context) {
    this.viewContext = context;
  }


  TextEditingController code = TextEditingController();
  TextEditingController Description = TextEditingController();
  TextEditingController Discount = TextEditingController();
  TextEditingController MinimumOrderAmount = TextEditingController();
  TextEditingController Maximumcouponamount = TextEditingController();
  TextEditingController TimesPerCustomer = TextEditingController();
  TextEditingController ExpiresOn = TextEditingController();
  String SelectedTime = "";

  void initialise() async {
    ExpiresOn.text = "";

  }

   create() async {


     Response d =  await  couponsRequest.createCoupons(code.text, Description.text, Discount.text, MinimumOrderAmount.text, Maximumcouponamount.text, TimesPerCustomer.text, SelectedTime);

     if(d.statusCode == 200 )
     {

       this.viewContext.pop();
       Navigator.pushReplacement(
           viewContext, MaterialPageRoute(builder: (BuildContext context) => CouponsPage()));

     }

  }


  dispose() {
    super.dispose();


  }
}