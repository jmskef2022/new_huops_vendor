import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/extensions/dynamic.dart';
import 'package:fuodz/utils/ui_spacer.dart';
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

class VendorDetailsPage extends StatefulWidget {
  const VendorDetailsPage({Key key}) : super(key: key);

  @override
  _VendorDetailsPageState createState() => _VendorDetailsPageState();
}

class _VendorDetailsPageState extends State<VendorDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VendorDetailsViewModel>.reactive(
      viewModelBuilder: () => VendorDetailsViewModel(context),
      onModelReady: (vm) => vm.initialise(),
      builder: (context, vm, child) {
        return BasePage(
          body: SafeArea(
            child: SmartRefresher(
              enablePullDown: true,
              controller: vm.refreshController,
              onRefresh: () => vm.fetchVendorDetails(refresh: true),
              child: vm.isBusy
                  ? BusyIndicator().centered()
                  : VStack(
                      [
                        "Vendor Details".tr().text.xl2.semiBold.make().p20(),
                        //online status
                        VStack(
                          [
                            HStack(
                              [
                                "Status".tr().text.medium.lg.make().expand(),
                                ((vm.vendor?.isOpen ?? false)
                                        ? "Open".tr()
                                        : "Close".tr())
                                    .text
                                    .semiBold
                                    .xl
                                    .color((vm.vendor?.isOpen ?? false)
                                        ? AppColor.openColor
                                        : AppColor.closeColor)
                                    .make(),
                              ],
                            ),
                            //
                            CustomButton(
                              title: (vm.vendor?.isOpen ?? false)
                                  ? "Tap to Close".tr()
                                  : "Tap to Open".tr(),
                              color: !(vm.vendor?.isOpen ?? false)
                                  ? AppColor.openColor
                                  : AppColor.closeColor,
                              loading: vm.busy(vm.vendor?.isOpen ?? false),
                              elevation: 0,
                              onPressed: vm.toggleVendorAvailablity,
                            ).h(32).wFull(context).py12(),

                            UiSpacer.divider(),
                          ],
                        ).px20(),

                        //subscription section
                        VStack(
                          [
                            //subscription indicator

                            Visibility(
                              visible: vm.vendor?.useSubscription ?? false,
                              child: HStack(
                                [
                                  "Subscription Status"
                                      .tr()
                                      .text
                                      .medium
                                      .lg
                                      .make()
                                      .expand(),
                                  UiSpacer.hSpace(),
                                  ((vm.vendor?.hasSubscription ?? false)
                                          ? "Subscribed"
                                          : "No Subscription")
                                      .text
                                      .semiBold
                                      .xl
                                      .color(
                                          (vm.vendor?.hasSubscription ?? false)
                                              ? AppColor.openColor
                                              : AppColor.closeColor)
                                      .make(),
                                ],
                              ),
                            ),
                            UiSpacer.vSpace(6),
                            //subscription payment indicator
                            Visibility(
                              visible: (vm.vendor?.useSubscription ?? false) &&
                                  !(vm.vendor?.hasSubscription ?? false),
                              child: HStack(
                                [
                                  "Your subscription has expired"
                                      .tr()
                                      .text
                                      .lg
                                      .white
                                      .make()
                                      .expand(),
                                  CustomButton(
                                    child: "Subscribe"
                                        .tr()
                                        .text
                                        .xl
                                        .medium
                                        .color(Colors.red.shade400)
                                        .makeCentered(),
                                    color: Colors.white,
                                    onPressed: vm.openSubscriptionPage,
                                  ),
                                ],
                              )
                                  .p8()
                                  .box
                                  .color(Colors.red.shade400)
                                  .roundedSM
                                  .make()
                                  .wFull(context),
                            ),
                          ],
                        ).px20().py12(),

                        //
                        VStack(
                          [
                            // transactions/orders stats
                            VendorSalesChart(vm: vm),
                            //total orders
                            HStack(
                              [
                                //
                                "Total Orders"
                                    .tr()
                                    .text
                                    .lg
                                    .white
                                    .make()
                                    .expand(),
                                UiSpacer.horizontalSpace(),
                                "${Numeral(vm.totalOrders).format()}"
                                    .text
                                    .xl
                                    .semiBold
                                    .white
                                    .make(),
                              ],
                            )
                                .p20()
                                .box
                                .rounded
                                .shadow
                                .color(AppColor.accentColor.withOpacity(0.8))
                                .make()
                                .py16(),

                            ////earnings

                            HStack(
                              [
                                //
                                "Total Earnings \n(Currently)"
                                    .tr()
                                    .text
                                    .lg
                                    .white
                                    .make()
                                    .expand(),
                                UiSpacer.horizontalSpace(),
                                CurrencyHStack(
                                  [
                                    "${vm.currencySymbol} "
                                        .text
                                        .xl
                                        .semiBold
                                        .white
                                        .make(),
                                    "${vm.totalEarning.currencyValueFormat()} "
                                        .text
                                        .xl
                                        .semiBold
                                        .white
                                        .make(),
                                  ],
                                ),
                              ],
                            )
                                .p20()
                                .box
                                .rounded
                                .outerShadow
                                .color(AppColor.accentColor)
                                .make(),
                            //request payout
                            RequestPayoutButton(vm: vm),
                            //openImagesGalley()
                            CustomButton(
                              title: "Images Gallery".tr(),
                              onPressed: vm.openImagesGalley,
                            ).py12(),
                            CustomButton(
                              title: "Tables".tr(),
                              onPressed: vm.openTables,
                            ).py12(),


                             CustomButton(
                              title: "Coupons".tr(),
                              onPressed: vm.openImagesCoupons,
                            ).py12(),



                            //vendor details
                            VStack(
                              [
                                //name
                                "Name".tr().text.lg.make(),
                                "${vm.vendor?.name ?? ''}"
                                    .text
                                    .xl
                                    .semiBold
                                    .make()
                                    .pOnly(bottom: Vx.dp12),
                                // address
                                "Address".tr().text.lg.make(),
                                "${vm.vendor?.address ?? ''}"
                                    .text
                                    .xl
                                    .semiBold
                                    .make()
                                    .pOnly(bottom: Vx.dp12),
                              ],
                            )
                                .p20()
                                .box
                                .rounded
                                .color(context.cardColor)
                                .outerShadow
                                .make()
                                .wFull(context)
                                .pOnly(top: Vx.dp12, bottom: Vx.dp32),
                          ],
                        ).px20(),
                      ],
                    ).scrollVertical(),
            ),
          ),
        );
      },
    );
  }

  //
  //
}
