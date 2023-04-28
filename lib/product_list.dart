import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/cart_screen.dart';
import 'cart_model.dart';
import 'cart_provider.dart';
import 'db_helper.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {

  DBHelper? dbHelper= DBHelper();
  List<String> productName = ['watch_201' ,'watch_202', 'watch_203' , 'watch_204' , 'watch_205' , 'watch_206','watch_207','watch_208',
    'watch_209','watch_210','watch_211','watch_212','watch_213','watch_214','watch_215','watch_216','watch_218','watch_219','watch_220',] ;
  List<String> productUnit = ['price' , 'Price' , 'Price' , 'Price' , 'Price' , 'Price','Price','price' , 'Price' , 'Price' , 'Price' , 'Price' , 'Price','Price', 'Price' , 'Price' , 'Price' , 'Price' , 'Price','Price',] ;
  List<int> productPrice = [500, 720 , 450 , 400 , 500, 600 , 700 ,800,560,750,450,350,900,380,500, 720 , 450 , 400 , 500, 600] ;
  List<String> productImage = [

    'http://democart.brotherdev.com/productimages/Ladies_watch_0031.jpg' ,
    'http://democart.brotherdev.com/productimages/Curren_watch_02.jpg' ,
    'http://democart.brotherdev.com/productimages/Ladies_watch_0033.jpg',
    'http://democart.brotherdev.com/productimages/Curren_watch_004.jpg' ,
     'http://democart.brotherdev.com/productimages/Ladies_watch_0016.jpg' ,
     'http://democart.brotherdev.com/productimages/Ladies_watch_0019.jpg' ,
     'http://democart.brotherdev.com/productimages/Ladies_watch_0022.jpg' ,
    'http://democart.brotherdev.com/productimages/Ladies_watch_0020.jpg' ,
    'http://democart.brotherdev.com/productimages/WhatsApp%20Image%202022-03-25%20at%204.28.50%20PM.jpeg' ,
    'http://democart.brotherdev.com/productimages/WhatsApp%20Image%202022-03-25%20at%204.28.51%20PM%20%281%29.jpeg',
    'http://democart.brotherdev.com/productimages/WhatsApp%20Image%202022-03-25%20at%204.28.51%20PM%20%283%29.jpeg' ,
    'http://democart.brotherdev.com/productimages/Ladies_watch_0028.jpg' ,
    'http://democart.brotherdev.com/productimages/Ladies_watch_0030.jpg' ,
    'http://democart.brotherdev.com/productimages/Ladies_watch_0032.jpg' ,
    'http://democart.brotherdev.com/productimages/WhatsApp%20Image%202022-03-25%20at%204.28.51%20PM.jpeg' ,
    'http://democart.brotherdev.com/productimages/WhatsApp%20Image%202022-03-25%20at%204.28.52%20PM%20%282%29.jpeg' ,
    'http://democart.brotherdev.com/productimages/Ladies_watch_0025.jpg',
    'http://democart.brotherdev.com/productimages/Weidi_watch_005.jpg' ,
    'http://democart.brotherdev.com/productimages/Ladies_watch_0024.jpg' ,
    'http://democart.brotherdev.com/productimages/WhatsApp%20Image%202022-03-25%20at%204.29.35%20PM.jpeg' ,

  ] ;


  @override
  Widget build(BuildContext context) {


    final cart = Provider.of<Cartprovider>(context);
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Color(0xFF5c9c72),
      title: Text("DAZZLE",
        style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono',
            color: Colors.black87
        ),

      ),

          centerTitle: true,
          actions:[
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> CartScreen()));
              },
              child: Center(
                child: Badge(
                  badgeContent: Consumer<Cartprovider>(
                    builder: (context,value , child) {
                     return Text(value.getCounter().toString(),
                       style: TextStyle(color: Colors.white),);
                    },
                  ),
                  animationDuration: Duration(milliseconds: 500),
                  child: Icon(Icons.shopping_cart),
                ),
              ),
            ),

            SizedBox(width: 20.0),
          ]

      ),

      body:

      Column(

        children: [


          SizedBox(height: 30,),

          Expanded(child: ListView.builder(
              itemCount: productName.length,
              itemBuilder: (context, index){
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Image(
                                  height: 150,
                                  width: 100,
                                  image: NetworkImage(productImage[index].toString())),
                              SizedBox(width: 10,),

                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children:[
                                      Text(productName[index].toString(),
                                      style: TextStyle(fontSize: 16 ,fontWeight:FontWeight.w500)
                                      ),
                                      SizedBox(height: 5,),
                                      Text(productUnit[index].toString()+" " + r" $"+ productPrice[index].toString()),
                                    ]

                                ),
                              ),
                              SizedBox(width: 20,),


                              InkWell(
                                onTap: (){

                                  dbHelper!.insert(
                                    Cart(  id: index,
                                        productId : index.toString(),
                                        productName: productName[index].toString(),
                                        productPrice: productPrice[index],
                                        initialPrice: productPrice[index],
                                        quantity: 1,
                                        unitTag: productUnit[index],
                                        image:productImage[index].toString()),
                                  ).then((value){
                                    print("product is added to cart");
                                    cart.addTotalPrice(double.parse(productPrice[index].toString()));
                                    cart.addCounter();
                                  }).onError((error, stackTrace) {
                                    print(error.toString());
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text("Product is added to the bag",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ));


                                },

                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    height: 40,
                                    width:100,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF336945),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child:const Center(
                                      child: Text("Add To Bag",
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),

                                      ),
                                    ),
                                  ),
                                ),
                              ),



                            ] ),
                      ],
                    ),
                  ),
                );
              }

          ),
          ),

        ],
      ),

    );
  }
}


