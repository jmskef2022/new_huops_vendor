import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/extensions/dynamic.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/gallery.vm.dart';
import 'package:fuodz/view_models/vendor_details.view_model.dart';
import 'package:fuodz/views/pages/vendor/widgets/request_payout.btn.dart';
import 'package:fuodz/views/pages/vendor/widgets/vendor_sales.chart.dart';
import 'package:fuodz/widgets/base.page.dart';
import 'package:fuodz/widgets/busy_indicator.dart';
import 'package:fuodz/widgets/buttons/custom_button.dart';
import 'package:fuodz/widgets/currency_hstack.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:numeral/numeral.dart';

class GalleyPage extends StatefulWidget {
  const GalleyPage({Key key}) : super(key: key);

  @override
  _GalleyPage createState() => _GalleyPage();
}

class _GalleyPage extends State<GalleyPage> {

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<GalleryViewModel>.reactive(
      viewModelBuilder: () => GalleryViewModel(context),
      onModelReady: (vm) => vm.initialise(),
      builder: (context, vm, child) {
        return BasePage(
          fab: FloatingActionButton.extended(
            backgroundColor: AppColor.primaryColor,
            onPressed: (){

              vm.doUplaod();
            },
            label: "New Image".tr().text.white.make(),
            icon: Icon(
              FlutterIcons.plus_fea,
              color: Colors.white,
            ),
          ),
          showAppBar: true,
          showLeadingAction: true ,
          title: "Gallery".tr() ,
          body: SafeArea(
            child: SmartRefresher(
              enablePullDown: true,
              controller: vm.refreshController,
              onRefresh: () => vm.fetchMyImages(initialLoading: true),
              child: vm.isBusy
                  ? BusyIndicator().centered()
                  : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemCount: vm.gallery.length,

                  itemBuilder : (BuildContext context, int index){

                    return Container(child: Stack(
                      alignment: AlignmentDirectional.bottomEnd ,

                   //   crossAxisAlignment: CrossAxisAlignment.center,
                      //mainAxisSize: MainAxisSize.max,
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                      children : [
                         SizedBox( width: 200 , child: Image.network( vm.gallery[index].path
                         ,
                           fit: BoxFit.fitWidth,
                         )),
                       
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Container(

                               width: 45,
                               height: 45,
                               decoration: BoxDecoration(

                                  color: Colors.white60  ,
                               border: Border.all(
                                 color: Colors.white60,
                               ),
                               borderRadius: BorderRadius.all(Radius.circular(50))) ,  child: IconButton(onPressed: (){
                                  vm.deleteImage(vm.gallery[index].id);

                           }, icon: Icon(Icons.delete ))),
                         )
                      ],
                    ) );
                  }
              ),
            ),
          ),
        );
      },
    );
  }
}
