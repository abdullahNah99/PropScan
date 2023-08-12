import 'package:flutter/material.dart';

Widget defaultextformfield({
  required TextEditingController controlle,
  required TextInputType type,
  required IconData prefixIcon,
  required String label,
  Function? onSubmit,
  Function? onTap,
  Function? onChange,
  String? Function(String?)? validate,
  bool? obscureText,
  IconData? suffixIcon,
  bool ispassword = false,
  Function? suffixPressed,
}) =>
    TextFormField(
      controller: controlle,
      keyboardType: type,
      obscureText: ispassword,
      decoration: InputDecoration(
        prefixIcon: Icon(prefixIcon),
        suffixIcon: suffixIcon != null
            ? IconButton(
                icon: Icon(suffixIcon),
                onPressed: () {
                  suffixPressed!();
                },
              )
            : null,
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onFieldSubmitted: (s) {
        return onSubmit!(s);
      },
      validator: (s) {
        return validate!(s);
      },
      onTap: () {
        return onTap!();
      },
    );

Widget defaultButton({
  double width = double.infinity,
  double height = 50,
  double raduis = 24,
  Color background = Colors.green,
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(raduis),
        color: background,
      ),
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child:
            Text(text, style: const TextStyle(fontSize: 20, color: Colors.white)
                //style: TextStyle(color: Colors.white),
                ),
      ),
    );

//  Widget buildinvoiceCustomeritem(BillmodelDatum billa, context) => Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
//       child: InkWell(
//         child: Container(
//           height: 90,
//           child: Row(
//             children: [
//               Expanded(
//                 flex: 2,
//                 child: Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         '${billa.billNumber}',
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                         style: TextStyle(fontWeight: FontWeight.w600),
//                       ),
//                       SizedBox(
//                         height: 6,
//                       ),
//                       Text(
//                         'date  ${billa.dateOfCreate}',
//                         style: TextStyle(
//                             fontWeight: FontWeight.w600,
//                             color: Colors.grey[600],
//                             fontSize: 12),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 width: 20,
//               ),
//               Expanded(
//                 flex: 1,
//                 child: Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Text(
//                         '\$ ${billa.totalPrice}',
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                         style: TextStyle(
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       SizedBox(
//                         height: 6,
//                       ),
//                       billa.status == 'paid'
//                           ? Container(
//                               width: 70,
//                               height: 23,
//                               child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     Text('paid',
//                                         style: TextStyle(
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.w500,
//                                           color: Colors.white,
//                                         ))
//                                   ]),
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   color: Colors.lightGreen),
//                             )
//                           : Container(
//                               width: 70,
//                               height: 23,
//                               child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     Text('unpaid',
//                                         style: TextStyle(
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.w500,
//                                           color: Colors.white,
//                                         ))
//                                   ]),
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   color: Colors.amber[500]),
//                             ),
//                     ],
//                   ),
//                 ),
//               ),
//               billa.status == 'paid'
//                   ? Expanded(
//                       flex: 1,
//                       child:
//                           //  IconButton(
//                           //     onPressed: () {},
//                           //     icon: Icon(
//                           //       Icons.delete,
//                           //       color: Colors.grey,
//                           //     ))
//                           Padding(
//                         padding: const EdgeInsets.all(5.0),
//                         child: Container(
//                           height: 30,
//                           child: TextButton(
//                             child: Text(
//                               'delete',
//                               style: TextStyle(color: Colors.white),
//                             ),
//                             onPressed: () {
//                               // AppCubit.get(context).Deletbill(billa.id);
//                               // AppCubit.get(context).getinvoicesCustomer();
//                             },
//                           ),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             color: Colors.grey,
//                           ),
//                         ),
//                       ),
//                     )
//                   : Expanded(
//                       flex: 1,
//                       child:
//                           //  IconButton(
//                           //     onPressed: () {},
//                           //     icon: Icon(
//                           //       Icons.delete,
//                           //       color: Colors.grey,
//                           //     ))
//                           Padding(
//                         padding: const EdgeInsets.all(10.0),
//                         child: Container(
//                           height: 25,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     )
//             ],
//           ),
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(blurRadius: 10, color: Colors.grey.shade600)
//               ]),
//         ),
//         onTap: () {
//           // Navigator.push(
//           //     context,
//           //     MaterialPageRoute(
//           //       builder: (context) => BillSc(billa),
//           //     ));
//         },
//       ),
//     );
// // Widget invoiceCustomerbuild(Billmodel? billa, context) {
// //   return ConditionalBuilderRec(
// //       condition: billa!.data!.length > 0,
// //       builder: (context) => ListView.separated(
// //             shrinkWrap: true,
// //             physics: BouncingScrollPhysics(),
// //             itemCount: billa.data!.length,
// //             itemBuilder: (context, index) {
// //               return buildinvoiceCustomeritem(billa.data![index], context);
// //             },
// //             separatorBuilder: (context, index) => SizedBox(
// //               height: 8,
// //             ),
// //           ),
// //       fallback: (context) => Center(
// //             child: Text('No Invoices Yet'),
// //           ));
// // }

