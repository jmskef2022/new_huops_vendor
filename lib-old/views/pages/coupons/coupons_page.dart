import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fuodz/constants/app_colors.dart';

import 'package:fuodz/view_models/coupons.vm.dart';

import 'package:fuodz/widgets/base.page.dart';
import 'package:fuodz/widgets/busy_indicator.dart';

import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:localize_and_translate/localize_and_translate.dart';


class CouponsPage extends StatefulWidget {
  const CouponsPage({Key key}) : super(key: key);

  @override
  _CouponsPage createState() => _CouponsPage();
}

class _CouponsPage extends State<CouponsPage> {

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CouponsViewModel>.reactive(
      viewModelBuilder: () => CouponsViewModel(context),
      onModelReady: (vm) => vm.initialise(),
      builder: (context, vm, child) {
        return BasePage(
          fab: FloatingActionButton.extended(
            backgroundColor: AppColor.primaryColor,
            onPressed: (){

               vm.oneNewPage(context);
            },
            label: "New Coupons".tr().text.white.make(),
            icon: Icon(
              FlutterIcons.plus_fea,
              color: Colors.white,
            ),
          ),
          showAppBar: true,
          showLeadingAction: true ,
          title: "Coupons".tr() ,
          body: SafeArea(
            child: SmartRefresher(
              enablePullDown: true,
              controller: vm.refreshController,
              onRefresh: () => vm.fetch(initialLoading: true),
              child: vm.isBusy
                  ? BusyIndicator().centered()
                  : ListView.builder(


                    itemCount: vm.coupons.length,

                    itemBuilder: (BuildContext context , int index)   {

                      return VStack(
                        [
                          //
                          "#${vm.coupons[index].code}".text.xl.medium.make(),
                          //amount and total products
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                          children: [


                              "${vm.coupons[index].discount}%"
                                  .text
                                  .xl
                                  .semiBold
                                  .make(),

                              IconButton(

                                  icon :
                                  Icon(Icons.delete_forever), onPressed: () {

                                    vm.delete(vm.coupons[index].id);
                              },),


                          ],
                          ),
                          //time & status
                          HStack(
                            [
                              //time
                              Text(vm.coupons[index].expires_on).expand()
                            ],
                          ),
                        ],
                      )
                          .p12()
                          .onInkTap(null)
                          .card
                          .elevation(1)
                          .clip(Clip.antiAlias)
                          .roundedSM
                          .make();

                    },

                /*    child: DataTable(

                      columns: [



                   //  DataColumn(label: Text("#ID")),

                       DataColumn(label:  Text("Code") ),

                       DataColumn(label:   Text("Description") ),

                        DataColumn(label:   Text("Discount") ),

                        DataColumn(label:   Text("Action") ),




                      ],


                      rows: vm.couponsRows ,
                    ), */
                  ),
            ),
          ),
        );
      },
    );
  }
}
