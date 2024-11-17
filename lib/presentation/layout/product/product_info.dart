import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:invman/functions/navigation.dart';
import 'package:invman/model/const/assets_manager.dart';
import 'package:invman/model/const/datetimeFormat.dart';
import 'package:invman/model/realm_models/product/product.dart';
import 'package:invman/presentation/layout/product/product_screen.dart';
import 'package:invman/presentation/responsive/responsive.dart';


class ProductInfo extends StatefulWidget {
  ProductInfo(Product this.product, {Key? key}) : super(key: key);

  Product product;

  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {

  Widget labelWidget(String title, String val){
  return Card(
    color: Colors.indigo,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(title,style: const TextStyle(color: Colors.white),overflow: TextOverflow.ellipsis,),
        ),
        Expanded(child: Center(child: Text(val,style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700,overflow: TextOverflow.ellipsis,),))),
      ],
    ),
  )  ;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CachedNetworkImage(
                        height: Responsive.isMobile(context)?screenHeight/2:  screenHeight/3,
                        width: Responsive.isMobile(context)?screenHeight/2:  screenHeight/3,
                        imageUrl: 'https://${widget.product.imageUrl}',
                        placeholder: (context, url) =>  const CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Image.asset(AssetsManager.defaultProduct,width: Responsive.isMobile(context)?screenHeight/2:  screenHeight/3, height: Responsive.isMobile(context)?screenHeight/2:  screenHeight/3, fit: BoxFit.cover),
                      ),),
                IconButton(
                  onPressed: (){

                  },
                  icon: const Icon(Icons.favorite_outline_rounded,size: 32,color: Colors.white,),
                )
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:   [
                Text(widget.product.name, style: TextStyle(fontSize: 30,fontWeight: FontWeight.w700),),
                Text("${widget.product.description}",
                overflow: TextOverflow.clip,
                  softWrap: true,
                  style: TextStyle(fontSize: 15),
                ),


              ],
            ),
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.blue,
              child: IconButton(
                  color: Colors.white,
                  onPressed: (){
                    navigateTo(context, ProductScreen( product: widget.product,));
                  }, icon: const Icon(Icons.edit,size: 24,)),
            )
          ],
        ),
        Expanded(
          child: GridView.count(
            crossAxisCount: 4,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          childAspectRatio: Responsive.isMobile(context)?  5:8,
          children: [
            labelWidget('Code','#${widget.product.id}'),
            labelWidget('Category','${widget.product.category}'),
            labelWidget('Brand','${widget.product.brand}'),
            labelWidget('Price','${widget.product.price} \$'),
            labelWidget('Cost','${widget.product.cost}\$'),
            labelWidget('Stock','${widget.product.totalStock}'),
            labelWidget('Discount','${widget.product.discount} %'),
            labelWidget('Expire Date', widget.product.expireDate == null? ' - ' : DateFormat(DateTimeFormatString.date).format(widget.product.expireDate!)   ),
            labelWidget('Size','XL'),
            labelWidget('Color','Red'),
          ],
          ),
        )
      ],
    );
  }
}
