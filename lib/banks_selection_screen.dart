import 'package:flutter/material.dart';
import 'package:smartie/bank_login_screen.dart';

class BanksSelectionScreen extends StatefulWidget {
  const BanksSelectionScreen({super.key});
  @override
  State<BanksSelectionScreen> createState() => _BanksSelectionScreenState();
}

class _BanksSelectionScreenState extends State<BanksSelectionScreen> {
  // final TextEditingController _searchController = TextEditingController();

  // String? selectedBank;

  final List<Map<String, String>> banks = [
    {'name': 'National Bank of Canada', 'logo': 'assets/images/bank_logos/National_Bank_Of_Canada_logo.png'},
    {'name': 'Laurentian Bank of Canada', 'logo': 'assets/images/bank_logos/Laurentian_Bank_of_Canada_logo.png'},
    {'name': 'BMO Canada', 'logo': 'assets/images/bank_logos/bank_of_montreal_logo.png'},
    {'name': 'HSBC Canada', 'logo': 'assets/images/bank_logos/HSBC_Bank-logo.png'},
    {'name': 'Canadian Imperial Bank of Commerce', 'logo': 'assets/images/bank_logos/CIBC-logo.png'},
    {'name': 'RBC', 'logo': 'assets/images/bank_logos/rbc-royal-bank-logo.png'},
    {'name': 'TD Bank Canada', 'logo': 'assets/images/bank_logos/td-bank-logo.png'},
    {'name': 'ScotiaBank', 'logo': 'assets/images/bank_logos/scotiabank-logo.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          spacing: 12.0,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 72.0,
                bottom: 24.0,
                left: 28.0,
                right: 28.0,
              ),
              child: Column(
                children: [
                  // Company Icon
                  Image.asset(
                    'assets/images/smartie_logo.png',
                    width: MediaQuery.of(context).size.width * 0.7,
                  ),

                  Padding(padding: EdgeInsets.all(48.0)),

                  //Search Bar
                  IconButton(
                    onPressed: () {
                      showSearch(
                        context: context, 
                        delegate: BankSearchDelegate()
                      );
                    }, 
                    icon: const Icon(Icons.search)
                  ),
                  
                  SingleChildScrollView(
                    child: ListView(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(8),
                      children: <Widget>[
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              side: BorderSide(color: const Color.fromARGB(255, 210, 210, 210))
                            ),
                            onPressed: () {
                              Navigator.push(
                                context, 
                                MaterialPageRoute(
                                  builder: (context) => BankLoginScreen(imagePath: 'assets/images/bank_logos/National_Bank_Of_Canada_logo.png')
                                )
                              );
                            }, 
                            child: Image.asset(
                              'assets/images/bank_logos/National_Bank_Of_Canada_logo.png', 
                              width: MediaQuery.of(context).size.width * 0.7, 
                              height: MediaQuery.of(context).size.width * 0.3,
                            )
                          ),
                      ],
                    )
                  ),
                  
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      side: BorderSide(color: const Color.fromARGB(255, 210, 210, 210))
                    ),
                    onPressed: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context) => BankLoginScreen(imagePath: 'assets/images/bank_logos/National_Bank_Of_Canada_logo.png')
                        )
                      );
                    }, 
                    child: Image.asset(
                      'assets/images/bank_logos/National_Bank_Of_Canada_logo.png', 
                      width: MediaQuery.of(context).size.width * 0.7, 
                      height: MediaQuery.of(context).size.width * 0.3,
                    )
                  ),
                                    
                ],
              ),
            ),
          ],
        ),
    );
  }
}

class BankSearchDelegate extends SearchDelegate {
  List<String> banks = ['National Bank of Canada', 'Laurentian Bank of Canada', 'BMO Canada', 'HSBC Canada', 'Canadian Imperial Bank of Commerce', 'RBC', 'TD Bank Canada', 'ScotiaBank', 'Canadian Western Bank'];

  @override
  // Clear the search query
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        }, 
        icon: const Icon(Icons.clear)
      )
    ];
  }

  @override
  // Return Icon Button
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      }, 
      icon: const Icon(Icons.arrow_back)
    );
  }

  @override
  // Match items to search query
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var bank in banks) {
      if (bank.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(bank);
      }
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title:  Text(result),
        );
      }
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var bank in banks) {
      if (bank.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(bank);
      }
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title:  Text(result),
        );
      }
    );
  }
}
