import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fuodz/constants/app_colors.dart';

import 'package:fuodz/view_models/coupons.vm.dart';
import 'package:fuodz/view_models/create.coupons.vm.dart';

import 'package:fuodz/widgets/base.page.dart';
import 'package:fuodz/widgets/busy_indicator.dart';
import 'package:intl/intl.dart';

import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:localize_and_translate/localize_and_translate.dart';


class CreateCouponsPage extends StatefulWidget {
  const CreateCouponsPage({Key key}) : super(key: key);

  @override
  _CreateCouponsPage createState() => _CreateCouponsPage();
}

class _CreateCouponsPage extends State<CreateCouponsPage> {

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreateCouponsViewModel>.reactive(
      viewModelBuilder: () => CreateCouponsViewModel(context),
      onModelReady: (vm) => vm.initialise(),
      builder: (context, vm, child) {
        return BasePage(
          fab: FloatingActionButton.extended(
            backgroundColor: AppColor.primaryColor,
            onPressed: (){

                vm.create();
            },
            label: "Save Coupon".tr().text.white.make(),
            icon: Icon(
              FlutterIcons.plus_fea,
              color: Colors.white,
            ),
          ),
          showAppBar: true,
          showLeadingAction: true ,
          title: "New Coupons".tr() ,
          body: SafeArea(
            child: Container(

              height: MediaQuery.of(context).size.height -20 ,


                  child: ListView(

                    scrollDirection: Axis.vertical,

                      children:   [

                        //code
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                          controller: vm.code,

                          decoration: InputDecoration(
                          fillColor: Colors.grey,
                          filled: true,
                          labelText: "Code".tr(),



                           labelStyle: Theme.of(context).textTheme.bodyText1,
                          contentPadding: EdgeInsets.all(10),
                            ),



                          ),
                        ) ,
                        //Description
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: vm.Description ,
                        maxLines: 4,
                        minLines: 3 ,

                        decoration: InputDecoration(

                          fillColor: Colors.grey,
                          filled: true,
                          labelText: "Description".tr(),



                          labelStyle: Theme.of(context).textTheme.bodyText1,
                          contentPadding: EdgeInsets.all(10),
                        ),



                      ),
                    ) ,


                        //Discount
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: vm.Discount ,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                          fillColor: Colors.grey,
                          filled: true,
                          labelText: "Discount".tr(),



                          labelStyle: Theme.of(context).textTheme.bodyText1,
                          contentPadding: EdgeInsets.all(10),
                        ),



                      ),
                    ) ,
                        //Minimun Order Amount
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: vm.MinimumOrderAmount ,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                          fillColor: Colors.grey,
                          filled: true,
                          labelText: "Minimum Order Amount".tr(),



                          labelStyle: Theme.of(context).textTheme.bodyText1,
                          contentPadding: EdgeInsets.all(10),
                        ),



                      ),
                    ) ,
                        // Maximum coupon amount

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: vm.Maximumcouponamount ,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                          fillColor: Colors.grey,
                          filled: true,
                          labelText: "Maximum coupon amount".tr(),



                          labelStyle: Theme.of(context).textTheme.bodyText1,
                          contentPadding: EdgeInsets.all(10),
                        ),



                      ),
                    ) ,
                        //Times Per Customer

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: vm.TimesPerCustomer ,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                          fillColor: Colors.grey,
                          filled: true,
                          labelText: "Times Per Customer".tr(),



                          labelStyle: Theme.of(context).textTheme.bodyText1,
                          contentPadding: EdgeInsets.all(10),
                        ),



                      ),
                    ) ,

                        //Expires On

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(

                        controller: vm.ExpiresOn ,
                        decoration: InputDecoration(
                          fillColor: Colors.grey,
                          filled: true,
                          labelText: "Expires On".tr(),



                          labelStyle: Theme.of(context).textTheme.bodyText1,
                          contentPadding: EdgeInsets.all(10),
                        ),


                          onTap: () async {


                            DateTime pickedDate = await showDatePicker(
                                 locale: const Locale("en", "EN"),
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2123));

                            if (pickedDate != null) {
                              print(
                                  pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                              String formattedDate =  new DateFormat('yyyy-MM-dd', 'en').format(pickedDate);
                              print(formattedDate); //formatted date output using intl package =>  2021-03-16

                                vm.ExpiresOn.text =  formattedDate; //set output date to TextField value.
                                vm.SelectedTime = formattedDate;
                            } else {}
                          }

                      ),
                    ) ,
                        //Is Percentage?
                        //Active
                        //Vendors
                        //Image




                  ]),



            ),
          ),
        );
      },
    );
  }
}
