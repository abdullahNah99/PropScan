import 'package:flutter/material.dart';
import 'package:untitled/modules/add_property_screen/add_property_screen.dart';
import 'package:untitled/modules/properties_screen/cubit/properties_cubit.dart';
import 'package:untitled/modules/properties_screen/widgets/custom_property_card.dart';
import 'package:untitled/shared/models/user_model.dart';

class MyAdvertisementsView extends StatelessWidget {
  static const route = 'MyAdvertisementsView';

  const MyAdvertisementsView({super.key});

  @override
  Widget build(BuildContext context) {
    // PropertiesCubit propertiesCubit;
    // UserModel userModel;
    Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    PropertiesCubit propertiesCubit = args['propertiesCubit'];
    UserModel userModel = args['userModel'];

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Advertisements'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, AddPropertyView.route);
          },
          child: const Icon(Icons.add),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            if (propertiesCubit.properties[index].userId == userModel.id) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: PropertyCard(
                  index: index,
                  properties: propertiesCubit.properties[index],
                  propertiesCubit: propertiesCubit,
                  myProperties: true,
                ),
              );
            }
            return const SizedBox();
          },
          itemCount: propertiesCubit.properties.length,
        ),
      ),
    );
  }
}

class MyAdvertisementsViewBody extends StatelessWidget {
  const MyAdvertisementsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [],
    );
  }
}
