import 'package:capsule_care/medicineDatabaseHelper.dart';
import 'package:capsule_care/presentation/screens/medicineScreens/medicineDetailsScreen.dart';
import 'package:flutter/material.dart';

import '../../../core/localization/generated/l10n.dart';

class MedicineSearchScreen extends StatefulWidget {
  @override
  _MedicineSearchScreenState createState() => _MedicineSearchScreenState();
}

class _MedicineSearchScreenState extends State<MedicineSearchScreen> {
  SQDataBase sqDataBase = SQDataBase(); // Database helper instance
  TextEditingController searchController = TextEditingController();
  bool isSearching = false;
  bool hasSearched = false; // Tracks if user has initiated a search

  List<Map<dynamic, dynamic>> medicineList = []; // List of medicines

  @override
  void initState() {
    super.initState();
    // No need to fetch medicines initially, only show when user searches
  }

  // Search function to filter medicines by name
  Future<void> filterMedicines(String query) async {
    if (query.isEmpty) {
      setState(() {
        hasSearched = false; // No search initiated if query is empty
        medicineList = [];
      });
      return;
    }

    String searchQuery =
        "SELECT * FROM MedicineDetails WHERE medicineName LIKE '%$query%'";
    List<Map> results = await sqDataBase.readData(searchQuery);

    setState(() {
      hasSearched = true; // User has initiated a search
      medicineList = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: !isSearching
            ? Text(S.of(context).searchForMedicine)
            : TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search Medicines...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.white),
                ),
                style: TextStyle(color: Colors.white),
                onChanged: (value) {
                  filterMedicines(value); // Search as user types
                },
              ),
        actions: [
          IconButton(
            icon: Icon(isSearching ? Icons.cancel : Icons.search),
            onPressed: () {
              setState(() {
                if (isSearching) {
                  searchController.clear();
                  filterMedicines(''); // Clear search results
                }
                isSearching = !isSearching;
              });
            },
          ),
        ],
      ),
      body: hasSearched
          ? _buildSearchResults() // Show search results if search is done
          : _buildInitialMessage(), // Show initial message if no search yet
    );
  }

  // Widget to show the initial message when no search has been done
  Widget _buildInitialMessage() {
    return Center(
      child: Text(
        S.of(context).whatMedicineAreYouSearchingFor,
        style: TextStyle(
          fontSize: 18,
          color: Colors.grey,
        ),
      ),
    );
  }

  // Widget to build search results after searching
  Widget _buildSearchResults() {
    if (medicineList.isEmpty) {
      // Show message if no results found
      return Center(
        child: Text(
          S.of(context).noMedicineFound,
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      );
    } else {
      return ListView.builder(
        itemCount: medicineList.length,
        itemBuilder: (context, index) {
          final medicine = medicineList[index];
          return ListTile(
            title: Text(medicine['medicineName']),
            subtitle: Text(S.of(context).remainderOfCapsules +
                ': ${medicine['remainderOfCapsules']}'),
            onTap: () {
              // Navigate to MedicineDetailsScreen, pass the selected medicine data
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MedicineDetailsScreen(
                    medicine: medicine, // Pass the full medicine Map
                  ),
                ),
              );
            },
          );
        },
      );
    }
  }
}
