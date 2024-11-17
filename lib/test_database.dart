import 'package:flutter/material.dart';
import 'package:realm/realm.dart';
import 'model/repo/cloud_assets_manager.dart';



class TestDatabase extends StatefulWidget {
  TestDatabase({Key? key}) : super(key: key);

  @override
  State<TestDatabase> createState() => _TestDatabaseState();
}

class _TestDatabaseState extends State<TestDatabase> {
  late App app ;
  late final loggedInUser ;
  late Realm realm ;
  CloudAssetsManager cloudAssetsManager =  CloudAssetsManager();

  // Database database = Database()..init();
  @override
  void initState(){
    super.initState();
    // initdatabase();
  }
  Future<void> initdatabase() async {
     app = App(AppConfiguration('invman-prujz'));
     loggedInUser = await app.logIn(Credentials.anonymous());
    print(loggedInUser.deviceId);
     final config = Configuration.flexibleSync(loggedInUser, [
       // Car.schema
     ]);
     realm =
     await Realm.open(config, onProgressCallback: (syncProgress) {
       if (syncProgress.transferableBytes == syncProgress.transferredBytes) {
         print('All bytes transferred!');
       }
     });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        const Text('any'),
        MaterialButton(onPressed: () async {

          // var url = Uri.https('https://api.pcloud.com/{METHOD_NAME}?auth={AUTHENTICATION_TOKEN}&{METHOD_PARAMETRS}');
          // var response = await http.post(url, body: {'name': 'doodle', 'color': 'blue'});
          // print('Response status: ${response.statusCode}');
          // print('Response body: ${response.body}');
          //
          // // print(await http.read(Uri.https('example.com', 'foobar.txt')));


          // cloudAssetsManager.createFolder('data');
          // cloudAssetsManager.getImageByCamera('newfile');



          // final emailPwCredentials =
          // Credentials.emailPassword("lisa@example.com", "myStr0ngPassw0rd");
          // await app.logIn(emailPwCredentials);

          // final user = app.currentUser;
          // await user.logOut();


          // final car = Car(ObjectId(), 'Tesvla2', model: 'Model Sq', miles: 42);
          // realm.writeAsync(() {
          //   realm.add(car);
          // });
          //
          // realm.writeAsync(() {
          //   car.miles = 99;
          // });
          //
          // final cars = realm.all<Car>();
          // final myCar = cars[0];
          // print('My car is ${myCar.make} ${myCar.model}');

          // final char = Character(ObjectId(), 'name', 'vds', 15);
          // realm.write(() {
          //   realm.add(char);
          // });


          // Listen for changes on whole collection
          // final characters = realm.all<Car>();
          // final subscription = characters.changes.listen((changes) {
          //   changes.inserted; // indexes of inserted objects
          //   changes.modified; // indexes of modified objects
          //   changes.deleted; // indexes of deleted objects
          //   changes.newModified; // indexes of modified objects
          //   // after deletions and insertions are accounted for
          //   changes.moved; // indexes of moved objects
          //   changes.results; // the full List of objects
          // });
          // print(characters.length??'none');
          // print(characters.first.model??'none');
          // print(characters.last.model??'none');

            // Listen for changes on RealmResults
          // final hobbits = fellowshipOfTheRing.members.query('species == "Hobbit"');
          // final hobbitsSubscription = hobbits.changes.listen((changes) {
          //   // ... all the same data as above
          // });

          // Check if the subscription already exists before adding
          // final userTodoSub = realm.subscriptions.findByName('v');
          // if (userTodoSub == null) {
          //   realm.subscriptions.update((mutableSubscriptions) {
          //     // server-side rules ensure user only downloads their own Todos
          //     mutableSubscriptions.add(realm.all<Car>());
          //   });
          // }




          // Db db = database.db;
          //
          // // await usersCollection.insertOne({'login': 'jdoe', 'name': 'John Doe', 'email': 'john@doe.com'});
          // var coll = db.collection('find');
          // print(coll.find().toList());


        },child: const Text('press'),)
      ],),
    );
  }
}
