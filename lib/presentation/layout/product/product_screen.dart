import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:invman/bloc/app_cubit.dart';
import 'package:invman/bloc/app_states.dart';
import 'package:invman/functions/dialog.dart';
import 'package:invman/functions/image_picker.dart';
import 'package:invman/functions/toast.dart';
import 'package:invman/model/realm_models/product/product.dart';
import 'package:invman/model/repo/cloud_assets_manager.dart';
import 'package:invman/presentation/widgets/text_field.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../model/const/assets_manager.dart';
import '../../../model/const/datetimeFormat.dart';
import '../../../model/realm_models/parameters/parameters.dart';

class ProductScreen extends StatefulWidget {
  ProductScreen({
    Key? key,
    this.product,
  }) : super(key: key);

  Product? product;

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  File? image;
  List<String> popUpMenuList = ['Day', 'Month', 'Year'];
  String selectedMenu = 'Day';

  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController costController;
  late TextEditingController priceController;
  late TextEditingController discountController;
  late TextEditingController profitMarginController;
  late TextEditingController minimumQtyController;
  late TextEditingController expireDateController;
  late TextEditingController periodController;
  late TextEditingController categoryController;
  late TextEditingController brandController;
  late TextEditingController barcodeController;

  String? imageLink;
  final CloudAssetsManager cloudAssetsManager = CloudAssetsManager();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late SingleValueDropDownController _cnt;
  late SingleValueDropDownController _cnt2;
  late MultiValueDropDownController _cntMulti;

  int periodInDays = 0;
  bool uploading = false;

  Future pickImage(context) async {
    if (await Permission.camera.request().isGranted) {
      imageDialog(context).then((ImageSource? source) async {
        if (source != null) {
          XFile? pickedFile = await ImagePicker().pickImage(
              source: source, maxHeight: 500, maxWidth: 500, imageQuality: 50);
          if (pickedFile != null) {
            setState(() {
              image = File(pickedFile.path);
              try {
                uploading = true;
                cloudAssetsManager.uploadFile(image!).then((value) {
                  cloudAssetsManager.getLink(value).then((value) {
                    imageLink = value;
                    setState(() {
                      uploading = false;
                    });
                  });
                });
              } catch (e) {
                showToast('can not upload the image');
              }
            });
          }
        }
      });
    } else {
      showToast('can not open camera');
    }
  }

  Widget separator(String text) {
    return Stack(
      children: [
        Text(text),
        Padding(
          padding: EdgeInsets.only(top: 10, left: text.length * 9),
          child: const Divider(
            thickness: 3,
            height: 2,
            color: Colors.black,
          ),
        )
      ],
    );
  }

