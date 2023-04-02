import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/controllers/database_controller.dart';
import 'package:flutter_ecommerce/models/product.dart';
import 'package:flutter_ecommerce/utilities/assets.dart';
import 'package:flutter_ecommerce/views/widgets/list_item_home.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  /// TODO: Temp code till refactor to a separate class with a separate context
  Widget _buildHeaderOfList(
    BuildContext context, {
    required String title,
    VoidCallback? onTap,
    required String description,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headline4!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
            ),
            InkWell(
              onTap: onTap,
              child: Text(
                'View All',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
          ],
        ),
        Text(
          description,
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                color: Colors.grey,
              ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final database = Provider.of<Database>(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Image.network(
                AppAssets.topBannerHomePageAsset,
                width: double.infinity,
                height: size.height * 0.3,
                fit: BoxFit.cover,
              ),
              Opacity(
                opacity: 0.3,
                child: Container(
                  width: double.infinity,
                  height: size.height * 0.3,
                  color: Colors.black,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 16.0),
                child: Text(
                  'SOFA SHOP',
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                _buildHeaderOfList(
                  context,
                  title: 'Sale',
                  description: 'ลดกระหน่ำ ซัมเมอร์ เซลล์!!',
                ),
                const SizedBox(height: 8.0),
                SizedBox(
                  height: 300,
                  child: StreamBuilder<List<Product>>(
                      stream: database.salesProductsStream(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          final Products = snapshot.data;
                          if (Products == null || Products.isEmpty) {
                            return const Center(
                              child: Text('ไม่สามารถดึงข้อมูลได้'),
                            );
                          }
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: Products.length,
                            itemBuilder: (_, int index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListItemHome(product: Products[index]),
                            ),
                          );
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }),
                ),
                _buildHeaderOfList(
                  context,
                  title: 'New',
                  description: 'สินค้าใหม่ !!',
                ),
                const SizedBox(height: 8.0),
                SizedBox(
                  height: 300,
                  child: StreamBuilder<List<Product>>(
                      stream: database.newProductsStream(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          final Products = snapshot.data;
                          if (Products == null || Products.isEmpty) {
                            return const Center(
                              child: Text('ไม่สามารถดึงข้อมูลได้'),
                            );
                          }
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            
                            itemBuilder: (_, int index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListItemHome(product: Products[index]),
                            ),
                          );
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
