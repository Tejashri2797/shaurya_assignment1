import 'package:flutter/material.dart';

import 'SqfliteDatabase.dart';

class StudentList extends StatefulWidget {
  List<Map> data;

  StudentList(this.data, {Key? key}) : super(key: key);

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  SqfLiteDatabase mydb = SqfLiteDatabase();

  @override
  void initState() {
    super.initState();

    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('List',style: TextStyle(color: Colors.black),),
          //centerTitle: true,
          leading: IconButton(

            icon: Icon(Icons.arrow_back_ios_new,color: Colors.black,),onPressed: (){
            Navigator.pop(context);
          },),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 15),
          child: ListView.separated(

            itemCount: widget.data.length,
            itemBuilder: (BuildContext context, int index) =>
                ListTile(

                  leading: const SizedBox(
                    height: 30,
                    width: 30,
                    child: Image(
                        image: AssetImage('Assets/List User.png')),
                  ),
                  title: Text(widget.data[index]['name']),
                  trailing: Text(
                    widget.data[index]['subject'],
                    style: const TextStyle(
                      color: Color(0xFF006A75),
                    ),
                  ),
                ),
           separatorBuilder: (BuildContext context, int index) =>
          const Divider(
              height: 15,
              thickness: 5,
              color: Colors.black12,),


          ),
        ),
      ),
    );
  }
}
