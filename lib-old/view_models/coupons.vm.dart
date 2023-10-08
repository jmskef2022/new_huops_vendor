
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_routes.dart';
import 'package:fuodz/models/coupons.dart';

import 'package:fuodz/requests/coupons.request.dart';

import 'package:fuodz/services/app.service.dart';
import 'package:fuodz/view_models/base.view_model.dart';

import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
class CouponsViewModel extends MyBaseViewModel {


  CouponsRequest couponsRequest = CouponsRequest();
  List<Coupons> coupons = [];
  List<DataRow> couponsRows = [];
  

  int queryPage = 1;
  RefreshController refreshController = RefreshController();
  StreamSubscription refreshOrderStream;






  CouponsViewModel(BuildContext context)
  {
    this.viewContext = context;
  }


  void initialise() async {
    refreshOrderStream = AppService().refreshAssignedOrders.listen((refresh) {
      if (refresh) {
        fetch();
      }
    });

    await fetch();
  }

  dispose() {
    super.dispose();

    if (refreshOrderStream != null) {
      refreshOrderStream.cancel();
    }
  }

  oneNewPage(BuildContext context ) async {


      await Navigator.pushNamed(context , AppRoutes.NewCouponsPage );
      notifyListeners();


  }
  delete( dynamic id )async {

    await couponsRequest.deleteCoupons(id);
    fetch(initialLoading : true);


  }

  fetch({bool initialLoading = true}) async {
    if (initialLoading) {
      setBusy(true);
      refreshController.refreshCompleted();
      queryPage = 1;
    } else {
      queryPage++;
    }

    try {
      final mImages = await couponsRequest.getVendorCoupons(
      );

    
      
      if (!initialLoading) {
        
        coupons.addAll( mImages);
        refreshController.loadComplete();
      } else {
        
        coupons = mImages;
      }


      
      couponsRows.clear();

      /*
        for(Coupons coup in coupons){
          couponsRows.add(DataRow(

              cells: [


              //  DataCell(   Text("#${coup.id}"),),
                DataCell(   Text("${coup.code}"),),
                DataCell(   Text("${coup.description}"),),
                DataCell(   Text("${coup.discount}"),),
                DataCell(   Icon(Icons.delete),),
              ]

          ));
        }

    */
      
      
      clearErrors();
    } catch (error) {
      print("Order Error ==> $error");
      setError(error);
    }

    setBusy(false);
  }


}