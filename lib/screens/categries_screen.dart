import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/shop_cubit.dart';
import 'package:shop_app/cubit/shop_states.dart';
import 'package:shop_app/models/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        return ListView.builder(
            itemBuilder: (context,index)=>categoryItem(ShopCubit.get(context).categoriesModel!.data!.data[index],context),
            itemCount: ShopCubit.get(context).categoriesModel!.data!.data.length,
        );
      },
    );
  }
  Widget categoryItem(DataModel item,context){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height/5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.deepOrange[100],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image(
                  width: MediaQuery.of(context).size.height/6,
                  height: MediaQuery.of(context).size.height/6,
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    '${item.image}',
                  ),
                ),
              ),
              SizedBox(width: 10,),
              Text(
                  '${item.name}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white70,
                  fontSize: 20,
                ),
              ),
              Spacer(),
              IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios_rounded))
            ],
          ),
        ),
      ),
    );
  }
}