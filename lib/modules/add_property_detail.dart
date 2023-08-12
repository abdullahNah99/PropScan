import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import '../shared/constant/const.dart';
import '../shared/cubit/App_state.dart';
import '../shared/cubit/app_cubit.dart';

class Add_property_detail extends StatelessWidget {
  const Add_property_detail({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AppCubit(),
        child: BlocConsumer<AppCubit, AppState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: HexColor(dg),
                  title: const Text('Add Property To Sale'),
                  actions: const [Icon(Icons.add_business_outlined)],
                ),
                body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 200,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  AppCubit.get(context).imageFileList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Image.file(
                                  File(AppCubit.get(context)
                                      .imageFileList[index]
                                      .path),
                                  height: 170,
                                  width: 170,
                                );
                              }),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        MaterialButton(
                          onPressed: () {
                            AppCubit.get(context).selectimage();
                          },
                          child: Text(
                            'Choose Images ',
                            style: TextStyle(color: HexColor(bp)),
                          ),
                        ),
                        SizedBox(
                          height: 75,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: AppCubit.get(context).types.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(13.0),
                                  child: Container(
                                    height: 25,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: AppCubit.get(context).p == index
                                            ? HexColor("#000c9c")
                                            : HexColor("#009c90")),
                                    child: TextButton(
                                        onPressed: () {
                                          AppCubit.get(context).propertytype(
                                              AppCubit.get(context)
                                                  .types[index]);
                                        },
                                        child: Text(
                                          AppCubit.get(context).types[index],
                                          style: const TextStyle(
                                              color: Colors.white),
                                        )),
                                  ),
                                );
                              }),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Column(children: [
                          Text(
                            'State',
                            style: TextStyle(
                              color: HexColor(dg),
                              fontSize: 20,
                            ),
                          ),
                          DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              focusColor: HexColor(dp),
                              iconEnabledColor: HexColor(dp),
                              value: AppCubit.get(context)
                                  .items[AppCubit.get(context).s],
                              items: AppCubit.get(context)
                                  .items
                                  .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: TextStyle(
                                          color: HexColor(bp),
                                          fontSize: 20,
                                        ),
                                      )))
                                  .toList(),
                              onChanged: (item) {
                                AppCubit.get(context).searchindex(item!);
                              },
                            ),
                          ),
                        ]),
                        const SizedBox(
                          width: 70,
                        ),
                        Column(children: [
                          Text(
                            'Region',
                            style: TextStyle(
                              color: HexColor(dg),
                              fontSize: 20,
                            ),
                          ),
                          DropdownButtonHideUnderline(
                            child: Container(
                              margin: const EdgeInsets.only(
                                  left: 10.0, right: 10.0),
                              child: DropdownButton<String>(
                                focusColor: HexColor(dp),
                                iconEnabledColor: HexColor(dp),
                                value: AppCubit.get(context)
                                    .items[AppCubit.get(context).s],
                                items: AppCubit.get(context)
                                    .items
                                    .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: TextStyle(
                                            color: HexColor(bp),
                                            fontSize: 20,
                                          ),
                                        )))
                                    .toList(),
                                onChanged: (item) {
                                  AppCubit.get(context).searchindex(item!);
                                },
                              ),
                            ),
                          ),
                        ]),
                        const SizedBox(
                          height: 30,
                        ),
                        TextField(
                          decoration: InputDecoration(
                              labelText: "Price",
                              suffixIcon:
                                  const Icon(Icons.money_off_csred_outlined),
                              suffixIconColor: HexColor(dp)),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextField(
                          decoration: const InputDecoration(
                            labelText: "Space",
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          height: 250,
                          padding: const EdgeInsets.all(40.0),
                          child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 120,
                                childAspectRatio: 3 / 2,
                                //     crossAxisSpacing: 20,
                                //    mainAxisExtent: 20),
                              ),
                              itemCount: AppCubit.get(context).contact.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: AppCubit.get(context)
                                                  .contact[index]
                                                  .isselected
                                              ? HexColor(dg)
                                              : HexColor(dp)),
                                      child: TextButton(
                                          onPressed: () {
                                            AppCubit.get(context).feature(
                                                AppCubit.get(context)
                                                    .contact[index]
                                                    .name,
                                                AppCubit.get(context)
                                                    .contact[index]
                                                    .isselected,
                                                index);
                                          },
                                          child: Text(
                                            AppCubit.get(context)
                                                .contact[index]
                                                .name,
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ))),
                                );
                              }),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextField(
                          decoration: InputDecoration(
                              labelText: "Description",
                              hoverColor: HexColor(dp)),
                          keyboardType: TextInputType.multiline,
                        )
                      ],
                    ),
                  ),
                ),
              );
            }));
  }
}
