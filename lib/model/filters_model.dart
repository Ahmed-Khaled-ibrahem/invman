class FilterModel{
  String type;
  String title;
  String active;
  List<String> items;

  FilterModel({
    required this.type,
    required this.title,
    required this.active,
    required this.items,
  });
}