import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invman/bloc/app_cubit.dart';
import 'package:invman/bloc/app_states.dart';
import '../../model/const/assets_manager.dart';

// Widget loadingHolderScreen(Widget screen){
//
//   return BlocBuilder<AppCubit, AppStates>(
//     builder: (context, state) {
//       AppCubit cubit = AppCubit.get(context);
//
//       return Stack(
//         children: [
//           screen,
//           cubit.loginLoading ? AbsorbPointer(
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.blue.withOpacity(0.5),
//               ),
//
//               child: Center(
//                 child: Image.asset(
//                   AssetsManager.gif,
//                   width: 500,
//                   height: 500,
//                 ),
//               ),
//             ),
//           ): Container(),
//         ],
//       );
//     },
//   );
// }