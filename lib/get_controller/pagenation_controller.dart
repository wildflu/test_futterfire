
import 'package:cloud_firestore/cloud_firestore.dart';


class PaginationController {
  int _pageSize = 10;
  DocumentSnapshot<Object?>? _lastDocument;

  int get pageSize => _pageSize;
  DocumentSnapshot<Object?>? get lastDocument => _lastDocument;

  void reset() {
    _lastDocument = null;
  }

  void nextPage(QueryDocumentSnapshot<Object?> lastDocument) {
    _lastDocument = lastDocument;
  }
}
