import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invman/bloc/app_cubit.dart';
import 'package:invman/bloc/app_states.dart';
import 'package:invman/model/filters_model.dart';
import 'package:invman/presentation/responsive/responsive.dart';

class CardsPanel extends StatefulWidget {
  CardsPanel({Key? key}) : super(key: key);

  @override
  _CardsPanelState createState() => _CardsPanelState();
}

class _CardsPanelState extends State<CardsPanel> {


  Widget smallCard(String text, String active, screenWidth, onClick) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);

        return InkWell(
          onTap: () {
            // cubit.searchResultsEnable = true;
            onClick();
            cubit.searchFilter();
            // cubit.setState();
          },
          child: Card(
            color: text == active ? Colors.blue : Colors.white.withOpacity(0.6),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              child: Text(
                text,
                style: TextStyle(
                    color: text == active ? Colors.white : Colors.blue),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget bigCard(String text, String active, screenWidth , onClick) {

    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);

        return InkWell(
          onTap: () {
            cubit.searchResultsEnable = false;
            onClick();
            cubit.searchFilter();
          },
          child: Card(
            color: text == active ? Colors.blue : Colors.white.withOpacity(0.6),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              child: Text(
                text,
                style: TextStyle(
                    color: text == active ? Colors.white : Colors.blue,
                    fontSize: 18),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget panel(FilterModel model, bool expanded) {

    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);

        final screenWidth = MediaQuery.of(context).size.width;
        final screenHeight = MediaQuery.of(context).size.height;

        return expanded && Responsive.isTablet(context)
            ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              model.title,
              style: const TextStyle(fontSize: 16),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(model.items.length,
                        (index) => bigCard(
                            model.items[index],
                            model.active,
                            screenWidth,
                            (){
                              model.active = model.items[index];
                            }
                        )),
              ),
            ),
          ],
        )
            : Row(
          children: [
            Text(model.title),
            const SizedBox(
              width: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 3.2,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(model.items.length,
                          (index) => smallCard(
                          model.items[index],
                          model.active,
                              screenWidth,
                              (){
                                model.active = model.items[index];
                          }
                      )),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {


    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);

        return cubit.searchResultsEnable && Responsive.isTablet(context)
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                // physics: const NeverScrollableScrollPhysics(),
                children: <Widget>[
                  panel(cubit.filterModel, cubit.searchResultsEnable),
                  const SizedBox(
                    height: 5,
                  ),
                  panel(cubit.sortingModel, cubit.searchResultsEnable),
                  const SizedBox(
                    height: 5,
                  ),
                  panel(cubit.brandModel, cubit.searchResultsEnable),
                  const SizedBox(
                    height: 5,
                  ),
                  panel(cubit.categoryModel, cubit.searchResultsEnable),
                ],
              )
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // physics: const NeverScrollableScrollPhysics(),
                        children: <Widget>[
                          panel(cubit.filterModel, cubit.searchResultsEnable),
                          const SizedBox(
                            height: 5,
                          ),
                          panel(cubit.sortingModel, cubit.searchResultsEnable),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // physics: const NeverScrollableScrollPhysics(),
                        children: <Widget>[
                          panel(cubit.brandModel, cubit.searchResultsEnable),
                          const SizedBox(
                            height: 5,
                          ),
                          panel(cubit.categoryModel, cubit.searchResultsEnable),
                        ],
                      ),
                    ),
                  ],
                ),
              );
      },
    );
  }
}
