import 'dart:io';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class CloudAssetsManager{

  final username = 'ahmedkhaledibrahem@gmail.com';
  final password = '1288534459';
  late String auth ;

  final dio = Dio();

  CloudAssetsManager(){
    getToken().then(
            (token) => login(token)
    ).catchError((){
      print('erroor');
    }).whenComplete(() => print('completed')).
    onError((error, stackTrace) => print('error'));
  }

  Future<String> getToken() async {
    String link = 'https://api.pcloud.com/login?username=$username&password=$password';
    final response = await dio.get(link);
    final auth = response.data['auth'];
    print(auth);
    // print(response.data);
     return auth;
  }

  Future<void> login(String token) async {
    auth = token;
    // print('goint to token');
    // String link = 'https://api.pcloud.com/userinfo?getauth=1&{$token}';
    // final response = await dio.get(link);
    // print(response);
  }

  Future<void> createFolder(String name) async {
    print('creating Folder with name $name');
    String link = 'https://api.pcloud.com/createfolder?auth=$auth&path=$name';
    final response = await dio.get(link);
    print(response);
  }

  Future<Response> getUserInfo() async {
    print('User info');
    String link = 'https://api.pcloud.com/userinfo?auth=$auth';
    final response = await dio.get(link);
    print(response);
    return response;
  }

  Future<String> uploadFile(File file) async {
    String fileName = file.path.split('/').last;

    print('uploading file with name $fileName');

    FormData data = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      ),
    });

    String link = 'https://api.pcloud.com/uploadfile?auth=$auth&path=/data&filename=$fileName';
    final response = await dio.post(link,data: data);
    // print(response.data);
    final path = response.data['metadata'][0]['path'];

    return path;
  }

  Future<String> getLink(String id) async {

    String link = 'https://api.pcloud.com/getthumblink?auth=$auth&path=$id&size=500x500';
    final response = await dio.get(link);

    final full = response.data['hosts'][0] + response.data['path'];
    print(full);
    return full;

  }

  Future getImageByCamera(name) async {
    File? image;

    XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    image = File(pickedFile!.path);
    uploadFile(image);
  }





}