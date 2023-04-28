import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_model.dart';
import 'cart_provider.dart';
import 'db_helper.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  DBHelper? dbHelper= DBHelper();
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cartprovider>(context);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xFF5c9c72),
          title: Text("Cart",
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black87
            ),),
          centerTitle: true,
          actions: [
            Center(
              child: Badge(
                badgeContent: Consumer<Cartprovider>(
                  builder: (context, value, child) {
                    return Text(value.getCounter().toString(),
                      style: TextStyle(color: Colors.white),);
                  },
                ),
                animationDuration: Duration(milliseconds: 500),
                child: Icon(Icons.shopping_cart),
              ),
            ),

            SizedBox(width: 20.0),
          ]

      ),

      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            FutureBuilder(
                future: cart.getData(),
                builder: (context, AsyncSnapshot<List<Cart>> snapshot) {
                  if (snapshot.hasData) {
                    if(snapshot.data!.isEmpty){
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children:[
                          SizedBox(height: 90, ),
                          Image(
                              image: AssetImage('images/emptycart.jpg'),
                          ),
                           SizedBox(height: 50, ),
                           Text('Cart is empty',
                             style:TextStyle(
                               fontSize: 30,
                               fontWeight: FontWeight.w200,
                             ) ,
                           ),

                        ],

                      );

                    }
                    else{
                      return Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .start,
                                            crossAxisAlignment: CrossAxisAlignment
                                                .center,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Image(
                                                  height: 100,
                                                  width: 60,
                                                  image: NetworkImage(
                                                      snapshot.data![index].image
                                                          .toString())),
                                              SizedBox(width: 10,),

                                              Expanded(
                                                child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text(snapshot.data![index]
                                                              .productName.toString(),
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight: FontWeight
                                                                      .w500)
                                                          ),
                                                          InkWell(
                                                            onTap:(){
                                                              dbHelper!.delete(snapshot.data![index].id!);
                                                              cart.removerCounter();
                                                              cart.removerTotalPrice(double.parse(snapshot.data![index]
                                                                  .productPrice
                                                                  .toString()));

                                                            } ,
                                                            child: Icon(Icons.delete),)
                                                        ],
                                                      ),

                                                      SizedBox(height: 5,),
                                                      Text(snapshot.data![index]
                                                          .unitTag.toString() +
                                                          " " + r" $" +
                                                          snapshot.data![index]
                                                              .productPrice
                                                              .toString()),
                                                    ]

                                                ),
                                              ),
                                              SizedBox(width: 20,),


                                              InkWell(
                                                onTap: () {
                                                  int quantity = snapshot.data![index].quantity!;
                                                  int price = snapshot.data![index].initialPrice!;
                                                  quantity --;
                                                  int? newPrice =price * quantity;

                                                  if(quantity > 0){
                                                    dbHelper!.updateQuantity(
                                                        Cart(
                                                            id:snapshot.data![index].id!,
                                                            productId:snapshot.data![index].id!.toString(),
                                                            productName: snapshot.data![index].productName,
                                                            initialPrice: snapshot.data![index].initialPrice,
                                                            productPrice:  newPrice,
                                                            quantity: quantity,
                                                            unitTag:snapshot.data![index].unitTag.toString(),
                                                            image: snapshot.data![index].image.toString())
                                                    ).then((value){
                                                      newPrice = 0;
                                                      quantity = 0;
                                                      cart.removerTotalPrice(double.parse(snapshot.data![index].initialPrice.toString()));
                                                    }).onError((error, stackTrace) {
                                                      print(error.toString());
                                                    }
                                                    );

                                                  }

                                                },
                                                child: Container(
                                                  height: 30,
                                                  width: 80,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFF336945),
                                                    borderRadius: BorderRadius
                                                        .circular(10),
                                                  ),
                                                  child:   Padding(
                                                    padding: const EdgeInsets.all(4.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        InkWell(
                                                            onTap:(){},
                                                            child: Icon(Icons.remove, color: Colors.white,)),
                                                        Text(snapshot.data![index]
                                                            .quantity.toString(),
                                                          style: TextStyle(
                                                              fontSize: 10,
                                                              fontWeight: FontWeight
                                                                  .bold,
                                                              color: Colors.white),

                                                        ),
                                                        InkWell(
                                                            onTap: (){
                                                              int quantity = snapshot.data![index].quantity!;
                                                              int price = snapshot.data![index].initialPrice!;
                                                              quantity ++;
                                                              int? newPrice =price * quantity;

                                                              dbHelper!.updateQuantity(
                                                                  Cart(
                                                                      id:snapshot.data![index].id!,
                                                                      productId:snapshot.data![index].id!.toString(),
                                                                      productName: snapshot.data![index].productName,
                                                                      initialPrice: snapshot.data![index].initialPrice,
                                                                      productPrice:  newPrice,
                                                                      quantity: quantity,
                                                                      unitTag:snapshot.data![index].unitTag.toString(),
                                                                      image: snapshot.data![index].image.toString())
                                                              ).then((value){
                                                                newPrice = 0;
                                                                quantity = 0;
                                                                cart.addTotalPrice(double.parse(snapshot.data![index].initialPrice.toString()));
                                                              }).onError((error, stackTrace) {
                                                                print(error.toString());
                                                              }
                                                              );

                                                            },
                                                            child: Icon(Icons.add, color: Colors.white,)),

                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ]),

                                      ]),

                                ),
                              );
                            }

                        ),);
                    }

                  }
                  return Text('');
                }
            ),
            Consumer<Cartprovider>(builder: (context,value,child){
              return Visibility(
                visible: value.getTotalPrice().toStringAsFixed(2)=='0.00'?false:true,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          ReusableWidget(title: 'Discount 5%', value: r'$'+value.getTotalPrice().toStringAsFixed(2),),
                          ReusableWidget(title: ' total', value: r'$'+'20',),
                          ReusableWidget(title: 'Sub total', value: r'$'+value.getTotalPrice().toStringAsFixed(2),)
                        ],
                      ),
                    ),

                    Expanded(
                      child: FlatButton(
                          color: Color(0xFF5c9c72),
                          onPressed: (){
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Order Confirm",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                      color: Colors.green,

                                ),
                              ),
                            ));

                          },
                          child: Text("Check Out")
                      ),
                    )

                  ],
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}

    class ReusableWidget extends StatelessWidget {

    final String title, value;
    const ReusableWidget({required this.title, required this.value});

    @override
    Widget build(BuildContext context) {
    return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
    children: [
    Text(title,style:Theme.of(context).textTheme.subtitle2 ,),
    Text(value.toString(),style:Theme.of(context).textTheme.subtitle2 ,)

    ],
    ),
    );
    }
    }

