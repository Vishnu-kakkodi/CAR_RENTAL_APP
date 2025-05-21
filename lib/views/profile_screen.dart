import 'package:car_rental_app/providers/auth_provider.dart';
import 'package:car_rental_app/providers/date_time_provider.dart';
import 'package:car_rental_app/utils/storage_helper.dart';
import 'package:flutter/material.dart';
import 'package:car_rental_app/views/booking_screen.dart';
import 'package:car_rental_app/views/documents_screen.dart';
import 'package:car_rental_app/views/edit_profile.dart';
import 'package:car_rental_app/views/invite_screen.dart';
import 'package:car_rental_app/views/login_screen.dart';
import 'package:car_rental_app/views/wallet_screen.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String referalCode = 'Loading...';
  bool _isLoading = true;
    String name = '';


  @override
  void initState() {
    super.initState();
    _loadUserData();

    // Force refresh profile image from provider when screen loads
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   Provider.of<AuthProvider>(context, listen: false).refreshProfileImage();
    // });
  }

  Future<void> _loadUserData() async {
    setState(() {
      _isLoading = true;
    });

    try {
          final userName = await StorageHelper.getUserName();

      final code = await StorageHelper.getCode();
      if (code != null) {
        setState(() {
                name = userName ?? '';

          referalCode = code;
          _isLoading = false;
        });
      } else {
        setState(() {
          referalCode = 'No code available';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        referalCode = 'Error loading code';
        _isLoading = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load invite code: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions using MediaQuery
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    final paddingValue = screenWidth * 0.04; // 4% of screen width for padding

    return Scaffold(
                              appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.all(paddingValue * 0.7),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_back,
                  color: Colors.black, size: screenWidth * 0.05),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        title: Text(
          "Profile",
          style: TextStyle(
            color: Colors.black,
            fontSize: screenWidth * 0.045,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(paddingValue),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.02),
              
              // Profile info section
              Row(
                children: [
                  Consumer<AuthProvider>(
                    builder: (context, authProvider, child) {
                      return _buildProfileImage(context, authProvider, screenWidth);
                    },
                  ),
                  SizedBox(width: screenWidth * 0.05),
                  
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "$name",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.04,
                        ),
                      ),
                      Text(
                        "Referal code: $referalCode",
                        style: TextStyle(
                          fontSize: screenWidth * 0.035,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              
              SizedBox(height: screenHeight * 0.03),
              const Divider(),
              SizedBox(height: screenHeight * 0.02),

              // Profile menu items
              _buildMenuItem(
                context,
                icon: Icons.person_outlined,
                title: "Profile",
                bgColor: const Color(0xFFEBDCE3),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (ctx) => const EditProfile()),
                  ).then((_) {
                    // Refresh when coming back from Edit Profile
                    Provider.of<AuthProvider>(context, listen: false).refreshProfileImage();
                  });
                },
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),

              _buildMenuItem(
                context,
                icon: Icons.history,
                title: "Booking History",
                bgColor: const Color(0xFFE8EEF6),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (ctx) => const BookingScreen()),
                  );
                },
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),

              _buildMenuItem(
                context,
                icon: Icons.document_scanner,
                title: "Documents",
                bgColor: const Color(0xFFCED1E0),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (ctx) => const Documents()),
                  );
                },
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),

              _buildMenuItem(
                context,
                icon: Icons.wallet,
                title: "Wallet",
                bgColor: const Color(0xFFEEF9DB),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (ctx) => const WalletScreen()),
                  );
                },
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),

              _buildMenuItem(
                context,
                icon: Icons.share,
                title: "Invite & Earn",
                bgColor: const Color(0xFFEAE5E4),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => const InviteFriendsScreen(),
                    ),
                  );
                },
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),

              _buildMenuItem(
                context,
                icon: Icons.settings,
                title: "Settings",
                bgColor: const Color(0xFFEEF9DB),
                onTap: () {
                  // Settings navigation logic
                },
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),

              _buildMenuItem(
                context,
                icon: Icons.logout,
                title: "Logout",
                bgColor: const Color(0xFFFE0000),
                iconColor: Colors.white,
                onTap: () {
                  Provider.of<AuthProvider>(context, listen: false).logout();
                  Provider.of<DateTimeProvider>(context, listen: false).resetAll();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (ctx) => const LoginScreen()),
                    (route) => false,
                  );
                },
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),

              SizedBox(height: screenHeight * 0.02),
            ],
          ),
        ),
      ),
    );
  }

Widget _buildProfileImage(BuildContext context, AuthProvider authProvider, double screenWidth) {
  // First check the authProvider
  final profileImageFromAuth = authProvider.user?.profileImage;
  
  // Use a FutureBuilder to handle the async loading of the profile image from storage
  return FutureBuilder<String?>(
    future: StorageHelper.getProfileImage(),
    builder: (context, snapshot) {
      // Show a loading indicator if we're still waiting for the data
      if (snapshot.connectionState == ConnectionState.waiting) {
        return CircleAvatar(
          radius: screenWidth * 0.125,
          backgroundColor: Colors.grey[200],
          child: CircularProgressIndicator(),
        );
      }
      
      // Determine which image URL to use based on available sources
      String imageUrl;
      
      if (profileImageFromAuth != null) {
        // If image is available from auth provider, use it
        imageUrl = profileImageFromAuth;
      } else if (snapshot.hasData && snapshot.data != null && snapshot.data!.isNotEmpty) {
        // Otherwise use the image from storage if available
        imageUrl = snapshot.data!;
      } else {
        // Default image if no other source is available
        imageUrl = 'https://avatar.iran.liara.run/public/boy?username=Ash';
      }
      
      // Format the URL properly if it's a relative path
      if (imageUrl.isNotEmpty && !imageUrl.startsWith('http')) {
        imageUrl = 'https://carrentalbackent.onrender.com$imageUrl';
      }
      
      // Add cache buster
      final cacheBuster = '?t=${DateTime.now().millisecondsSinceEpoch}';
      
      // Return the CircleAvatar with the determined image URL
      return CircleAvatar(
        key: ValueKey('$imageUrl$cacheBuster'),
        radius: screenWidth * 0.125,
        backgroundColor: Colors.grey[200],
        backgroundImage: NetworkImage('$imageUrl$cacheBuster'),
        onBackgroundImageError: (exception, stackTrace) {
          print("Error loading profile image: $exception");
        },
      );
    },
  );
}

  // Helper method to build consistent menu items with MediaQuery
  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Color bgColor,
    required Function onTap,
    required double screenWidth,
    required double screenHeight,
    Color iconColor = Colors.black87,
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: screenWidth * 0.09,
                  height: screenWidth * 0.09,
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(screenWidth * 0.02),
                  ),
                  child: Icon(
                    icon,
                    size: screenWidth * 0.05,
                    color: iconColor,
                  ),
                ),
                SizedBox(width: screenWidth * 0.06),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: () => onTap(),
              icon: Icon(
                Icons.arrow_forward_ios,
                size: screenWidth * 0.04,
                color: Colors.black54,
              ),
            ),
          ],
        ),
        const Divider(),
        SizedBox(height: screenHeight * 0.02),
      ],
    );
  }
}