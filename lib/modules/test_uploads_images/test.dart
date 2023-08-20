// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hexcolor/hexcolor.dart';

// import '../../shared/constant/const.dart';


// bool b = false;
// List<String> cc = [
//   'Gardin',
//   'Swimming pool',
//   'Porch',
//   'Parking',
//   'Children is pool'
// ];

// class show_property_detail extends StatelessWidget {
//   const show_property_detail({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//         create: (context) => AppCubit(),
//         child: BlocConsumer<AppCubit, AppState>(
//             listener: (context, state) {},
//             builder: (context, state) {
//               return Scaffold(
//                 appBar: AppBar(
//                   backgroundColor: HexColor(dg),
//                 ),
//                 body: SingleChildScrollView(
//                   child: Container(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                           height: 200,
//                           child: SingleChildScrollView(
//                             scrollDirection: Axis.horizontal,
//                             child: Row(
//                               children: [
//                                 // Image(
//                                 //   image: NetworkImage(
//                                 //       'https://www.google.com/imgres?imgurl=https%3A%2F%2Fparade.com%2F.image%2Ft_share%2FMTkxODI2MzQwMTYzMzY0MzM4%2Fbest-fall-home-decor-for-mood-boost---edited.jpg&tbnid=eFX6HGpYarODoM&vet=12ahUKEwj7j62LzciAAxVCPnAKHaPNAd4QMygNegUIARDwAQ..i&imgrefurl=https%3A%2F%2Fparade.com%2Fshopping%2Fhome-decor-ideas&docid=jYvx3iT1wnmb2M&w=1200&h=1040&q=property%20decor%20photo&ved=2ahUKEwj7j62LzciAAxVCPnAKHaPNAd4QMygNegUIARDwAQ'),
//                                 //   height: 170,
//                                 //   width: 170,
//                                 //   fit: BoxFit.cover,
//                                 // ),
//                                 // SizedBox(
//                                 //   width: 10,
//                                 // ),
//                                 // Image(
//                                 //   image: NetworkImage(
//                                 //       "https://www.google.com/imgres?imgurl=https%3A%2F%2Fwww.livehome3d.com%2Fassets%2Fimg%2Farticles%2Fhome-decor-ideas%2Fliving-room-in-green-and-gray-tones%402x.jpg&tbnid=CnbzUP66p2eh-M&vet=12ahUKEwj7j62LzciAAxVCPnAKHaPNAd4QMygKegUIARDqAQ..i&imgrefurl=https%3A%2F%2Fwww.livehome3d.com%2Fuseful-articles%2Fhome-decor-ideas&docid=cAiVkhp3pT1b0M&w=1480&h=980&q=property%20decor%20photo&ved=2ahUKEwj7j62LzciAAxVCPnAKHaPNAd4QMygKegUIARDqAQ"),
//                                 //   height: 170,
//                                 //   width: 170,
//                                 //   fit: BoxFit.cover,
//                                 // ),
//                                 // SizedBox(
//                                 //   width: 10,
//                                 // ),
//                                 // Image.network(
//                                 //   'https://www.google.com/imgres?imgurl=https%3A%2F%2Fhomebay.com%2Fwp-content%2Fuploads%2F2023%2F03%2Ff6f21a20-f408-11ec-a2eb-c1653f3f9199-shutterstock1723139395.jpg&tbnid=45DmQzbN1HLmbM&vet=12ahUKEwj7j62LzciAAxVCPnAKHaPNAd4QMygMegUIARDuAQ..i&imgrefurl=https%3A%2F%2Fhomebay.com%2Ftips%2Fdiy-homeowner-how-to-choose-a-design-theme%2F&docid=N9kYXH7G8nOiMM&w=1000&h=667&q=property%20decor%20photo&ved=2ahUKEwj7j62LzciAAxVCPnAKHaPNAd4QMygMegUIARDuAQ',
//                                 //   height: 170,
//                                 //   width: 170,
//                                 //   fit: BoxFit.cover,
//                                 // ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Text('Price ',
//                             style:
//                                 TextStyle(color: HexColor(dp), fontSize: 25)),
//                         SizedBox(
//                           height: 5,
//                         ),
//                         Container(
//                           padding: EdgeInsets.all(10),
//                           child: Text('3599700 ',
//                               style:
//                                   TextStyle(color: HexColor(bp), fontSize: 20)),
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Text(
//                           'Property Information ',
//                           style: TextStyle(color: HexColor(dp), fontSize: 25),
//                         ),
//                         SizedBox(
//                           height: 5,
//                         ),
//                         Container(
//                           height: 80,
//                           padding: EdgeInsets.all(10),
//                           child: SingleChildScrollView(
//                             scrollDirection: Axis.horizontal,
//                             child: Row(
//                               children: [
//                                 FloatingActionButton(
//                                   onPressed: () {},
//                                   backgroundColor: HexColor(dg),
//                                   child: Icon(
//                                     Icons.bedroom_parent,
//                                     color: HexColor(dp),
//                                   ),
//                                 ),
//                                 Column(
//                                   children: [
//                                     Text(
//                                       'Bed Room',
//                                       style: TextStyle(
//                                           color: Colors.grey, fontSize: 15),
//                                     ),
//                                     SizedBox(
//                                       height: 10,
//                                     ),
//                                     Text('2 Rooms',
//                                         style: TextStyle(
//                                             color: HexColor(bp), fontSize: 13)),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   width: 15,
//                                 ),
//                                 FloatingActionButton(
//                                   onPressed: () {},
//                                   backgroundColor: HexColor(dg),
//                                   child: Icon(
//                                     Icons.bathroom_outlined,
//                                     color: HexColor(dp),
//                                   ),
//                                 ),
//                                 Column(
//                                   children: [
//                                     Text(
//                                       'BathRoom',
//                                       style: TextStyle(
//                                           color: Colors.grey, fontSize: 15),
//                                     ),
//                                     SizedBox(
//                                       height: 10,
//                                     ),
//                                     Text('2 BathRooms',
//                                         style: TextStyle(
//                                             color: HexColor(bp), fontSize: 13)),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   width: 15,
//                                 ),
//                                 FloatingActionButton(
//                                   onPressed: () {},
//                                   backgroundColor: HexColor(dg),
//                                   child: Icon(
//                                     Icons.space_dashboard_rounded,
//                                     color: HexColor(dp),
//                                   ),
//                                 ),
//                                 Column(
//                                   children: [
//                                     Text(
//                                       'Space',
//                                       style: TextStyle(
//                                           color: Colors.grey, fontSize: 15),
//                                     ),
//                                     SizedBox(
//                                       height: 10,
//                                     ),
//                                     Text('250 M',
//                                         style: TextStyle(
//                                             color: HexColor(bp), fontSize: 13)),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   width: 15,
//                                 ),
//                                 FloatingActionButton(
//                                   onPressed: () {},
//                                   backgroundColor: HexColor(dg),
//                                   child: Icon(
//                                     Icons.house_siding_rounded,
//                                     color: HexColor(dp),
//                                   ),
//                                 ),
//                                 Column(
//                                   children: [
//                                     Text(
//                                       'Floor',
//                                       style: TextStyle(
//                                           color: Colors.grey, fontSize: 15),
//                                     ),
//                                     SizedBox(
//                                       height: 10,
//                                     ),
//                                     Text('3 ',
//                                         style: TextStyle(
//                                             color: HexColor(bp), fontSize: 13)),
//                                   ],
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Text(
//                           'MAP',
//                           style: TextStyle(color: HexColor(dp), fontSize: 25),
//                         ),
//                         SizedBox(
//                           height: 5,
//                         ),
//                         Container(
//                           height: 150,
//                           padding: EdgeInsets.all(10),
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Text(
//                           'Property Feature',
//                           style: TextStyle(color: HexColor(dp), fontSize: 25),
//                         ),
//                         SizedBox(
//                           height: 5,
//                         ),
//                         Container(
//                           height: 250,
//                           padding: const EdgeInsets.all(10),
//                           child: GridView.builder(
//                               gridDelegate:
//                                   const SliverGridDelegateWithMaxCrossAxisExtent(
//                                 maxCrossAxisExtent: 160,
//                                 childAspectRatio: 3 / 2,
//                               ),
//                               itemCount: cc.length,
//                               itemBuilder: (BuildContext context, int index) {
//                                 return Text(
//                                   cc[index],
//                                   style: TextStyle(
//                                       color: HexColor(bp), fontSize: 20),
//                                 );
//                               }),
//                         ),
//                         Text(
//                           'Description ',
//                           style: TextStyle(color: HexColor(dp), fontSize: 25),
//                         ),
//                         SizedBox(
//                           height: 5,
//                         ),
//                         Container(
//                           height: 50,
//                           padding: const EdgeInsets.all(10),
//                           child: Text(
//                             'have beauty xgjjzns hvbjxjzx jbxvvsh ',
//                             style: TextStyle(color: HexColor(bp), fontSize: 20),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 60,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 bottomSheet: Container(
//                   padding: EdgeInsets.only(left: 10, top: 5, bottom: 5),
//                   height: 55,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(30),
//                         topRight: Radius.circular(30)),
//                     color: Colors.white,
//                     boxShadow: [
//                       BoxShadow(
//                         color: HexColor(dg),
//                         spreadRadius: 8,
//                         blurRadius: 7,
//                         offset: Offset(0, 3), // changes position of shadow
//                       ),
//                     ],
//                   ),
//                   child: Row(
//                     children: [
//                       FloatingActionButton(
//                           backgroundColor: HexColor(dg),
//                           onPressed: () {},
//                           child: Icon(
//                             !b ? Icons.star : Icons.star_border,
//                             color: HexColor(dp),
//                           )),
//                       SizedBox(
//                         width: 20,
//                       ),
//                       FloatingActionButton(
//                           backgroundColor: HexColor(dg),
//                           onPressed: () {},
//                           child: Icon(
//                             Icons.message_outlined,
//                             color: HexColor(dp),
//                           )),
//                       SizedBox(
//                         width: 20,
//                       ),
//                       FloatingActionButton(
//                           backgroundColor: HexColor(dg),
//                           onPressed: () {
//                             showDialog(
//                               context: context,
//                               builder: (context) {
//                                 return AlertDialog(
//                                     insetPadding: EdgeInsets.symmetric(
//                                         horizontal: 10, vertical: 10),
//                                     contentPadding: EdgeInsets.zero,
//                                     shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.all(
//                                             Radius.circular(10.0))),
//                                     content: Builder(builder: (context) {
//                                       return Container(
//                                         width: 250,
//                                         height: 160,
//                                         child: Column(
//                                           children: [
//                                             TextField(
//                                               decoration: new InputDecoration(
//                                                   labelText: "Reason",
//                                                   hoverColor: HexColor(dp)),
//                                               keyboardType:
//                                                   TextInputType.multiline,
//                                             ),
//                                             SizedBox(
//                                               height: 40,
//                                             ),
//                                             Wrap(children: <Widget>[
//                                               Row(children: [
//                                                 SizedBox(
//                                                   width: 20,
//                                                 ),
//                                                 Column(
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment
//                                                             .start,
//                                                     children: [
//                                                       Container(
//                                                           height: 3.0,
//                                                           width: 90.0,
//                                                           color: HexColor(bp)),
//                                                       SizedBox(
//                                                         height: 5,
//                                                       ),
//                                                       TextButton(
//                                                         child: Text(
//                                                           'Send Report',
//                                                           style: TextStyle(
//                                                             color: HexColor(dp),
//                                                           ),
//                                                         ),
//                                                         onPressed: () {},
//                                                       ),
//                                                     ]),
//                                                 SizedBox(
//                                                   width: 50,
//                                                 ),
//                                                 Column(
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment.end,
//                                                     children: [
//                                                       Container(
//                                                           height: 3.0,
//                                                           width: 90.0,
//                                                           color: HexColor(bp)),
//                                                       SizedBox(
//                                                         height: 5,
//                                                       ),
//                                                       TextButton(
//                                                         child: Text(
//                                                           'Cancel',
//                                                           style: TextStyle(
//                                                             color: HexColor(dp),
//                                                           ),
//                                                         ),
//                                                         onPressed: () {
//                                                           Navigator.pop(
//                                                               context);
//                                                         },
//                                                       ),
//                                                     ]),
//                                               ]),
//                                             ])
//                                           ],
//                                         ),
//                                       );
//                                     }));
//                               },
//                             );
//                           },
//                           child: Icon(
//                             Icons.report_outlined,
//                             color: HexColor(dp),
//                           )),
//                       SizedBox(
//                         width: 20,
//                       ),
//                       Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.all(Radius.circular(30)),
//                             color: HexColor(dg),
//                           ),
//                           child: TextButton(
//                             onPressed: () {
//                               showDialog(
//                                   context: context,
//                                   builder: (context) {
//                                     return Container(
//                                       height:
//                                           MediaQuery.of(context).size.height,
//                                       width: MediaQuery.of(context).size.width,
//                                       child: AlertDialog(
//                                           insetPadding: EdgeInsets.symmetric(
//                                               horizontal: 10, vertical: 10),
//                                           shape: RoundedRectangleBorder(
//                                               borderRadius: BorderRadius.all(
//                                                   Radius.circular(10.0))),
//                                           content: Builder(builder: (context) {
//                                             return BlocProvider(
//                                               create: (context) => AppCubit(),
//                                               child:
//                                                   BlocConsumer<AppCubit,
//                                                           AppState>(
//                                                       listener:
//                                                           (context, state) {},
//                                                       builder:
//                                                           (context, state) {
//                                                         return Container(
//                                                           height: MediaQuery.of(
//                                                                   context)
//                                                               .size
//                                                               .height,
//                                                           width: MediaQuery.of(
//                                                                   context)
//                                                               .size
//                                                               .width,
//                                                           child:
//                                                               GridView.builder(
//                                                                   shrinkWrap:
//                                                                       true,
//                                                                   itemCount:
//                                                                       AppCubit.get(
//                                                                               context)
//                                                                           .aa
//                                                                           .length,
//                                                                   gridDelegate:
//                                                                       const SliverGridDelegateWithMaxCrossAxisExtent(
//                                                                     maxCrossAxisExtent:
//                                                                         200,
//                                                                     childAspectRatio:
//                                                                         2 / 2,
//                                                                   ),
//                                                                   itemBuilder:
//                                                                       (BuildContext
//                                                                               context,
//                                                                           int index) {
//                                                                     return Container(
//                                                                       height:
//                                                                           40,
//                                                                       width: 40,
//                                                                       child:
//                                                                           Card(
//                                                                         color: AppCubit.get(context).a ==
//                                                                                 index
//                                                                             ? HexColor(dp)
//                                                                             : HexColor(dg),
//                                                                         child: GridTile(
//                                                                             child: Center(
//                                                                           child:
//                                                                               Column(
//                                                                             crossAxisAlignment:
//                                                                                 CrossAxisAlignment.center,
//                                                                             mainAxisAlignment:
//                                                                                 MainAxisAlignment.center,
//                                                                             children: [
//                                                                               TextButton(
//                                                                                 onPressed: () {
//                                                                                   AppCubit.get(context).reservation(AppCubit.get(context).aa[index]);
//                                                                                 },
//                                                                                 child: Text(AppCubit.get(context).aa[index], style: TextStyle(color: Colors.white)),
//                                                                               ),
//                                                                               SizedBox(
//                                                                                 height: 10,
//                                                                               ),
//                                                                               Text('Available')
//                                                                             ],
//                                                                           ),
//                                                                         )),
//                                                                       ),
//                                                                     );
//                                                                   }),
//                                                         );
//                                                       }),
//                                             );
//                                           })),
//                                     );
//                                   });
//                             },
//                             child: Text(
//                               'Check Availability',
//                               style: TextStyle(color: HexColor(dp)),
//                             ),
//                           ))
//                     ],
//                   ),
//                 ),
//               );
//             }));
//   }
// }
