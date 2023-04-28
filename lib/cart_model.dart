class Cart{
  late final int? id;
  final String? productId;
  final String? productName;
  final int? initialPrice;
  final int? productPrice;
  final int? quantity;
  final String? unitTag;
  final String? image;

  Cart({
    required this.id,
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.initialPrice,
    required this.quantity,
    required this.unitTag,
    required this.image,
  });

  Cart.fromMap(Map<dynamic,dynamic> res, this.productId)
      :id =res['id'],
        productName =res['productName'],
        productPrice = res['productPrice'],
        initialPrice = res['initialPrice'],
        quantity = res['quantity'],
        unitTag = res['unitTag'],
        image = res['image'];
  Map<String,Object?> toMap(){
    return {
      'id':id,
      'productName ':productName,
      'productPrice':productPrice,
      'initialPrice':initialPrice,
      'quantity':quantity,
      'unitTag':unitTag,
      'image':image,
    };
  }
}