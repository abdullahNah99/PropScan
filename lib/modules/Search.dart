import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../shared/cubit/App_state.dart';
import '../shared/cubit/app_cubit.dart';
import 'add_property_detail.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.purple.shade100,
            ),
            body: Column(children: [
              TextButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(30))),
                        //    isScrollControlled: true,
                        builder: (context) => BlocProvider(
                              create: (context) => AppCubit(),
                              child: BlocConsumer<AppCubit, AppState>(
                                listener: (context, state) {},
                                builder: (context, state) {
                                  return SingleChildScrollView(
                                    child: Container(
                                      padding: const EdgeInsets.all(30),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            children: [
                                              Column(children: [
                                                const Text(
                                                  ' Region',
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                                DropdownButtonHideUnderline(
                                                  child: DropdownButton<String>(
                                                    focusColor: Colors.blue,
                                                    iconEnabledColor:
                                                        Colors.purple.shade100,
                                                    value: AppCubit.get(context)
                                                            .items[
                                                        AppCubit.get(context)
                                                            .s],
                                                    items: AppCubit.get(context)
                                                        .items
                                                        .map((item) =>
                                                            DropdownMenuItem<
                                                                    String>(
                                                                value: item,
                                                                child: Text(
                                                                  item,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .purple,
                                                                    fontSize:
                                                                        20,
                                                                  ),
                                                                )))
                                                        .toList(),
                                                    onChanged: (item) {
                                                      AppCubit.get(context)
                                                          .searchindex(item!);
                                                    },
                                                  ),
                                                ),
                                              ]),
                                              const SizedBox(
                                                width: 50,
                                              ),
                                              Column(children: [
                                                const Text(
                                                  'State',
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                                DropdownButtonHideUnderline(
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 10.0,
                                                            right: 10.0),
                                                    child:
                                                        DropdownButton<String>(
                                                      // borderRadius:
                                                      //  BorderRadius.circular(30),
                                                      // dropdownColor: Colors.grey,

                                                      focusColor: Colors.blue,
                                                      iconEnabledColor: Colors
                                                          .purple.shade100,
                                                      value: AppCubit.get(
                                                                  context)
                                                              .items[
                                                          AppCubit.get(context)
                                                              .s],
                                                      items: AppCubit.get(
                                                              context)
                                                          .items
                                                          .map((item) =>
                                                              DropdownMenuItem<
                                                                      String>(
                                                                  value: item,
                                                                  child: Text(
                                                                    item,
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .purple,
                                                                      fontSize:
                                                                          20,
                                                                    ),
                                                                  )))
                                                          .toList(),
                                                      onChanged: (item) {
                                                        AppCubit.get(context)
                                                            .searchindex(item!);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ]),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          const Text(
                                            ' Price',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 20,
                                            ),
                                          ),
                                          RangeSlider(
                                            values:
                                                AppCubit.get(context).values_p,
                                            min: 0.0,
                                            max: 100.0,
                                            divisions: 10,
                                            activeColor: Colors.purple,
                                            inactiveColor: Colors.grey,
                                            labels: RangeLabels(
                                                '${AppCubit.get(context).values_p.start}',
                                                '${AppCubit.get(context).values_p.end}'),
                                            onChanged: (values) {
                                              AppCubit.get(context)
                                                  .searchprice(values);
                                            },
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          const Text(
                                            ' Space',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 20,
                                            ),
                                          ),
                                          RangeSlider(
                                            values:
                                                AppCubit.get(context).values_s,
                                            min: 0.0,
                                            max: 1000.0,
                                            divisions: 50,
                                            activeColor: Colors.purple,
                                            inactiveColor: Colors.grey,
                                            labels: RangeLabels(
                                                '${AppCubit.get(context).values_s.start}',
                                                '${AppCubit.get(context).values_s.end}'),
                                            onChanged: (values) {
                                              AppCubit.get(context)
                                                  .searchspace(values);
                                            },
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Wrap(children: <Widget>[
                                            Row(children: [
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                        height: 3.0,
                                                        width: 90.0,
                                                        color: const Color
                                                                .fromARGB(
                                                            181, 59, 2, 97)),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    TextButton(
                                                      child: const Text(
                                                        'Search',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.purple,
                                                            fontSize: 25),
                                                      ),
                                                      onPressed: () {},
                                                    ),
                                                  ]),
                                              const SizedBox(
                                                width: 100,
                                              ),
                                              Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Container(
                                                        height: 3.0,
                                                        width: 90.0,
                                                        color: const Color(
                                                            0xFF32335C)),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    TextButton(
                                                      child: const Text(
                                                        'Cancel',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.purple,
                                                            fontSize: 25),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                  ]),
                                            ]),
                                          ])
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ));
                  },
                  child: const Row(
                    children: [
                      Text('Search', style: TextStyle(color: Colors.purple)),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(Icons.search_outlined, color: Colors.purple)
                    ],
                  )),
              TextButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            insetPadding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            contentPadding: EdgeInsets.zero,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            content: Builder(builder: (context) {
                              return SizedBox(
                                width: 250,
                                height: 200,
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    Container(
                                      width: 240,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 8,
                                            blurRadius: 7,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const Add_property_detail()));
                                        },
                                        child:
                                            const Text('Add Property For Sale'),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: 240,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 8,
                                            blurRadius: 7,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: TextButton(
                                        onPressed: () {},
                                        child: const Text(
                                            ' Add Property For Rent'),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: 240,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 8,
                                            blurRadius: 7,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: TextButton(
                                        onPressed: () {},
                                        child: const Text(
                                            'Add Property For Daily Rent'),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              );
                            }),
                          );
                        });
                  },
                  child: const Row(
                    children: [
                      Text('Add Property',
                          style: TextStyle(color: Colors.purple)),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(Icons.add_business_outlined, color: Colors.purple)
                    ],
                  ))
            ]),
          );
        },
      ),
    );
  }
}
