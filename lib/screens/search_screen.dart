import 'package:flutter/material.dart';
import 'package:wisata_candi/models/candi.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SeacrhScreenState();
}

class _SeacrhScreenState extends State<SearchScreen> {
  // TODO: 1. Deklarasikan variable yang dibutuhkan
  List<Candi> _filteredCandis = [];
  String _seacrhQuery = '';
  final TextEditingController _searchController = TextEditingController();
}

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    // TODO: 2. Buat apbar dengan judul Pencarian Candi
    appBar: AppBar(title: Text('Pencarian Candi'),),
    // TODO: 3. Buat body berupa column
    body: Column(
      children: [
        // TODO: 4. Buat TextField pencarian sebagian anak dari Column
        TextField(),
        // TODO: 5. Buat ListView hasil pencarian sebagai anak dari Column
        ListView.builder(
          itemCount: _filteredCandis.lenght,
          itemBuilder: (context, index) {
            final candi = _filteredCandis[index];
            return Card();
          }
        )
      ],
    )
  );
  }
