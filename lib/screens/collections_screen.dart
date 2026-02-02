import 'package:flutter/material.dart';
import '../models/collection.dart';
import '../widgets/collection_card.dart';

class CollectionsScreen extends StatefulWidget {
  const CollectionsScreen({super.key});

  @override
  State<CollectionsScreen> createState() => _CollectionsScreenState();
}

class _CollectionsScreenState extends State<CollectionsScreen> {
  String? _expandedCollectionId;
  late List<Collection> _collections;

  @override
  void initState() {
    super.initState();
    _collections = getSampleCollections();
  }

  void _toggleCollection(String collectionId) {
    setState(() {
      if (_expandedCollectionId == collectionId) {
        _expandedCollectionId = null;
      } else {
        _expandedCollectionId = collectionId;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final titleFontSize = screenWidth * 0.044;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () {},
        ),
        title: Text(
          'Collections',
          style: TextStyle(
            color: Colors.black87,
            fontSize: titleFontSize,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(top: 8, bottom: 24),
        itemCount: _collections.length,
        itemBuilder: (context, index) {
          final collection = _collections[index];
          return CollectionCard(
            collection: collection,
            isExpanded: _expandedCollectionId == collection.id,
            onTap: () => _toggleCollection(collection.id),
          );
        },
      ),
    );
  }
}
