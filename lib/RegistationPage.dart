import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:restart_app/restart_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'StudentInfoList.dart';
import 'SqfliteDatabase.dart';
import 'package:flutter/services.dart';

class RegistationPage extends StatefulWidget {
  const RegistationPage({Key? key}) : super(key: key);

  @override
  State<RegistationPage> createState() => _RegistationPageState();
}

class _RegistationPageState extends State<RegistationPage> {
  /// for the image picker
  final ImagePicker _picker = ImagePicker();
  File? file;

  getImage() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    file = File(photo!.path);
    Uint8List? imageInBytes = file?.readAsBytesSync();
    setState(() {});
  }
  getImageFromGallary() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
    file = File(photo!.path);
    setState(() {});
  }



  SqfLiteDatabase obj = SqfLiteDatabase();
  String dropDownDefault = 'Select Subject';
  String dropDownvalue = 'Select Subject';
  List<String> dropDownScienceSubjectList = [
    'Select Subject',
    "Physics",
    "Mathematics",
    "Chemistry",
    "Biology"
  ];

  List<String> dropDownCommerceSubjectList = [
    'Select Subject',
    "Accounts ",
    "Economics",
    "Business studies",
    "Informatics practice"
  ];
  List<String> date = [
    "Date",
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12",
    "13",
    "14",
    "15",
    "16",
    "17"
  ];
  List<String> month = [
    "Month",
    'Jan',
    'Feb',
    'march',
    'april',
    'may',
    'june',
    'july',
    'Aug',
    'sept',
    'oct',
    'Nov',
    'Dec'
  ];
  List<String> year = [
    'Year',
    '1997',
    '1998',
    '2000',
    '2001',
    '2002',
    '2003',
    '2004',
    '2005',
    '2006',
    '2007',
    '2008',
  ];

  String Defaultdate = "Date";
  String Defaultmonth = "Month";
  String Defaultyear = "Year";

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtPass = TextEditingController();
  TextEditingController txtAge = TextEditingController();
  TextEditingController txtDate = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  ///for the invisible password
  bool password = false;
  String male = "Male";
  String female = "Female";
  String selectedGender = "Male";
  String branch = "Science";
  String com = "Commerce";
  String sci = "Science";

  ///for the date Conversion
  bool Ageyear = false;
  String time = '?';
  int currentYear = 0;

  void initState() {
    super.initState();
    DateTime currentDate = DateTime.now();
    time = DateFormat('yyyy').format(currentDate);
    currentYear = int.parse(time);
    obj.createDB();
    //obj.selectData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.tealAccent[100],
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Stack(children: [
                  Container(
                    height: 900,
                    width: 900,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Color(0xFF006A75)),
                  ),
                  Positioned(
                    top: 170,
                    child: Container(
                      height: 730,//MediaQuery.of(context).size.height,
                      width: 392,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50)),
                        color: Color(0xFFD1D1D1),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 35,
                          right: 35
                        ),
                        child: Form(
                            key: formkey,
                            child: Column(
                             // scrollDirection: Axis.vertical,
                              children: [
                                const SizedBox(
                                  height: 50,
                                ),
                                TextFormField(
                                  cursorWidth: 3,
                                  cursorColor: Colors.black,
                                  validator: (value) {
                                    return (value!.isEmpty) ? "Enter Name" : null;
                                  },
                                  controller: txtName,
                                  decoration: InputDecoration(
                                      isCollapsed: true,
                                      hintText: "Student name ",
                                      hintStyle: const TextStyle(
                                          height: 2.3),
                                      prefixIcon: const SizedBox(
                                        height: 5,
                                        width: 5,
                                        child: Image(
                                            image: AssetImage('Assets/Student.png')),
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20),
                                          borderSide: BorderSide.none),
                                      fillColor: Colors.white,
                                      filled: true),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  cursorWidth: 3,
                                  cursorColor: Colors.black,
                                  validator: (value) {
                                    return (value!.isEmpty) ? "Enter Email" : null;
                                  },
                                  controller: txtEmail,
                                  decoration: InputDecoration(
                                      isCollapsed: true,
                                      hintText: "Student Email ",
                                      hintStyle: const TextStyle(
                                          height: 2.3, ),
                                      prefixIcon: const SizedBox(
                                        height: 5,
                                        width: 5,
                                        child: Image(
                                            image: AssetImage('Assets/mail.png')),
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20),
                                          borderSide: BorderSide.none),
                                      fillColor: Colors.white,
                                      filled: true),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  obscureText: password,
                                  cursorWidth: 3,
                                  cursorColor: Colors.black,
                                  validator: (value) {
                                    bool passwordRegx = RegExp(
                                            '^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@\$%^&*-]).{8,}\$')
                                        .hasMatch(txtPass.text);
                                    return (value!.isEmpty)
                                        ? 'Please Enter password'
                                        : (!passwordRegx)
                                            ? 'Please Enter Valid Password'
                                            : null;
                                  },
                                  controller: txtPass,
                                  decoration: InputDecoration(
                                      isCollapsed: true,
                                      hintText: "Student Password",
                                      hintStyle: const TextStyle(
                                          height: 2.3),
                                      prefixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            password = !password;
                                          });
                                        },
                                        icon: Icon(password
                                            ? Icons.lock
                                            : Icons.remove_red_eye_sharp),
                                        color: Colors.black26,
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20),
                                          borderSide: BorderSide.none),
                                      fillColor: Colors.white,
                                      filled: true),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  cursorWidth: 3,
                                  cursorColor: Colors.black,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  validator: (value) {
                                    bool phoneRegx =
                                        RegExp(r'(^(?:[+0]9)?[0-9]{8,10}$)')
                                            .hasMatch(phoneController.text);
                                    return (value!.isEmpty)
                                        ? 'Please Enter phone Number'
                                        : (!phoneRegx)
                                            ? 'Please Enter Valid Number'
                                            : null;
                                  },
                                  controller: phoneController,
                                  decoration: InputDecoration(
                                      isCollapsed: true,
                                      hintText: "Mobile Number ",
                                      hintStyle: const TextStyle(
                                          height: 2.3,),
                                      prefixIcon: Icon(
                                        Icons.call,

                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20),
                                          borderSide: BorderSide.none),
                                      fillColor: Colors.white,
                                      filled: true),
                                ),
                                SizedBox(height: 5,),
                                Padding(
                                  padding: const EdgeInsets.only(right: 16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Text(
                                        "Gender",
                                        style: TextStyle(color: Color(0xFF006A75)),
                                      ),
                                     // SizedBox(width: 0.1,),
                                      Radio(
                                          activeColor: Color(0xFF006A75),
                                          value: male,
                                          groupValue: selectedGender,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedGender = value.toString();
                                            });
                                          }),
                                      Text("Male"),
                                      SizedBox(width: 3,),
                                      Radio(
                                          activeColor: Color(0xFF006A75),
                                          value: female,
                                          groupValue: selectedGender,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedGender = value.toString();
                                            });
                                          }),
                                      Text("Female")
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [

                                    const Text(
                                      "Branch",
                                      style: TextStyle(color: Color(0xFF006A75)),
                                    ),
                                    SizedBox(width: 1.1,),
                                    Radio(
                                        activeColor: Color(0xFF006A75),
                                        value: sci,
                                        groupValue: branch,
                                        onChanged: (val) {
                                          setState(() {
                                            branch = val.toString();
                                          });
                                        }),
                                    const Text("Science"),
                                    Radio(
                                        activeColor: Color(0xFF006A75),
                                        value: com,
                                        groupValue: branch,
                                        onChanged: (val) {
                                          setState(() {
                                            branch = val.toString();
                                          });
                                        }),
                                    const Text("Commerce")
                                  ],
                                ),
                                SizedBox(height: 5,),
                                Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  color: Colors.white,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(left: 10.0, right: 10),
                                    child: Row(
                                      //  mainAxisAlignment:
                                      //  MainAxisAlignment.spaceBetween,
                                      children: [
                                        const SizedBox(
                                          height: 17,
                                          width: 17,
                                          child: Image(
                                              image:
                                                  AssetImage('Assets/Subject.png')),
                                        ),
                                        SizedBox(
                                          width: 60,
                                        ),
                                        DropdownButton( //make true to take width of parent widget
                                          underline: Container(),
                                          dropdownColor: Colors.white,
                                          icon: Icon(Icons.arrow_drop_down_rounded),

                                          value: branch == 'Science'
                                              ? dropDownDefault
                                              : dropDownvalue,
                                          itemHeight: 50,
                                          onChanged: (value) {
                                            setState(() {
                                              if (branch == 'Science') {
                                                dropDownDefault = value.toString();
                                              } else {
                                                dropDownvalue = value.toString();
                                              }
                                            });
                                          },
                                          items: branch == 'Science'
                                              ? dropDownScienceSubjectList
                                                  .map(
                                                    (e) => DropdownMenuItem(
                                                      child: Text(e.toString()),
                                                      value: e.toString(),
                                                    ),
                                                  )
                                                  .toList()
                                              : dropDownCommerceSubjectList
                                                  .map(
                                                    (e) => DropdownMenuItem(
                                                      child: Text(e.toString()),
                                                      value: e.toString(),
                                                    ),
                                                  )
                                                  .toList(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                SizedBox(height: 20,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Expanded(
                                        flex: 1,
                                        child: Text(
                                          "DOB",
                                          style: TextStyle(color: Color(0xFF006A75)),
                                        ),
                                      ),
                                      Container(
                                        height: 40,
                                        width: 85,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: Colors.white,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 13.0),
                                          child: DropdownButton(
                                              isExpanded: true, //make true to take width of parent widget
                                              underline: Container(),
                                              value: Defaultdate,
                                              items: date
                                                  .map((e) => DropdownMenuItem(
                                                        value: e.toString(),
                                                        child: Text(e.toString()),
                                                      ))
                                                  .toList(),
                                              onChanged: (String? value) {
                                                setState(() {
                                                  Defaultdate = value!.toString();
                                                });
                                              }),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        height: 40,
                                        width: 85,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: Colors.white,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 13.0),
                                          child: DropdownButton(
                                              isExpanded: true, //make true to take width of parent widget
                                              underline: Container(),
                                              value: Defaultmonth,
                                              items: month
                                                  .map((e) => DropdownMenuItem(
                                                        value: e.toString(),
                                                        child: Text(e.toString()),
                                                      ))
                                                  .toList(),
                                              onChanged: (String? value) {
                                                setState(() {
                                                  Defaultmonth = value!.toString();
                                                });
                                              }),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Container(
                                        height: 40,
                                        width: 90,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: Colors.white,
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: DropdownButton(
                                            isExpanded: true, //make true to take width of parent widget
                                            underline: Container(),
                                            borderRadius: BorderRadius.circular(10),
                                            onChanged: (value) {
                                              setState(() {
                                                Defaultyear = value!.toString();
                                                txtAge.text =
                                                    '${currentYear - int.parse(Defaultyear)}';
                                                Ageyear = true;
                                              });
                                            },
                                            value: Defaultyear,
                                            items: year
                                                .map((e) => DropdownMenuItem(
                                                      value: e.toString(),
                                                      child: Text(e.toString()),
                                                    ))
                                                .toList(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: txtAge,
                                  decoration: InputDecoration(
                                      isCollapsed: true,
                                      hintText: Ageyear ? txtAge.text : 'Age',
                                      hintStyle: TextStyle(height: 2),
                                      prefixIcon: const Icon(
                                        Icons.calendar_month_sharp,
                                        color: Colors.black26,
                                      ),
                                      fillColor: Colors.white,
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                          20,
                                        ),
                                        borderSide: BorderSide.none,
                                      )),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    MaterialButton(
                                      height: 50,
                                      minWidth: 150,
                                      onPressed: () {
                                        if (formkey.currentState!.validate()) {
                                          obj.insertData(
                                            name: txtName.text,
                                            email: txtEmail.text,
                                            password: txtPass.text,
                                            phoneNumber: phoneController.text,
                                            branch: branch,
                                            gender: selectedGender,
                                            dob:
                                                '${Defaultdate}/${Defaultmonth}/${Defaultyear}',
                                            age: txtAge.text,
                                            subject: branch == 'Science'
                                                ? dropDownDefault
                                                : dropDownvalue,
                                          );
                                          ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(
                                                  content: Text(
                                                      "data inserted Successfully ")));

                                          obj.selectData();
                                          Timer(const Duration(seconds: 2), () async {
                                            SharedPreferences pref =
                                                await SharedPreferences
                                                .getInstance();
                                            pref.setBool('registration', true);

                                            Navigator.pushReplacementNamed(context, 'login');


                                          });

                                        }

                                        else {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(
                                                  content: Text("failed to insert")));
                                        }
                                      },
                                      color: Color(0xFF006A75),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20)),
                                      child: const Text(
                                        'Register',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    MaterialButton(
                                      height: 50,
                                      minWidth: 150,
                                      onPressed: () {
                                        obj.selectData();
                                        Navigator.pushNamed(context, 'StudentInfoList');
                                      },
                                      color: Color(0xFF006A75),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20)),
                                      child: const Text(
                                        'Show List',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),

                              ],
                            )),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 53,
                    left: 220,
                    child: Container(
                        height: 150,
                        width: 140,
                        child: const Image(
                          image: AssetImage('Assets/Group 27.png'),
                          fit: BoxFit.fill,
                        )),
                  ),
                  const Positioned(
                      top: 65,
                      left: 20,
                      child: Text(
                        "Student \n Info",
                        style: TextStyle(fontSize: 40, color: Colors.white,fontWeight: FontWeight.w300),
                      )),
                  Positioned(
                    left: 130,
                    top: 120,
                    child: GestureDetector(
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: file == null
                            ? const AssetImage('Assets/camera.jpg')
                            : FileImage(file!) as ImageProvider,
                      ),

                        onTap: (){
                          showModalBottomSheet(
                              context: context,

                          builder: (context) => Container(
                            height: 150,
                            width: double.infinity,
                            child: Row(

                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                              children: [

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,

                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          getImage();
                                        },
                                        icon: const Icon(
                                          Icons.camera_alt_outlined,
                                          size: 60,
                                            color: Color(0xFF006A75),
                                        )),
                                    const SizedBox(height: 20,),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 28.0),
                                      child: Text("Camera"),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          getImageFromGallary();
                                        },
                                        icon: const Icon(
                                          Icons.photo,
                                          size: 60,
                                          color: Color(0xFF006A75),
                                        )),
                                    SizedBox(height: 20,),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 30.0),
                                      child: Text("Gallary"),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ));},



                      ),
                    ),

                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
