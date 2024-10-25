import 'package:flutter/material.dart';
// import 'search_screen.dart'; // Import the SearchPage

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          // Wrap in SingleChildScrollView
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // App Bar
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.place, color: Colors.black87),
                        const SizedBox(width: 8),
                        Text(
                          'VagaBond',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                    const CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                  ],
                ),
              ),

              // Map Preview
              Container(
                height: 200,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(16),
                  image: const DecorationImage(
                    image: NetworkImage(
                      'https://media.wired.com/photos/59269cd37034dc5f91bec0f1/master/pass/GoogleMapTA.jpg',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Visited Places Section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Visited Places',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),

              // Places List
              ListView(
                physics:
                    const NeverScrollableScrollPhysics(), // Disable scrolling for ListView
                shrinkWrap:
                    true, // Allow ListView to take up only the needed space
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: const [
                  PlaceCard(
                    name: 'Eiffel Tower',
                    location: 'Paris, France',
                    imageUrl: 'Placeholder for Eiffel Tower image',
                  ),
                  PlaceCard(
                    name: 'Mount Fuji',
                    location: 'Honshu, Japan',
                    imageUrl: 'Placeholder for Mount Fuji image',
                  ),
                  PlaceCard(
                    name: 'Great Wall',
                    location: 'China',
                    imageUrl: 'Placeholder for Great Wall image',
                  ),
                  PlaceCard(
                    name: 'Colosseum',
                    location: 'Rome, Italy',
                    imageUrl: 'Placeholder for Colosseum image',
                  ),
                  PlaceCard(
                    name: 'Taj Mahal',
                    location: 'Agra, India',
                    imageUrl: 'Placeholder for Taj Mahal image',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 10,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItem(Icons.home, 'Home', true, context),
              _buildNavItem(Icons.search, 'Search', false,
                  context), // Navigate to search page
              _buildNavItem(
                  Icons.bookmark_border, 'Bucket List', false, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
      IconData icon, String label, bool isSelected, BuildContext context) {
    return GestureDetector(
      onTap: () {
        // if (label == 'Search') {
        //   // Navigate to SearchPage
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(builder: (context) => const SearchScreen()),
        //   );
        // }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? Colors.blue : Colors.grey,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.blue : Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class PlaceCard extends StatelessWidget {
  final String name;
  final String location;
  final String imageUrl;

  const PlaceCard({
    super.key,
    required this.name,
    required this.location,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: Row(
          children: [
            // Placeholder for Place Image
            Container(
              width: 100,
              height: 100,
              color: Colors.grey.shade300, // Placeholder color
              alignment: Alignment.center,
              child: Text(
                imageUrl,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black54),
              ),
            ),
            // Place Details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.place,
                          size: 16,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          location,
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
