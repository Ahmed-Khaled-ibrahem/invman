import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invman/model/filters_model.dart';
import 'package:invman/model/realm_models/product/product.dart';
import 'package:invman/model/realm_models/transaction/transaction.dart';
import 'package:invman/model/repo/realm_services.dart';
import 'package:realm/realm.dart';
import '../model/realm_models/parameters/parameters.dart';
import '../model/repo/auth.dart';
import 'app_states.dart';


class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of(context);

  bool loginLoading = false;

  late Auth auth;
  late RealmServices realmServices;

  FilterModel filterModel = FilterModel(
      type: 'filter',
      title: 'Filters',
      active: 'All',
      items: ['All', 'In Stock', 'Out Of Stock', 'Active', 'In Active']);

  FilterModel sortingModel = FilterModel(
      type: 'sort',
      title: 'Sorting',
      active: 'None',
      items: ['None', 'Price', 'Cost', 'Alphabetical', 'revenue', 'Stock']);

  FilterModel brandModel = FilterModel(
      type: 'brand',
      title: 'Brand',
      active: 'none',
      items: ['Nike', 'Samsung', 'Nokia', 'Oppo']);

  FilterModel categoryModel = FilterModel(
      type: 'category',
      title: 'Category',
      active: 'none',
      items: ['TV', 'Food', 'Drinks', 'Laptops', 'Phones']);
  bool searchResultsEnable = true;
  RealmResults<Product>? searchResults;
  TextEditingController editingSearchController = TextEditingController();

  // TransactionItem currentTransaction = TransactionItem(ObjectId(), DateTime.now(), '', '', '',0, items: []);

  void setState() {
    emit(AppSetState());
  }

  Future<void> initialSetup() async {
    print('Hello');

    final realmConfig = json.decode(await rootBundle.loadString('assets/config/atlasConfig.json'));
    String appId = realmConfig['appId'];
    Uri baseUrl = Uri.parse(realmConfig['baseUrl']);
    auth = Auth(appId, baseUrl);

    auth.logInUserAnonymous().then((value) {

      realmServices = RealmServices(auth.app);
      realmServices.updateSubscriptions();  // takes time

      // realmServices.createParameters();

      final parameters = realmServices.realm.all<Parameters>();
      print('parametrs length =  ${parameters.length}');
      if( parameters.isEmpty ){
        realmServices.createParameters();
      }

      initFilters();
    });

  }

  bool loginButtonEvent(String email, String pass){
    auth.logInUserEmailPassword(email, pass).then((value) => {
    });
    return true;
  }
  bool register(String email, String pass){
    auth.registerUserEmailPassword(email, pass);
    print(auth.currentUser?.deviceId);
    print(auth.currentUser?.profile.name);
    return false;
  }

  void addCategory(String cat){

    try{
      final parameters = realmServices.realm.all<Parameters>().first;
    }catch(e){
      realmServices.createParameters();
    }

    final parameters = realmServices.realm.all<Parameters>().first;
    if(!parameters.categories.contains(cat)){
      realmServices.realm.write(() {
        parameters.categories.add(cat);
      });
    }
    // setState();
  }
  void addBrand(String brand){

    try{
      final parameters = realmServices.realm.all<Parameters>().first;
    }catch(e){
      realmServices.createParameters();
    }

    final parameters = realmServices.realm.all<Parameters>().first;
    if(!parameters.brands.contains(brand)){
      realmServices.realm.write(() {
        parameters.brands.add(brand);
      });
    }
    // setState();
  }
  void removeCategory(String cat){

    try{
      final parameters = realmServices.realm.all<Parameters>().first;
    }catch(e){
      realmServices.createParameters();
    }

    final parameters = realmServices.realm.all<Parameters>().first;
    if(parameters.categories.contains(cat)){
      realmServices.realm.write(() {
        parameters.categories.remove(cat);
      });
    }
    // setState();
  }
  void removeBrand(String brand){

    try{
      final parameters = realmServices.realm.all<Parameters>().first;
    }catch(e){
      realmServices.createParameters();
    }

    final parameters = realmServices.realm.all<Parameters>().first;
    if(parameters.brands.contains(brand)){
      realmServices.realm.write(() {
        parameters.brands.remove(brand);
      });
    }
    // setState();
  }

  void initFilters(){
    final param = realmServices.realm.all<Parameters>().first;
    print(param.brands.toList());
    brandModel.items = ['all'] + param.brands.toList();
    categoryModel.items = ['all'] + param.categories.toList();
    setState();
  }
  void searchFilter(){
    final nameResults = realmServices.realm.query<Product>('name CONTAINS[c] "${editingSearchController.text}"');
    final filtersResults ;

    if(filterModel.active != 'All'){
      filtersResults = nameResults.query(
          filterModel.active == 'In Stock' ? 'totalStock != 0' :
          filterModel.active == 'Out Of Stock' ? 'totalStock == 0' :
          filterModel.active == 'Active' ? 'active == true': 'active == false' );
    }
    else{filtersResults = nameResults;}

    final sortingResults ;
    if(sortingModel.active != 'None'){
      sortingResults = nameResults.query(
          sortingModel.active == 'Price' ? 'TRUEPREDICATE SORT(price DESC)' :
          sortingModel.active == 'Cost' ? 'TRUEPREDICATE SORT(cost DESC)' :
          sortingModel.active == 'Alphabetical' ? 'TRUEPREDICATE SORT(name ASC)':
          sortingModel.active == 'revenue' ? 'TRUEPREDICATE SORT(cost ASC)' : 'TRUEPREDICATE SORT(totalStock ASC)' );
    }
    else{sortingResults = filtersResults;}

    final categoryResults ;
    if(categoryModel.active != 'none' && categoryModel.active != 'all'){
      categoryResults = nameResults.query('category == "${categoryModel.active.trim()}"');
    }
    else{categoryResults = sortingResults;}

    final brandResults ;
    if(brandModel.active != 'none' && brandModel.active != 'all'){
      brandResults = nameResults.query('category == "${brandModel.active.trim()}"');
    }
    else{brandResults = categoryResults;}

    searchResults = brandResults;
    setState();
  }
  // void addTOList(val){
  //   if(
  //   !currentTransaction.items.contains(val)
  //   ){
  //     currentTransaction.items.add(val);
  //     calculateTotal();
  //     setState();
  //   }
  //
  // }
  // void  calculateTotal(){
  //   double total = 0;
  //   currentTransaction.items.forEach((element) {
  //     total = total
  //         +
  //         realmServices.realm.find<Product>(ObjectId.fromHexString(element.split(',')[0].trim()))!.price * double.parse(element.split(',')[1].trim());
  //   });
  //  currentTransaction.total = total;
  // }

}



