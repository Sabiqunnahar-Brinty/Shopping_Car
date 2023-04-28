// import 'package:flutter/material.dart';
//
// class Register extends StatefulWidget {
//   const Register({Key? key}) : super(key: key);
//
//   @override
//   State<Register> createState() => _RegisterState();
// }
//
// class _RegisterState extends State<Register> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.height,
//       width: MediaQuery.of(context).size.width,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text("Registration"),
//         ),
//
//         body: SingleChildScrollView(
//           child: TextField(
//
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'login.dart';


//
// Future<List<LoginModel>> fetchPost() async {
//   final response =
//   await http.get(Uri.parse('https://192.168.29.70/sellsapi/loginapi.php'));
//
//
//
//   if (response.statusCode == 200) {
//     final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
//
//     return parsed.map<LoginModel>((json) => LoginModel.fromJson(json)).toList();
//   } else {
//     throw Exception('Failed to load album');
//   }
// }

class Register_page extends StatefulWidget {
  const Register_page({Key? key}) : super(key: key);

  @override
  _Register_pageState createState() => _Register_pageState();
}

class _Register_pageState extends State<Register_page> {

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  late String user;
  late String password;

  bool _obsecureText = true;

  void toggle(){
    setState(() {
      _obsecureText = !_obsecureText;
    });
  }



  submitData(String zemail, String xpassword) async{

    print(zemail);
    print(xpassword);



    var response= await http.post(Uri.parse('https://democart.brotherdev.com/login.php'),body:
    jsonEncode(<String, String>{
      "user": user,
      "password": password,
    })
    );

    if(response.statusCode == 200){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Login_page()));
    }

  }

  //Future<List<LoginModel>>? futurePost;

  @override
  void initState() {
    super.initState();
    // futurePost = fetchPost();
    //
    //
    // fetchPost().whenComplete(() => futurePost);
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Color(0xFF76a686),
            title: Center(
              child: Text("Registration",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),

          body: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [




                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(

                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey),
                          ),

                        child: TextFormField(
                          style: TextStyle(
                            //fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black,
                          ),
                          onChanged: (input){
                            user = input;
                          },
                          validator: (input){
                            if(input!.isEmpty){
                              return "Empty";
                            }
                          },

                          scrollPadding: EdgeInsets.all(20),
                          decoration:  InputDecoration(
                            contentPadding: EdgeInsets.only(left: 20), // add padding to adjust text
                            isDense: false,
                            // hintText: "User Name",
                            // labelText: "User Name",
                            hintText: "User Name",
                            hintStyle: TextStyle(
                              //fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black,
                            ),
                            labelText: "User Name",
                            labelStyle:  TextStyle(
                              //fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(),
                            suffixIcon: Padding(
                              padding: EdgeInsets.only(top: 8), // add padding to adjust icon
                              child: Icon(Icons.person),
                            ),
                          ),
                        ),
                      ),
                    ),


                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        decoration: BoxDecoration(
                           color: Colors.white,
                          border: Border.all(color: Colors.grey),
                        ),
                        child: TextFormField(
                          style: TextStyle(
                            //fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black,
                          ),
                          obscureText: _obsecureText,
                          onChanged: (input){
                            password = input;
                          },
                          scrollPadding: EdgeInsets.all(20),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 20), // add padding to adjust text
                            isDense: true,
                            hintText: "Password",
                            hintStyle: TextStyle(
                              //fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black,
                            ),
                            labelText: "Password",
                            labelStyle:  TextStyle(
                              //fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(),
                            suffixIcon: Padding(
                                padding: EdgeInsets.only(top: 8), // add padding to adjust icon
                                child: IconButton(
                                  icon: Icon(_obsecureText ? Icons.remove_red_eye : Icons.remove_red_eye_rounded,),
                                  onPressed: (){
                                    toggle();
                                  },
                                )


                            ),

                          ),
                        ),
                      ),
                    ),


                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width/1.2,
                      decoration: BoxDecoration(
                        color: Color(0xff5c9c72),
                        //border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),

                        onPressed: ()async{

                          submitData(user, password);
                        },
                        child: Text("Register",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),





                  ],
                ),
              ),
            ),
          ),

        ),
      ),
    );
  }
}
