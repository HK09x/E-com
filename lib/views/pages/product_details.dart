import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/controllers/database_controller.dart';
import 'package:flutter_ecommerce/models/add_to_cart_model.dart';
import 'package:flutter_ecommerce/models/product.dart';
import 'package:flutter_ecommerce/utilities/constants.dart';
import 'package:flutter_ecommerce/views/widgets/main_button.dart';
import 'package:flutter_ecommerce/views/widgets/main_dialog.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  final Product product;
  const ProductDetails({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool isFavorite = false;
  late String dropdownValue;

  Future<void> _addToCart(Database database) async {
    try {
      final addToCartProduct = AddToCartModel(
        id: documentIdFromLocalData(),
        title: widget.product.title,
        price: widget.product.price,
        productId: widget.product.id,
        imgUrl: widget.product.imgUrl,
        
      );
      await database.addToCart(addToCartProduct);
    } catch (e) {
      return MainDialog(
        context: context,
        title: 'Error',
        content: 'Couldn\'t adding to the cart, please try again!',
      ).showAlertDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final database = Provider.of<Database>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.product.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.share,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              widget.product.imgUrl,
              width: double.infinity,
              height: size.height * 0.60,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        child: SizedBox(
                          height: 60,
                          
                        ),
                      ),
                      const Spacer(),
                      
                      InkWell(
                        onTap: () {
                          setState(() {
                            isFavorite = !isFavorite;
                          });
                        },
                        child: SizedBox(
                          height: 60,
                          width: 60,
                          child: DecoratedBox(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border_outlined,
                                color: isFavorite
                                    ? Colors.redAccent
                                    : Colors.black45,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.product.title,
                        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      Text(
                        '\$${widget.product.price}',
                        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                  // const SizedBox(height: 8.0),
                  // Text(
                  //   widget.product.category,
                  //   style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  //         color: Colors.black54,
                  //       ),
                  // ),
                  const SizedBox(height: 16.0),
                  Text(
                    'โซฟารับแขก โซฟาดีไซน์โมเดิร์น มีระดับ ',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 24.0),
                  MainButton(
                    text: 'Add to cart',
                    onTap: () => _addToCart(database),
                    hasCircularBorder: true,
                  ),
                  const SizedBox(height: 32.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
