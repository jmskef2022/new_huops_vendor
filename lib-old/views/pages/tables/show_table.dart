import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fuodz/models/tablesModel.dart';
import 'package:qr_flutter/qr_flutter.dart';



class ShowTable extends StatefulWidget {
  final tablesModel table;
  const ShowTable({Key key, this.table}) : super(key: key);

  @override
  _ShowTableState createState() => _ShowTableState();
}

class _ShowTableState extends State<ShowTable> {




  @override
  void initState() {
    // TODO: implement initState



    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(


      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Center(

        child: Container(

          child: QrImage(
            data: '{ "vendor_id":${widget.table.vendorId} , "table_id":${widget.table.id},  "table_number":${widget.table.tableNumber}  }',
            version: QrVersions.auto,
            size: 400.0,

          ),
        ),
      ),
    );
  }
}
