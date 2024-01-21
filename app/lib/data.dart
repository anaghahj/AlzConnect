import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart';

class Data {
  static const String _MONGO_URL =
      "mongo connection string cannot be shown due to security reasons";
  static const _app_coll_name = "AppData";
  static const _user_coll_name = "AppUsers";
  static DbCollection? _app_coll;
  static DbCollection? _user_coll;
  static String _user = "";
  static Db? _db;
  static Map<String, dynamic> _doc = {};

  static Future<bool> connect() async {
    _db = (await Db.create(_MONGO_URL));
    await _db!.open();
    _app_coll = _db!.collection(_app_coll_name);
    _user_coll = _db!.collection(_user_coll_name);
    return true;
  }

  static Future<bool> login(String username, String pwd) async {
    var d = await _user_coll!.findOne(where.eq("_id", username));
    if (d == {}) {
      throw "Wrong username";
    } else if (d!['password'] != pwd) {
      throw "Incorrect Password";
    }
    var d1 = await _app_coll!.findOne(where.eq("_id", username));
    if (d1 == null) {
      _user = username;
      await _app_coll!.insertOne({
        "_id": username,
        "E-mail_Id": d["E-mail_Id"],
        "photos": [],
        "videos": [],
        "voices": [],
        "timings": []
      });
      d1 = await _app_coll!.findOne(where.eq("_id", username));
      _doc = d1!;
      return true;
    } else {
      _user = username;
      _doc = d1;
      return true;
    }
  }

  static Future<bool> signUp(String username, String email, String pwd) async {
    var d = await _user_coll?.findOne(where.eq("_id", username));
    if (!(d == null)) {
      throw "User Already Exixts";
    } else {
      await _user_coll!
          .insertOne({"_id": username, "E-mail_Id": email, "password": pwd});
    }
    return true;
  }

  static Future<bool> changePwd(String newPwd) async {
    try {
      var result = await _user_coll!
          .update(where.eq("_id", _user), modify.set("password", newPwd));
      return true;
    } catch (e) {
      return false;
    }
  }

  static String getUsername() {
    return _user;
  }

  static Future<String> getemailid() async {
    var d = await _user_coll!.findOne(where.eq("_id", _user));
    return d!["E-mail_Id"].toString();
  }

  static Future<bool> insertImage(String img64) async {
    try {
      var result = await _app_coll!
          .update(where.eq("_id", _user), modify.push("photos", img64));
      _doc['photos'].add(img64);
      Map<String, dynamic> d = _doc;
      return true;
    } catch (e) {
      return false;
    }
  }

  static List sendImages() {
    Map<String, dynamic>? d = _doc;
    print(d?['photos'].toList());
    return d?['photos'].toList();
  }

  static Future<bool> insertVideo(String img64) async {
    try {
      var result = await _app_coll!
          .update(where.eq("_id", _user), modify.push("videos", img64));
      _doc['videos'].add(img64);
      Map<String, dynamic> d = _doc;
      return true;
    } catch (e) {
      return false;
    }
  }

  static String sendVideo() {
    Map<String, dynamic> d = _doc;
    return d['videos'].toString();
  }

  static Future<bool> insertAudio(String img64) async {
    try {
      var result = await _app_coll!
          .update(where.eq("_id", _user), modify.push("voices", img64));
      _doc['voices'].add(img64);
      Map<String, dynamic> d = _doc;
      return true;
    } catch (e) {
      return false;
    }
  }

  static List sendAudio() {
    Map<String, dynamic> d = _doc;
    return d['voices'].toList();
  }
}