// // Widget buildinvoicesAdmnitem(BillmodelDatum bill, context) {
// //   return Padding(
// //     padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
// //     child: InkWell(
// //       child: Container(
// //         height: 90,
// //         child: Row(
// //           children: [
// //             Expanded(
// //               flex: 2,
// //               child: Padding(
// //                 padding: const EdgeInsets.all(10.0),
// //                 child: Column(
// //                   mainAxisAlignment: MainAxisAlignment.center,
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     Text(
// //                       '${bill.billNumber}',
// //                       maxLines: 1,
// //                       overflow: TextOverflow.ellipsis,
// //                       style: TextStyle(fontWeight: FontWeight.w600),
// //                     ),
// //                     SizedBox(
// //                       height: 6,
// //                     ),
// //                     Text(
// //                       'date ${bill.dateOfCreate}',
// //                       style: TextStyle(
// //                           fontWeight: FontWeight.w600,
// //                           color: Colors.grey[600],
// //                           fontSize: 12),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //             SizedBox(
// //               width: 15,
// //             ),
// //             Expanded(
// //               flex: 1,
// //               child: Padding(
// //                 padding: const EdgeInsets.all(5.0),
// //                 child: Column(
// //                   mainAxisAlignment: MainAxisAlignment.center,
// //                   crossAxisAlignment: CrossAxisAlignment.center,
// //                   children: [
// //                     Text(
// //                       '\$${bill.totalPrice}',
// //                       maxLines: 1,
// //                       overflow: TextOverflow.ellipsis,
// //                       style: TextStyle(
// //                         fontWeight: FontWeight.w600,
// //                       ),
// //                     ),
// //                     SizedBox(
// //                       height: 6,
// //                     ),
// //                     bill.status == 'paid'
// //                         ? Container(
// //                             width: 100,
// //                             height: 23,
// //                             child: Column(
// //                                 mainAxisAlignment: MainAxisAlignment.center,
// //                                 crossAxisAlignment: CrossAxisAlignment.center,
// //                                 children: [
// //                                   Text('paid',
// //                                       style: TextStyle(
// //                                         fontSize: 12,
// //                                         fontWeight: FontWeight.w500,
// //                                         color: Colors.white,
// //                                       ))
// //                                 ]),
// //                             decoration: BoxDecoration(
// //                                 borderRadius: BorderRadius.circular(10),
// //                                 color: Colors.lightGreen),
// //                           )
// //                         : Container(
// //                             width: 70,
// //                             height: 23,
// //                             child: Column(
// //                                 mainAxisAlignment: MainAxisAlignment.center,
// //                                 crossAxisAlignment: CrossAxisAlignment.center,
// //                                 children: [
// //                                   Text('unpaid',
// //                                       style: TextStyle(
// //                                         fontSize: 12,
// //                                         fontWeight: FontWeight.w500,
// //                                         color: Colors.white,
// //                                       ))
// //                                 ]),
// //                             decoration: BoxDecoration(
// //                                 borderRadius: BorderRadius.circular(10),
// //                                 color: Colors.amber[500]),
// //                           ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //         decoration: BoxDecoration(
// //             borderRadius: BorderRadius.circular(10),
// //             color: Colors.white,
// //             boxShadow: [
// //               BoxShadow(blurRadius: 10, color: Colors.grey.shade600)
// //             ]),
// //       ),
// //       onTap: () {
// //         Navigator.push(
// //             context,
// //             MaterialPageRoute(
// //               builder: (context) => BillSc(bill),
// //             ));
// //       },
// //     ),
// //   );
// // }

// // // Widget invoiceAdminbuild(Billmodel? billa, context) {
// // //   return ConditionalBuilderRec(
// // //       condition: billa!.data!.length > 0,
// // //       builder: (context) => ListView.separated(
// // //             shrinkWrap: true,
// // //             physics: BouncingScrollPhysics(),
// // //             itemCount: billa.data!.length,
// // //             itemBuilder: (context, index) {
// // //               return buildinvoicesAdmnitem(billa.data![index], context);
// // //             },
// // //             separatorBuilder: (context, index) => SizedBox(
// // //               height: 8,
// // //             ),
// // //           ),
// // //       fallback: (context) => Center(
// // //             child: Text('empty Admin'),
// // //           ));
// // // }

// // // Widget buildinvoicesSearchedAdmnitem(BillSearced bill, context) {
// // //   return Padding(
// // //     padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
// // //     child: InkWell(
// // //       child: Container(
// // //         height: 90,
// // //         child: Row(
// // //           children: [
// // //             Expanded(
// // //               flex: 2,
// // //               child: Padding(
// // //                 padding: const EdgeInsets.all(10.0),
// // //                 child: Column(
// // //                   mainAxisAlignment: MainAxisAlignment.center,
// // //                   crossAxisAlignment: CrossAxisAlignment.start,
// // //                   children: [
// // //                     Text(
// // //                       '${bill.billNumber}',
// // //                       maxLines: 1,
// // //                       overflow: TextOverflow.ellipsis,
// // //                       style: TextStyle(fontWeight: FontWeight.w600),
// // //                     ),
// // //                     SizedBox(
// // //                       height: 6,
// // //                     ),
// // //                     Text(
// // //                       'date ${bill.dateOfCreate}',
// // //                       style: TextStyle(
// // //                           fontWeight: FontWeight.w600,
// // //                           color: Colors.grey[600],
// // //                           fontSize: 12),
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ),
// // //             ),
// // //             SizedBox(
// // //               width: 15,
// // //             ),
// // //             Expanded(
// // //               flex: 1,
// // //               child: Padding(
// // //                 padding: const EdgeInsets.all(5.0),
// // //                 child: Column(
// // //                   mainAxisAlignment: MainAxisAlignment.center,
// // //                   crossAxisAlignment: CrossAxisAlignment.center,
// // //                   children: [
// // //                     Text(
// // //                       '\%${bill.rateVat}',
// // //                       maxLines: 1,
// // //                       overflow: TextOverflow.ellipsis,
// // //                       style: TextStyle(
// // //                         fontWeight: FontWeight.w600,
// // //                       ),
// // //                     ),
// // //                     SizedBox(
// // //                       height: 6,
// // //                     ),
// // //                     bill.status == 'paid'
// // //                         ? Container(
// // //                             width: 100,
// // //                             height: 23,
// // //                             child: Column(
// // //                                 mainAxisAlignment: MainAxisAlignment.center,
// // //                                 crossAxisAlignment: CrossAxisAlignment.center,
// // //                                 children: [
// // //                                   Text('paid',
// // //                                       style: TextStyle(
// // //                                         fontSize: 12,
// // //                                         fontWeight: FontWeight.w500,
// // //                                         color: Colors.white,
// // //                                       ))
// // //                                 ]),
// // //                             decoration: BoxDecoration(
// // //                                 borderRadius: BorderRadius.circular(10),
// // //                                 color: Colors.lightGreen),
// // //                           )
// // //                         : Container(
// // //                             width: 70,
// // //                             height: 23,
// // //                             child: Column(
// // //                                 mainAxisAlignment: MainAxisAlignment.center,
// // //                                 crossAxisAlignment: CrossAxisAlignment.center,
// // //                                 children: [
// // //                                   Text('unpaid',
// // //                                       style: TextStyle(
// // //                                         fontSize: 12,
// // //                                         fontWeight: FontWeight.w500,
// // //                                         color: Colors.white,
// // //                                       ))
// // //                                 ]),
// // //                             decoration: BoxDecoration(
// // //                                 borderRadius: BorderRadius.circular(10),
// // //                                 color: Colors.amber[500]),
// // //                           ),
// // //                   ],
// // //                 ),
// // //               ),
// // //             ),
// // //           ],
// // //         ),
// // //         decoration: BoxDecoration(
// // //             borderRadius: BorderRadius.circular(10),
// // //             color: Colors.white,
// // //             boxShadow: [
// // //               BoxShadow(blurRadius: 10, color: Colors.grey.shade600)
// // //             ]),
// // //       ),
// // //       onTap: () {
// // //         Navigator.push(
// // //             context,
// // //             MaterialPageRoute(
// // //               builder: (context) => BillSc(bill),
// // //             ));
// // //       },
// // //     ),
// // //   );
// // // }

