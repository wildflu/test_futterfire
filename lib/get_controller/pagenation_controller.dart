
import 'package:cloud_firestore/cloud_firestore.dart';

class PaginationController {
  int _pageSize = 10;
  DocumentSnapshot? _lastDocument;

  int get pageSize => _pageSize;
  DocumentSnapshot? get lastDocument => _lastDocument;

  void reset() {
    _lastDocument = null;
  }

  void nextPage(DocumentSnapshot lastDocument) {
    _lastDocument = lastDocument;
  }
}
