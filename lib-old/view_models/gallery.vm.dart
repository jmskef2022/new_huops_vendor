
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fuodz/models/gallery.dart';
import 'package:fuodz/requests/gallery.request.dart';
import 'package:fuodz/services/app.service.dart';
import 'package:fuodz/view_models/base.view_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
class GalleryViewModel extends MyBaseViewModel {

  GalleryViewModel(BuildContext context) {
    this.viewContext = context;
  }

  final ImagePicker picker = ImagePicker();

  GalleryRequest galleryRequest = GalleryRequest();

  List<Gallery> gallery = [];


  int queryPage = 1;
  RefreshController refreshController = RefreshController();
  StreamSubscription refreshOrderStream;


  void initialise() async {
    refreshOrderStream = AppService().refreshAssignedOrders.listen((refresh) {
      if (refresh) {
        fetchMyImages();
      }
    });

    await fetchMyImages();
  }

  dispose() {
    super.dispose();

    if (refreshOrderStream != null) {
      refreshOrderStream.cancel();
    }
  }

  doUplaod() async {

    try{
      setBusy(true);
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      var imageFile = pickedFile.path;
      await galleryRequest.upload(imageFile);
      fetchMyImages(initialLoading : true);
      setBusy(false);
    }catch (e) {
      debugPrint("Image picker error " + e.toString());
    }

  }

  deleteImage( dynamic id )async {

    await galleryRequest.deleteImage(id);
    this.gallery.remove(this.gallery.where((element) =>  id == element.id ).first);
   // fetchMyImages(initialLoading : true);
    notifyListeners();

  }
  fetchMyImages({bool initialLoading = true}) async {
    if (initialLoading) {
      setBusy(true);
      refreshController.refreshCompleted();
      queryPage = 1;
    } else {
      queryPage++;
    }

    try {
      final mImages = await galleryRequest.getVendorGallery(
      );
      if (!initialLoading) {
        gallery.addAll( mImages);
        refreshController.loadComplete();
      } else {
        gallery = mImages;
      }
      clearErrors();
    } catch (error) {
      print("Order Error ==> $error");
      setError(error);
    }

    setBusy(false);
  }


}