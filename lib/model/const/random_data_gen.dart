import 'package:invman/model/const/user_role.dart';
import 'package:invman/model/item.dart';
import 'package:invman/model/user.dart';

UserData user1 = UserData(
  email: "one_gmail.com",
  role: UserRole.admin,
  uid: "cmsdmsv4546dfgh",
  firstName: "ahmed",
  lastName: "khaled",
  password: "password"
);

UserData user2 = UserData(
    email: "two_gmail.com",
    role: UserRole.staff,
    uid: "sdg56hd126",
    firstName: "mohammed",
    lastName: "saeed",
    password: "password"
);


Item item1 = Item(id: "mdskngsdg", name: "sandwitch", cost: 20, price: 25, category: 'general1-one');
Item item2 = Item(id: "mdskngergsa25gsdg", name: "shamobo", cost: 10, price: 22, category: 'general1-one');
Item item3 = Item(id: "sfdfsd", name: "moro", cost: 4, price: 5, category: 'general3-one');
Item item4 = Item(id: "mdskngvsdgsdg", name: "sandwitch2", cost: 20, price: 25, category: 'general1-one');
Item item5 = Item(id: "mdskngergsa25gsdg", name: "shamobo2", cost: 10, price: 22, category: 'general1-one');
Item item6 = Item(id: "sfdfsd", name: "moro2", cost: 4, price: 5, category: 'general4-one2');