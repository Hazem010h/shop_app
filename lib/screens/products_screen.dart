import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/shop_cubit.dart';
import 'package:shop_app/cubit/shop_states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);

        return ConditionalBuilder(
          condition: cubit.homeModel != null && cubit.categoriesModel!=null,
          builder: (context) => screenBuilder(cubit.homeModel!, cubit.categoriesModel!,context),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget screenBuilder(HomeModel model,CategoriesModel categoriesModel ,context){


    List<Widget> banners= model.data!.banners
        .map(
          (e) => Image(
        image: NetworkImage(
          '${e.image}',
        ),
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    ).toList();
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                CarouselSlider(
                  items:banners,
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height / 3.5,
                    initialPage: 0,
                    viewportFraction: 1,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(
                      seconds: 3,
                    ),
                    autoPlayAnimationDuration: Duration(
                      seconds: 1,
                    ),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Categories',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: MediaQuery.of(context).size.height/7,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context,index)=>categoriesItem(categoriesModel.data!.data[index],context),
                separatorBuilder: (context,index)=>SizedBox(width: 10,),
                itemCount: categoriesModel.data!.data.length,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'New Products',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
              ),
            ),
            Container(
              color: Colors.grey[400],
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                childAspectRatio: 1 / 1.69,
                children: List.generate(
                  model.data!.products.length,
                      (index) => gridItem(model.data!.products[index], context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget categoriesItem(DataModel item,context)=>Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      Image(
        image: NetworkImage(
          '${item.image}',
        ),
        fit: BoxFit.cover,
        width: MediaQuery.of(context).size.height / 7,
        height: MediaQuery.of(context).size.height / 7,
      ),
      Container(
        color: Colors.black.withOpacity(0.8),
        width: MediaQuery.of(context).size.height / 7,
        child: Text(
          '${item.name}',
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    ],
  );

  Widget gridItem(ProductModel product, context) => Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage(
                      '${product.image}',
                    ),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 4,
                  ),
                  if (product.discount != 0)
                    Container(
                      color: Theme.of(context).primaryColor,
                      padding: EdgeInsets.all(2),
                      child: Text(
                        'DISCOUNT',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                ],
              ),
              Text(
                product.name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 3,
              ),
              Row(
                children: [
                  Text(
                    '${product.price!.round()}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  if (product.discount != 0)
                    Text(
                      '${product.oldPrice!.round()}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey,
                      ),
                    ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  product.inFavorite!
                      ? IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.favorite,
                            size: 20,
                          ),
                        )
                      : IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.favorite_outline_rounded,
                            size: 20,
                          ),
                        ),
                  !product.inCart!
                      ? IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.add_shopping_cart_rounded,
                            size: 20,
                          ),
                        )
                      : IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.remove_shopping_cart_outlined,
                            size: 20,
                          ),
                        ),
                ],
              ),
            ],
          ),
        ),
      );
}