// // // Widget buildinvoicesSearchedCusitem(BillCustData bill, context) {
// // //   return Padding(
// // //     padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
// // //     child: InkWell(
// // //       child: Container(
// // //         height: 90,
// // //         child: Row(
// // //           children: [
// // //             Expanded(
// // //               flex: 2,
// // //               child: Padding(
// // //                 padding: const EdgeInsets.all(10.0),
// // //                 child: Column(
// // //                   mainAxisAlignment: MainAxisAlignment.center,
// // //                   crossAxisAlignment: CrossAxisAlignment.start,
// // //                   children: [
// // //                     Text(
// // //                       '${bill.billNumber}',
// // //                       maxLines: 1,
// // //                       overflow: TextOverflow.ellipsis,
// // //                       style: TextStyle(fontWeight: FontWeight.w600),
// // //                     ),
// // //                     SizedBox(
// // //                       height: 6,
// // //                     ),
// // //                     Text(
// // //                       'date ${bill.dateOfCreate}',
// // //                       style: TextStyle(
// // //                           fontWeight: FontWeight.w600,
// // //                           color: Colors.grey[600],
// // //                           fontSize: 12),
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ),
// // //             ),
// // //             SizedBox(
// // //               width: 15,
// // //             ),
// // //             Expanded(
// // //               flex: 1,
// // //               child: Padding(
// // //                 padding: const EdgeInsets.all(5.0),
// // //                 child: Column(
// // //                   mainAxisAlignment: MainAxisAlignment.center,
// // //                   crossAxisAlignment: CrossAxisAlignment.center,
// // //                   children: [
// // //                     Text(
// // //                       '\%${bill.rateVat}',
// // //                       maxLines: 1,
// // //                       overflow: TextOverflow.ellipsis,
// // //                       style: TextStyle(
// // //                         fontWeight: FontWeight.w600,
// // //                       ),
// // //                     ),
// // //                     SizedBox(
// // //                       height: 6,
// // //                     ),
// // //                     bill.status == 'paid'
// // //                         ? Container(
// // //                             width: 100,
// // //                             height: 23,
// // //                             child: Column(
// // //                                 mainAxisAlignment: MainAxisAlignment.center,
// // //                                 crossAxisAlignment: CrossAxisAlignment.center,
// // //                                 children: [
// // //                                   Text('paid',
// // //                                       style: TextStyle(
// // //                                         fontSize: 12,
// // //                                         fontWeight: FontWeight.w500,
// // //                                         color: Colors.white,
// // //                                       ))
// // //                                 ]),
// // //                             decoration: BoxDecoration(
// // //                                 borderRadius: BorderRadius.circular(10),
// // //                                 color: Colors.lightGreen),
// // //                           )
// // //                         : Container(
// // //                             width: 70,
// // //                             height: 23,
// // //                             child: Column(
// // //                                 mainAxisAlignment: MainAxisAlignment.center,
// // //                                 crossAxisAlignment: CrossAxisAlignment.center,
// // //                                 children: [
// // //                                   Text('unpaid',
// // //                                       style: TextStyle(
// // //                                         fontSize: 12,
// // //                                         fontWeight: FontWeight.w500,
// // //                                         color: Colors.white,
// // //                                       ))
// // //                                 ]),
// // //                             decoration: BoxDecoration(
// // //                                 borderRadius: BorderRadius.circular(10),
// // //                                 color: Colors.amber[500]),
// // //                           ),
// // //                   ],
// // //                 ),
// // //               ),
// // //             ),
// // //           ],
// // //         ),
// // //         decoration: BoxDecoration(
// // //             borderRadius: BorderRadius.circular(10),
// // //             color: Colors.white,
// // //             boxShadow: [
// // //               BoxShadow(blurRadius: 10, color: Colors.grey.shade600)
// // //             ]),
// // //       ),
// // //       onTap: () {
// // //         Navigator.push(
// // //             context,
// // //             MaterialPageRoute(
// // //               builder: (context) => BillSc(bill),
// // //             ));
// // //       },
// // //     ),
// // //   );
// // // }

