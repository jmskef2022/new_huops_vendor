import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_colors.dart';

import '../../../view_models/booked_table.vm.dart';

class BookedTableDetails extends StatelessWidget {
  int index;
  BookedTableViewModel viewModel;
  BookedTableDetails({Key? key, required this.index, required this.viewModel})
      : super(key: key);
  List<String> statuslable = [
    'Uniformed Reservation',
    'Reservation',
    'Checked Out',
    'Cancelled',
    'No Show',
    'Out Of Order',
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Column(
        children: [
          SizedBox(
            height: 12,
          ),
          Row(
            children: [
              CircleAvatar(
                maxRadius: 40,
                child: CachedNetworkImage(
                  imageUrl: viewModel.bookedTable[index].user?.photo ?? '',
                  height: 40,
                  width: 40,
                  fit: BoxFit.contain,
                  placeholder: (BuildContext, String) => Center(
                    child: CircularProgressIndicator(
                        color: AppColor.shimmerBaseColor),
                  ),
                  errorWidget: (BuildContext, String, dynamic) => Container(
                    child: Icon(
                      Icons.error_outline,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 3,
              ),
              Text(
                viewModel.bookedTable[index].user?.name ?? 'client',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              status(BookedStatus: viewModel.bookedTable[index].status ?? ''),
              lableCard(Icons.date_range_outlined,
                  viewModel.bookedTable[index].time ?? '00:00'),
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: 12,
              ),
              Text(
                'seats',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColor.primaryColor.withOpacity(.6),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Text(
                viewModel.bookedTable[index].number ?? '',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey.withOpacity(.6),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                Icons.group,
                size: 28,
                color: Colors.grey.withOpacity(.6),
              ),
              SizedBox(
                width: 12,
              ),
            ],
          ),
          Divider(
            height: 4,
            color: Colors.grey,
          ),

          Visibility(
            visible: viewModel.bookedTable[index].notes != null &&
                viewModel.bookedTable[index].notes != 'null',
            child: Row(
              children: [
                SizedBox(
                  width: 12,
                ),
                Text(
                  'notes',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColor.primaryColor.withOpacity(.6),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Text(
                  viewModel.bookedTable[index].notes ?? '',
                  maxLines: 4,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.withOpacity(.6),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  Icons.edit_note_sharp,
                  size: 28,
                  color: Colors.grey.withOpacity(.6),
                ),
                SizedBox(
                  width: 12,
                ),
              ],
            ),
          ),

          SizedBox(
            height: 5,
          ),
          Visibility(
              visible: viewModel.bookedTable[index].notes != null &&
                  viewModel.bookedTable[index].notes != 'null',
              child: Divider(
                height: 4,
                color: Colors.grey,
              )),
          Row(
            children: [
              SizedBox(
                width: 12,
              ),
              Text(
                'call',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColor.primaryColor.withOpacity(.6),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Text(
                viewModel.bookedTable[index].user?.phone ?? '',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.withOpacity(.6),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                Icons.phone,
                size: 20,
                color: Colors.grey.withOpacity(.6),
              ),
              SizedBox(
                width: 12,
              ),
            ],
          ),

          Divider(
            height: 4,
            color: Colors.grey,
          ),

          Spacer(),
          Row(
            children: [
              SizedBox(
                width: 12,
              ),
              InkWell(
                onTap: () {},
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  child: Text('change status'),
                ),
              ),
              Spacer(),
              DropdownButton<String>(
                value:
                    viewModel.bookedTable[index].status?.replaceAll("_", " ") ??
                        'Uniformed Reservation',
                items: statuslable.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: (newValue) {
                  String? newStatus = newValue?.replaceAll(" ", "_");
                  viewModel.updateBookedTaable(
                    id: viewModel.bookedTable[index].id ?? 0,
                    status: newStatus ?? '',
                    guests:
                        viewModel.bookedTable[index].number.toString() ?? '0',
                    vendorId: viewModel.bookedTable[index].vendor_id.toString(),
                  );
                  viewModel.notifyListeners();
                },
              ),
              SizedBox(
                width: 12,
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          // Expanded(
          //   child: ListView.builder(
          //     itemCount: 7,
          //     itemBuilder: (context, index) => InkWell(
          //         onTap: () {
          //           //todo change status
          //         },
          //         child: status(BookedStatus: statuslable[index])),
          //   ),
          // )
        ],
      ),
    );
  }
}

Widget status({required String BookedStatus}) {
  Color statusColor = Colors.green;
  String title;
  switch (BookedStatus) {
    case 'Uniformed_Reservation':
      statusColor = Colors.yellow;
      break;
    case 'Reservation':
      statusColor = Colors.red;
      break;
    case 'Pending':
      statusColor = Colors.blue;

      break;
    case 'Checked_Out':
      statusColor = Colors.green;

      break;
    case 'Cancelled':
      statusColor = Colors.black.withOpacity(.8);

      break;
    case 'No_Show':
      statusColor = Colors.black.withOpacity(.8);

      break;
    case 'Out_Of_Order':
      statusColor = Colors.grey.withOpacity(.8);

      break;
  }
  BookedStatus = BookedStatus.replaceAll('_', ' ');
  return Row(
    children: [
      Icon(
        Icons.circle,
        size: 10,
        color: statusColor,
      ),
      Text(
        BookedStatus,
        style: TextStyle(
            fontWeight: FontWeight.bold, color: statusColor.withOpacity(.6)),
      ),
    ],
  );
}

Widget lableCard(IconData icon, String title) => Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      color: AppColor.accentColor.withOpacity(.4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            Text(
              title,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
