import 'package:fuodz/view_models/base.view_model.dart';
import 'package:fuodz/view_models/table.reservation.dart';

class BookedTableViewModel extends MyBaseViewModel {
  List<Book> bookedTable = [];
  updateBookedTaable(
      {required int id,
      required String status,
      required String guests,
      required String vendorId}) async {
    await TableReservation()
        .updateOrder(id: id, status: status, guest: guests, vendorId: vendorId)
        .then((value) {
      print(value);
      TableReservation().getReservation().then((value) {
        notifyListeners();
      });
    });
  }

  getReservation() async {
    bookedTable = await TableReservation().getReservation();
    return bookedTable;
  }
}