// // // Widget invoiceSearchedbuild(Searchbillmodel? billa, context) {
// // //   return ConditionalBuilderRec(
// // //       condition: billa!.bills![0].billNumber != null,
// // //       builder: (context) => ListView.separated(
// // //             physics: BouncingScrollPhysics(),
// // //             itemCount: billa.bills!.length,
// // //             itemBuilder: (context, index) {
// // //               return buildinvoicesSearchedAdmnitem(
// // //                   billa.bills![index], context);
// // //             },
// // //             separatorBuilder: (context, index) => SizedBox(
// // //               height: 8,
// // //             ),
// // //           ),
// // //       fallback: (context) => Center(
// // //             child: Text('empty Admin'),
// // //           ));
// // // }

// // // Widget invoiceSearchCusedbuild(SearchCusModel? billa, context) {
// // //   return ConditionalBuilderRec(
// // //       condition: billa!.bills![0].billNumber != null,
// // //       builder: (context) => ListView.separated(
// // //             physics: BouncingScrollPhysics(),
// // //             itemCount: billa.bills!.length,
// // //             itemBuilder: (context, index) {
// // //               return buildinvoicesSearchedCusitem(billa.bills![index], context);
// // //             },
// // //             separatorBuilder: (context, index) => SizedBox(
// // //               height: 8,
// // //             ),
// // //           ),
// // //       fallback: (context) => Center(
// // //             child: Text('empty Admin'),
// // //           ));
// // // }

// // // Widget InvoicAdmnBuilder(Billmodel bill, context) => ConditionalBuilderRec(
// // //     condition: bill.data!.length > 0,
// // //     builder: (context) => ListView.separated(
// // //         physics: BouncingScrollPhysics(),
// // //         itemBuilder: (context, index) =>
// // //             buildinvoicesAdmnitem(bill.data![index], context),
// // //         separatorBuilder: (context, index) => SizedBox(
// // //               height: 8,
// // //             ),
// // //         itemCount: 10),
// // //     fallback: (context) => Center(
// // //           child: Text('empty Admin'),
// // //         ));
