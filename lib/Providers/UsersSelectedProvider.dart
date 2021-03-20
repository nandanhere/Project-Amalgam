import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UsersSelected with ChangeNotifier {
  List<String> selectedMembers = [];
  Map<String, DocumentSnapshot> memberData = new Map();
  int get count {
    return selectedMembers.length;
  }

  void add(String id, DocumentSnapshot data) {
    if (!selectedMembers.contains(id) && selectedMembers.length <= 10) {
      selectedMembers.add(id);
      memberData[id] = data;
    }
    notifyListeners();
  }

  void delete(String id) {
    selectedMembers.remove(id);
    notifyListeners();
  }

  bool isPresent(String id) {
    return selectedMembers.contains(id);
  }
}