  void selectionChanged() async {
    DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(), //get today's date
            firstDate: DateTime(
                2000), //DateTime.now() - not to allow to choose before today.
            lastDate: DateTime(2101))
        .then((value) {
      setState(() {
        expireDateController.text =
            DateFormat(DateTimeFormatString.date).format(value!);
        calculatePeriod();
      });
      print(value);
    });
  }

  void calculatePeriod() {
    final DateTime current =
        DateFormat(DateTimeFormatString.date).parse(expireDateController.text);
    final DateTime now = DateTime.now();
    final Duration diffrenceDays = current.difference(now);
    periodInDays = diffrenceDays.inDays;
    changesSelection(0);
  }

  void changesSelection(int val) {
    setState(() {
      periodController.text = periodInDays.toString();
    });
  }

  @override
  void initState() {
    _cnt = SingleValueDropDownController(
        data: widget.product == null
            ? null
            : DropDownValueModel(
                value: widget.product!.category.toString(),
                name: widget.product!.category.toString(),
              ));
    _cnt2 = SingleValueDropDownController(
        data: widget.product == null
            ? null
            : DropDownValueModel(
                value: widget.product!.brand.toString(),
                name: widget.product!.brand.toString(),
              ));
    _cntMulti = MultiValueDropDownController();
    super.initState();

    nameController = TextEditingController(
        text: widget.product == null ? '' : widget.product!.name);
    descriptionController = TextEditingController(
        text: widget.product == null ? '' : widget.product!.description);
    costController = TextEditingController(
        text: widget.product == null ? '' : widget.product!.cost.toString());
    priceController = TextEditingController(
        text: widget.product == null ? '' : widget.product!.price.toString());
    discountController = TextEditingController(
        text:
            widget.product == null ? '' : widget.product!.discount.toString());
    profitMarginController = TextEditingController(
        text: widget.product == null
            ? ''
            : widget.product!.profitMargin.toString());
    minimumQtyController = TextEditingController(
        text: widget.product == null ? '' : widget.product!.minQty.toString());
    expireDateController = TextEditingController(
        text: widget.product == null
            ? ''
            : widget.product!.expireDate == null
                ? ''
                : DateFormat(DateTimeFormatString.date)
                    .format(widget.product!.expireDate!));
    periodController = TextEditingController(text: '');
    categoryController = TextEditingController(text: '');
    brandController = TextEditingController(text: '');
    barcodeController = TextEditingController(
        text: widget.product == null ? '' : widget.product!.barcode);
  }

  @override
  void dispose() {
    _cnt.dispose();
    _cnt2.dispose();
    _cntMulti.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);

        return Scaffold(
          bottomNavigationBar: SizedBox(
            height: 40,
            child: MaterialButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  cubit.realmServices.createItem(
                    name: nameController.text,
                    cost: double.parse(costController.text),
                    price: double.parse(priceController.text),
                    totalStock: 0,
                    description: descriptionController.text,
                    barcode: barcodeController.text,
                    profitMargin: double.parse(profitMarginController.text == ''
                        ? '0'
                        : profitMarginController.text),
                    minQty: double.parse(minimumQtyController.text == ''
                        ? '0'
                        : minimumQtyController.text),
                    imageUrl: imageLink,
                    expireDate: expireDateController.text=='' ? DateTime.now() :DateFormat(DateTimeFormatString.date)
                        .parse(expireDateController.text),
                    discount: double.parse(discountController.text == ''
                        ? '0'
                        : discountController.text),
                    brand: _cnt2.dropDownValue == null
                        ? 'General'
                        : _cnt2.dropDownValue!.name,
                    category: _cnt.dropDownValue == null
                        ? 'General'
                        : _cnt.dropDownValue!.name,
                    id: widget.product == null ? null : widget.product!.id,
                  );
                  Navigator.pop(context);
                  if(widget.product!=null){Navigator.pop(context);}
                  cubit.setState();
                }
                // Navigator.pop(context);
              },
              color: Colors.green,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.done,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.product == null ? 'Create' : 'Save',
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          body: InkWell(
            overlayColor: MaterialStateProperty.all(Colors.red.withOpacity(0)),
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_circle_left_rounded,
                              size: 30,
                            )),
                        Text(
                          'Product',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const Spacer(),
                        MaterialButton(
                          onPressed: () {},
                          child: const Text('Deactivate'),
                        ),
                        MaterialButton(
                          textColor: Colors.red,
                          onPressed: () {
                            showConfirmationDialogWidget(context, 'Delete',
                                'Are you sure that you want to delete this product',
                                    () {
                                  if (widget.product != null) {
                                    cubit.realmServices.deleteItem(widget.product!);
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    cubit.setState();
                                  }
                                });
                          },
                          child: const Text(
                            'Delete',
                          ),
                        ),
                      ],
                    ),
                    Form(
                      key: _formKey,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    separator('Basic'),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFieldWidget(
                                      textController: nameController,
                                      titleText: 'Name',
                                      hintText: "Enter the product name",
                                      prefixIcon: const Icon(Icons.apps_sharp),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextField(
                                      controller: descriptionController,
                                      minLines: 1,
                                      maxLines: 3,
                                      keyboardType: TextInputType.multiline,
                                      scrollPadding: EdgeInsets.symmetric(
                                          vertical: MediaQuery.of(context)
                                              .viewInsets
                                              .bottom),
                                      decoration: InputDecoration(
                                        prefixIcon:
                                        const Icon(Icons.description),
                                        hintText:
                                        'Enter the product description',
                                        label: const Text('Description'),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(15),
                                          borderSide: const BorderSide(
                                            color: Colors.black,
                                            width: 1,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(25),
                                          borderSide: const BorderSide(
                                            color: Colors.blue,
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                      // titleText: 'Description',
                                      // hintText: "Enter the product description",
                                      // prefixIcon: const Icon(Icons.apps_sharp),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(
                                      width: 300,
                                      child: TextFieldWidget(
                                        textController: barcodeController,
                                        titleText: 'BarCode',
                                        disableValidation: true,
                                        inputType: TextInputType.number,
                                        hintText: "Enter the product barcode",
                                        prefixIcon:
                                        const Icon(Icons.barcode_reader),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    separator('Pricing'),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: screenWidth/3.5,
                                          child: TextFieldWidget(
                                            textController: costController,
                                            suffixIcon:
                                            const Icon(Icons.attach_money),
                                            titleText: 'Cost',
                                            inputType: TextInputType.number,
                                            hintText: "Enter the Cost",
                                            prefixIcon: const Icon(
                                                Icons.monetization_on_rounded),
                                          ),
                                        ),
                                        SizedBox(
                                          width: screenWidth/3.5,
                                          child: TextFieldWidget(
                                            textController: priceController,
                                            suffixIcon:
                                            const Icon(Icons.attach_money),
                                            titleText: 'Price',
                                            inputType: TextInputType.number,
                                            hintText: "Enter the price",
                                            prefixIcon: const Icon(
                                                Icons.monetization_on_rounded),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: screenWidth/3.5,
                                          child: TextFieldWidget(
                                            textController: discountController,
                                            suffixIcon:
                                            const Icon(Icons.percent),
                                            titleText: 'Discount',
                                            disableValidation: true,
                                            inputType: TextInputType.number,
                                            hintText: "Enter the discount",
                                            prefixIcon:
                                            const Icon(Icons.discount),
                                          ),
                                        ),
                                        SizedBox(
                                          width: screenWidth/3.5,
                                          child: TextFieldWidget(
                                            textController:
                                            profitMarginController,
                                            suffixIcon:
                                            const Icon(Icons.percent),
                                            titleText: 'Profit Margin',
                                            disableValidation: true,
                                            inputType: TextInputType.number,
                                            hintText: "Enter the profit Margin",
                                            prefixIcon:
                                            const Icon(Icons.money_rounded),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    separator('Limits and Alerts'),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: 300,
                                      child: TextFieldWidget(
                                        textController: minimumQtyController,
                                        titleText: 'Minimum Quantity',
                                        disableValidation: true,
                                        inputType: TextInputType.number,
                                        hintText: "Enter the product quantity",
                                        prefixIcon: const Icon(
                                            Icons.production_quantity_limits),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: screenWidth/3.5,
                                          child: InkWell(
                                            onTap: () {
                                              selectionChanged();
                                            },
                                            child: TextFieldWidget(
                                              enable: false,
                                              textController:
                                              expireDateController,
                                              readOnly: true,
                                              disableValidation: true,
                                              titleText: 'Expire Date',
                                              hintText: "Enter the date",
                                              prefixIcon:
                                              const Icon(Icons.date_range),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: screenWidth/3.5,
                                          child: TextFieldWidget(
                                            textController: periodController,
                                            disableValidation: true,
                                            suffixIcon: PopupMenuButton(
                                              initialValue: 1,
                                              itemBuilder: (context) => [
                                                const PopupMenuItem(
                                                  value: 1,
                                                  child: Text("Day"),
                                                ),
                                                const PopupMenuItem(
                                                  value: 2,
                                                  child: Text("Month"),
                                                ),
                                                const PopupMenuItem(
                                                  value: 3,
                                                  child: Text("year"),
                                                ),
                                              ],
                                              // offset: Offset(0, 100),
                                              color: Colors.lightBlueAccent,
                                              elevation: 2,
                                              onSelected: (value) {
                                                setState(() {
                                                  selectedMenu =
                                                  popUpMenuList[value - 1];
                                                  changesSelection(value);
                                                });
                                              },
                                              child: SizedBox(
                                                  width: 30,
                                                  child: Center(
                                                      child:
                                                      Text(selectedMenu))),
                                            ),
                                            titleText: 'period',
                                            inputType: TextInputType.number,
                                            hintText: "days",
                                            prefixIcon:
                                            const Icon(Icons.numbers),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    separator('Category'),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: screenWidth/5,
                                          child: DropDownTextField(
                                            controller: _cnt,
                                            clearOption: true,
                                            enableSearch: true,
                                            // dropdownColor: Colors.green,
                                            searchDecoration:
                                            const InputDecoration(
                                                hintText: "search"),
                                            // validator: (value) {
                                            //   if (value == 'not selected') {
                                            //     return "Required field";
                                            //   } else {
                                            //     return null;
                                            //   }
                                            // },
                                            textFieldDecoration:
                                            InputDecoration(
                                              hintText: 'General',
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(15),
                                                borderSide: const BorderSide(
                                                  color: Colors.black,
                                                  width: 1,
                                                ),
                                              ),
                                            ),
                                            dropDownItemCount: cubit
                                                .realmServices.realm
                                                .all<Parameters>()
                                                .first
                                                .categories
                                                .length,

                                            dropDownList: cubit
                                                .realmServices.realm
                                                .all<Parameters>()
                                                .first
                                                .categories
                                                .map((e) => DropDownValueModel(
                                                name: e, value: e))
                                                .toList(),
                                            onChanged: (val) {},
                                          ),
                                        ),
                                        MaterialButton(
                                          onPressed: () {
                                            showConfirmationDialogWidget(
                                                context,
                                                'Confirmation',
                                                'Are you Sure that you want to delete category\nany other products connected to this category will be change to general',
                                                    () {
                                                  if (_cnt.dropDownValue != null) {
                                                    if (_cnt.dropDownValue!.value !=
                                                        'General') {
                                                      cubit.removeCategory(_cnt
                                                          .dropDownValue!.value);
                                                    } else {
                                                      showToast(
                                                          'you can not remove this category');
                                                    }
                                                  } else {
                                                    showToast(
                                                        'you can not remove this category');
                                                  }
                                                  _cnt.clearDropDown();
                                                  cubit.setState();
                                                });
                                          },
                                          child: Column(
                                            children: const [
                                              Icon(
                                                Icons.remove_circle,
                                                color: Colors.red,
                                              ),
                                              Text(
                                                'Delete',
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Spacer(),
                                        SizedBox(
                                          width: screenWidth/5,
                                          child: TextFieldWidget(
                                            disableValidation: true,
                                            textController: categoryController,
                                            titleText: 'New Category',
                                            hintText: "New Category",
                                            prefixIcon:
                                            const Icon(Icons.category),
                                          ),
                                        ),
                                        MaterialButton(
                                          onPressed: () {
                                            if (categoryController
                                                .text.isNotEmpty) {
                                              cubit.addCategory(
                                                  categoryController.text);
                                              categoryController.clear();
                                              cubit.setState();
                                            } else {
                                              showToast(
                                                  'you can not add empty category');
                                            }
                                          },
                                          child: Column(
                                            children: const [
                                              Icon(Icons.add_circle,
                                                  color: Colors.green),
                                              Text(
                                                'add new',
                                                style: TextStyle(
                                                    color: Colors.green),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    separator('Brand '),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: screenWidth/5,
                                          child: DropDownTextField(
                                            // initialValue: "name4",
                                            controller: _cnt2,
                                            clearOption: true,
                                            enableSearch: true,
                                            // dropdownColor: Colors.green,
                                            searchDecoration:
                                            const InputDecoration(
                                                hintText: "search"),
                                            // validator: (value) {
                                            //   if (value == null) {
                                            //     return "Required field";
                                            //   } else {
                                            //     return null;
                                            //   }
                                            // },
                                            textFieldDecoration:
                                            InputDecoration(
                                              hintText: 'General',
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(15),
                                                borderSide: const BorderSide(
                                                  color: Colors.black,
                                                  width: 1,
                                                ),
                                              ),
                                            ),
                                            dropDownItemCount: cubit
                                                .realmServices.realm
                                                .all<Parameters>()
                                                .first
                                                .brands
                                                .length,

                                            dropDownList: cubit
                                                .realmServices.realm
                                                .all<Parameters>()
                                                .first
                                                .brands
                                                .map((e) => DropDownValueModel(
                                                name: e, value: e))
                                                .toList(),
                                            onChanged: (val) {},
                                          ),
                                        ),
                                        MaterialButton(
                                          onPressed: () {
                                            showConfirmationDialogWidget(
                                                context,
                                                'Confirmation',
                                                'Are you Sure that you want to delete brand\nany other products connected to this brand will be change to general',
                                                    () {
                                                  if (_cnt2.dropDownValue != null) {
                                                    if (_cnt2
                                                        .dropDownValue!.value !=
                                                        'General') {
                                                      cubit.removeBrand(_cnt2
                                                          .dropDownValue!.value);
                                                    } else {
                                                      showToast(
                                                          'you can not remove this Brand');
                                                    }
                                                  } else {
                                                    showToast(
                                                        'you can not remove this Brand');
                                                  }
                                                  _cnt2.clearDropDown();
                                                  cubit.setState();
                                                });
                                          },
                                          child: Column(
                                            children: const [
                                              Icon(
                                                Icons.remove_circle,
                                                color: Colors.red,
                                              ),
                                              Text(
                                                'Delete',
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Spacer(),
                                        SizedBox(
                                          width: screenWidth/5,
                                          child: TextFieldWidget(
                                            disableValidation: true,
                                            textController: brandController,
                                            titleText: 'New brand',
                                            hintText: "New brand",
                                            prefixIcon:
                                            const Icon(Icons.type_specimen),
                                          ),
                                        ),
                                        MaterialButton(
                                          onPressed: () {
                                            if (brandController
                                                .text.isNotEmpty) {
                                              cubit.addBrand(
                                                  brandController.text);
                                              brandController.clear();
                                              cubit.setState();
                                            } else {
                                              showToast(
                                                  'you can not add empty category');
                                            }
                                          },
                                          child: Column(
                                            children: const [
                                              Icon(Icons.add_circle,
                                                  color: Colors.green),
                                              Text(
                                                'add new',
                                                style: TextStyle(
                                                    color: Colors.green),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    separator('The End '),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: image == null
                                            ? CachedNetworkImage(
                                          height: screenWidth/4, width: screenWidth/4,
                                          imageUrl: widget.product == null? "" : widget.product!.imageUrl == null ? "" : 'https://${widget.product!.imageUrl}',
                                          // imageUrl:
                                          //     'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg',
                                          placeholder: (context, url) =>
                                          const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child:
                                            CircularProgressIndicator(),
                                          ),
                                          errorWidget:
                                              (context, url, error) =>
                                              Image.asset(
                                                  AssetsManager
                                                      .defaultProduct,
                                                  width: 70,
                                                  height: 70,
                                                  fit: BoxFit.cover),
                                        )
                                            : Image.file(
                                          image!,
                                          height: 250,
                                        )),
                                  ),
                                  uploading
                                      ? Card(
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: const [
                                          CircularProgressIndicator(
                                              backgroundColor:
                                              Colors.red),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            'Uploading',
                                            style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                      : Container(),
                                ],
                              ),
                              Row(
                                children: [
                                  MaterialButton(
                                    onPressed: () async {
                                      pickImage(context);
                                    },
                                    color: Colors.green,
                                    child: const Text('Upload'),
                                  ),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  MaterialButton(
                                    onPressed: () {
                                      setState(() {
                                        image = null;
                                        if(widget.product != null){
                                          // cubit.realmServices.updateItem(,name: '',category: );
                                          // widget.product!.imageUrl = null;
                                        }
                                      });
                                    },
                                    color: Colors.deepOrange,
                                    child: const Text('Remove'),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Card(
                                  elevation: 0,
                                  color: Colors.indigo.withOpacity(0.3),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: const [
                                        Text('Product Value'),
                                        SizedBox(
                                          width: 50,
                                        ),
                                        Text(
                                          '20\$',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                  )),
                              Card(
                                  elevation: 0,
                                  color: Colors.indigo.withOpacity(0.3),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: const [
                                        Text('Recommended Price'),
                                        SizedBox(
                                          width: 50,
                                        ),
                                        Text(
                                          '23\$',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                  )),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
