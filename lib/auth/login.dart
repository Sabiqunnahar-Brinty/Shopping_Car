

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_cart/product_list.dart';
import 'dart:convert';
import 'loginModel.dart';


class Login_page extends StatefulWidget {
  const Login_page({Key? key}) : super(key: key);

  @override
  _Login_pageState createState() => _Login_pageState();
}

class _Login_pageState extends State<Login_page> {

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  late String user;
  late String password;

  bool _obsecureText = true;

  void toggle(){
    setState(() {
      _obsecureText = !_obsecureText;
    });
  }

  late LoginModel data;





  submitData(String zemail, String xpassword) async{

    print(zemail);
    print(xpassword);

    //print(status1);


    var response= await http.post(Uri.parse('https://democart.brotherdev.com/login2.php'),body:
    jsonEncode(<String, String>{
      "user": user,
      "password": password,
    })
    );

     data = loginModelFromJson(response.body);

     print(response.body);

    if(response.statusCode == 200&& data.password == password){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductListScreen()));
    }
    else if(response.statusCode == 200 && data.password != password) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Password Wrong",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ));
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
          appBar: AppBar(
            backgroundColor: Color(0xFF76a686),
            title: Center(
              child: Text("Login",
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

                    // Container(
                    //   height: 200,
                    //   width: 200,
                    //   child: ClipRRect(
                    //
                    //     borderRadius: BorderRadius.circular(20),
                    //     child: Image(
                    //       image: AssetImage(
                    //           'images/orange.png'),
                    //     ),
                    //   ),
                    // ),


                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        // decoration: BoxDecoration(
                        //   color: Colors.white,
                        //   border: Border.all(color: Colors.grey),
                        // ),
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
                        // decoration: BoxDecoration(
                        //   color: Colors.white,
                        //   border: Border.all(color: Colors.grey),
                        // ),
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
                        color: Color(0xFF5c9c72),
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
                          //signin();
                          //print(username);
                          // _getCurrentLocation();
                          // print(_currentAddress);
                          // //print(_currentPosition);
                          // print(_currentPosition.latitude);
                          // print(_currentPosition.longitude);
                        },
                        child: Text("Login",
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
