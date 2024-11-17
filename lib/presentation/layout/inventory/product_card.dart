import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:invman/bloc/app_cubit.dart';
import 'package:invman/functions/show_bottom_sheet.dart';
import 'package:invman/model/const/assets_manager.dart';
import 'package:invman/model/realm_models/product/product.dart';
import 'package:invman/presentation/layout/product/product_info.dart';
import 'package:invman/presentation/responsive/responsive.dart';

class ProductCard extends StatelessWidget {
   ProductCard(this.product, {Key? key, this.cubit, this.val}) : super(key: key);

   Product product ;
   AppCubit? cubit;
   String? val;

  Widget simpleRow(title, val){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children:  [
        AutoSizeText(title, overflow: TextOverflow.fade, maxLines: 1,),
        AutoSizeText(val, overflow: TextOverflow.ellipsis, maxLines: 1,),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: (){
        // if(cubit != null){
        //   cubit!.addTOList('${product.id},1');
        // }
        // else{
        //   showBottomSheetWidget(context, ProductInfo(product), height: Responsive.isMobile(context)?0.9 : 0.6);
        // }
      },
      child: Card(
        shadowColor: Colors.white,
        elevation: 0,
        color: Colors.indigo.withOpacity(0.1),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                  overflow: TextOverflow.ellipsis,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: product.imageUrl == null ? Image.asset(AssetsManager.defaultProduct,width: screenWidth/15, height: screenWidth/15, fit: BoxFit.cover): CachedNetworkImage(
                              height: screenWidth/15 ,width: screenWidth/15,
                              fit: BoxFit.cover,
                              imageUrl: product.imageUrl == null ?
                              'https://cdn3.vectorstock.com/i/1000x1000/03/27/cartoon-cardboard-box-vector-29560327.jpg'
                                  :'https://${product.imageUrl}',
                              placeholder: (context, url) =>  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) => Image.asset(AssetsManager.defaultProduct,width: screenWidth/15, height: screenWidth/15, fit: BoxFit.cover),
                            ),),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          simpleRow('ID : ', '#${product.id}'),
                          simpleRow('Price : ', '${product.price}\$'),
                          simpleRow('Cost : ', '${product.cost}\$'),
                          simpleRow('Stock : ', '${product.totalStock}')
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
