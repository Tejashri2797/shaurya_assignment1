import 'package:flutter/material.dart';

import 'SqfliteDatabase.dart';

class StudentInfoList extends StatefulWidget {
  List data;

  StudentInfoList(this.data, {Key? key}) : super(key: key);

  @override
  State<StudentInfoList> createState() => _StudentInfoListState();
}

class _StudentInfoListState extends State<StudentInfoList> {
  SqfLiteDatabase mydb = SqfLiteDatabase();

  @override
  void initState() {
    super.initState();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: (){
          Navigator.pushNamed(context, 'registration');

        },
          backgroundColor: Color(0xFF006A75) ,
        child: const Icon(Icons.add,),),
        appBar: AppBar(
          leading: Icon(Icons.add,),
         // centerTitle: true,
          title: const Text(
            'List',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
          ),
          backgroundColor:  Colors.white
        ),
        body: ListView.separated(
          itemCount: widget.data.length,
          itemBuilder: (BuildContext context, index) => Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Container(
              height: 120,
              width: double.infinity,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                  //  backgroundColor: Colors.deepPurpleAccent,
                    radius: 30,
                    backgroundImage: AssetImage('Assets/List User.png'),

                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, left: 20),
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Name : ",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(widget.data[index]['name'],
                                style: TextStyle(fontSize: 18))
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Mob : ",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(widget.data[index]['phoneNumber'],
                                style: TextStyle(fontSize: 18))
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Branch : ",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(widget.data[index]['branch'],
                                style: TextStyle(fontSize: 18))
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 110.0),
                          child: Row(
                            //mainAxisAlignment: MainAxisAlignment.end,

                            children: [
                              Text(
                                'dob : ',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text(widget.data[index]['dob'],
                                  style: TextStyle(fontSize: 18))
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          separatorBuilder: (BuildContext context, int index) => Divider(
            height: 2,
            thickness: 5,
            color: Colors.blueGrey.shade300,
          ),
        ),
      ),
    );
  }
}
