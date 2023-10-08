import 'package:flutter/material.dart';
import 'package:fuodz/models/tablesModel.dart';
import 'package:fuodz/requests/tables.request.dart';
import 'package:fuodz/views/pages/tables/show_table.dart';

class TablesList extends StatefulWidget {
  const TablesList({Key key}) : super(key: key);

  @override
  _TablesListState createState() => _TablesListState();
}

class _TablesListState extends State<TablesList> {

  List<tablesModel> tables = [];
  TablesRequest re = TablesRequest();

  ScrollController scrollController = ScrollController();
  TextEditingController controller = TextEditingController();

  int page = 1;

  @override
  void initState() {

    scrollController.addListener(onscroll);
    re.getTables(page: page).then((value) => {
      setState(() {
        tables = [];
        tables = value  ;
      })

    });
    super.initState();
  }

  Future onscroll() async{


    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {

      setState(() {
        page++;
      });

      re.getTables(page: page).then((value) => {
        setState(() {

          tables.addAll(value);
        })

      });
    }
  }
  void _showModalSheet(){
    showModalBottomSheet(
        context: context,
        builder: (builder){
          return new Container(
            height: 400.0,

            child: new Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                      Text("new Table",textScaleFactor: 2),
                      TextField(

                        controller: controller ,
                        keyboardType: TextInputType.number ,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          labelText: 'Table Number',
                          fillColor: Colors.white,
                          filled: true,


                        ),



                      ),

                    ElevatedButton(onPressed:(){
                      Navigator.of(context).pop();
                      if(controller.text != ""){
                        re.createTable(int.tryParse(controller.text));

                          setState(() {
                            page = 1;

                          });


                        re.getTables(page: 1).then((value) => {
                          setState(() {
                            tables = [];
                            tables = value  ;
                          })

                        });
                      }

                    } , child: Text("+"))
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(


      appBar: AppBar(


        actions: [


          IconButton(
              onPressed: ()=> {
                _showModalSheet()

          }, icon: Icon(Icons.add)

          )
        ],
      ),

      body: ListView.builder(

        itemCount: tables.length,
        itemBuilder: (BuildContext context, int index)
        {
          return InkWell(
            onTap: ()=>{
              ///ShowTable

            Navigator.push(
            context,
              MaterialPageRoute(builder: (context) =>   ShowTable(table: tables[index],)),
            ) ,
            },
            child: Card(

            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text("${tables[index].tableNumber}"),
                ],
              ),
            ),

        ),
          );



          },),
    );
  }
}
