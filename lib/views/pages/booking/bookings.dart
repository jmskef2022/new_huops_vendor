import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/view_models/table.reservation.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:stacked/stacked.dart';

import '../../../view_models/booked_table.vm.dart';
import 'booked_table_details.dart';
// import 'package:fuodz/view_models/table.reservation.dart';
// import 'package:fuodz/widgets/custom_general_navbar.dart';

class Bookings extends StatefulWidget {
  const Bookings({Key? key}) : super(key: key);

  @override
  _BookingsState createState() => _BookingsState();
}

class _BookingsState extends State<Bookings> {
  TableReservation services = TableReservation();

  void EditBooked(
      {required int index, required BookedTableViewModel viewModel}) {
    showDialog(
        context: context,
        builder: (context) => ViewModelBuilder<BookedTableViewModel>.reactive(
            viewModelBuilder: () => viewModel,
            disposeViewModel: false,
            builder: (context, vm, child) {
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 120),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: BookedTableDetails(
                  index: index,
                  viewModel: vm,
                ),
              );
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // decoration: BoxDecoration(
        //   gradient: AppColor.LightBg,
        // ),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(),
            body: ViewModelBuilder<BookedTableViewModel>.reactive(
                createNewViewModelOnInsert: false,
                viewModelBuilder: () => BookedTableViewModel(),
                onViewModelReady: (vm) => vm.initialise(),
                builder: (context, vm, child) {
                  return FutureBuilder(
                    future: vm.getReservation(),
                    //services.getReservation(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      print(snapshot);

                      return snapshot.connectionState == ConnectionState.waiting
                          ? Center(
                              child: CircularProgressIndicator(
                                color:
                                    AppColor.shimmerBaseColor.withOpacity(.8),
                              ),
                            )
                          : snapshot.hasData
                              ? ListView.builder(
                                  itemCount: snapshot.data?.length ?? 0,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Slidable(
                                      key: ValueKey(
                                          snapshot.data?[index].user.id),
                                      startActionPane: ActionPane(
                                        motion: ScrollMotion(),
                                        children: [
                                          // A SlidableAction can have an icon and/or a label.
                                          SlidableAction(
                                            backgroundColor: Colors.transparent,
                                            onPressed: (_) {
                                              EditBooked(
                                                  index: index, viewModel: vm);
                                            },
                                            foregroundColor: Color(0xFFFE4A49),
                                            icon: Icons.edit,
                                            label: 'edit'.tr(),
                                          ),
                                        ],
                                      ),
                                      child: Card(
                                        elevation: 4,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                  "client : ${snapshot.data?[index].user.name}"),
                                              Divider(),
                                              Text(
                                                  "time : ${snapshot.data?[index].time}"),
                                              Divider(),
                                              Text(
                                                  "guests :   ${snapshot.data?[index].number}"),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : Container();
                    },
                  );
                })),
      ),
    );
  }
}
