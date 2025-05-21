

// import 'package:car_rental_app/utils/storage_helper.dart';
// import 'package:flutter/material.dart';
// import 'package:dotted_border/dotted_border.dart';

// class InviteFriendsScreen extends StatefulWidget {

//   const InviteFriendsScreen({super.key});

//   @override
//   State<InviteFriendsScreen> createState() => _InviteFriendsScreenState();
// }

// class _InviteFriendsScreenState extends State<InviteFriendsScreen> {
//   late final String inviteCode;

//     @override
//   void initState() {
//     super.initState();
//     _loadUserData();
//   }


//     Future<void> _loadUserData() async {
//     try {
//        inviteCode = await StorageHelper.getCode().toString();
//       if (inviteCode != null) {
//             setState(() {
//               inviteCode = inviteCode;
//             }); // to refresh UI
//           }
//     } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//               content: Text('Failed to load coupon data: ${e.toString()}')),
//         );
//   }}

//   @override
//   Widget build(BuildContext context) {
//     // Get the screen size
//     final mediaQuery = MediaQuery.of(context);
//     final screenWidth = mediaQuery.size.width;
//     final screenHeight = mediaQuery.size.height;
//     final isSmallDevice = screenHeight < 700;
    
//     // Adjust padding and sizing based on device size
//     final horizontalPadding = screenWidth * 0.05; // 5% of screen width
//     final verticalSpacing = isSmallDevice ? 16.0 : 24.0;
//     final imageHeight = isSmallDevice ? screenHeight * 0.2 : screenHeight * 0.25;
    
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Back arrow and title
//                 SizedBox(height: isSmallDevice ? 20 : 40),
//                 Row(
//                   children: [
//                     GestureDetector(
//                       onTap: () => Navigator.pop(context),
//                       child: const Icon(Icons.arrow_back),
//                     ),
//                     const SizedBox(width: 12),
//                     const Text(
//                       "Invite your friends",
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ],
//                 ),

//                 SizedBox(height: verticalSpacing),

//                 // Top Illustration
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(12),
//                   child: Image.asset(
//                     'assets/invite.png',
//                     height: imageHeight,
//                     width: double.infinity,
//                     fit: BoxFit.cover,
//                   ),
//                 ),

//                 SizedBox(height: verticalSpacing),

//                 // Earn a free car text
//                 const Align(
//                   alignment: Alignment.center,
//                   child: Text(
//                     "Earn a free car",
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 const Align(
//                   alignment: Alignment.center,
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 8.0),
//                     child: Text(
//                       "Did you know you can earn up to AED 3000 by referring 10 friends in a month ? That's equal to a month subscription.",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 13,
//                         color: Colors.black54,
//                       ),
//                     ),
//                   ),
//                 ),

//                 SizedBox(height: isSmallDevice ? 30 : 45),

//                 // Invite code box
//                 Center(
//                   child: DottedBorder(
//                     borderType: BorderType.RRect,
//                     radius: const Radius.circular(12),
//                     dashPattern: const [6, 3],
//                     color: Colors.black,
//                     strokeWidth: 1.2,
//                     child: Container(
//                       padding: EdgeInsets.symmetric(
//                           horizontal: screenWidth * 0.06, 
//                           vertical: isSmallDevice ? 12 : 16),
//                       decoration: BoxDecoration(
//                         color: const Color(0xFF2D1DFF),
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Text(
//                         inviteCode,
//                         style: TextStyle(
//                           fontSize: isSmallDevice ? 16 : 18,
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           letterSpacing: 2,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),

//                 SizedBox(height: isSmallDevice ? 30 : 40),

//                 // Buttons - Responsive layout for different screen sizes
//                 screenWidth < 360
//                     ? Column(
//                         children: [
//                           _buildCopyButton(context),
//                           const SizedBox(height: 12),
//                           _buildShareButton(context),
//                         ],
//                       )
//                     : Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           _buildCopyButton(context),
//                           _buildShareButton(context),
//                         ],
//                       ),
                      
//                 const SizedBox(height: 16),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildCopyButton(BuildContext context) {
//     return OutlinedButton(
//       onPressed: () {},
//       style: OutlinedButton.styleFrom(
//         side: const BorderSide(color: Colors.black87),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//       ),
//       child: const Padding(
//         padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//         child: Text(
//           "Copy invite code",
//           style: TextStyle(color: Colors.black),
//         ),
//       ),
//     );
//   }

//   Widget _buildShareButton(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () {},
//       style: ElevatedButton.styleFrom(
//         backgroundColor: const Color(0xFF2D1DFF),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       ),
//       child: const Text(
//         "Share invite code",
//         style: TextStyle(color: Colors.white),
//       ),
//     );
//   }
// }






import 'package:car_rental_app/utils/storage_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:share_plus/share_plus.dart';

class InviteFriendsScreen extends StatefulWidget {
  const InviteFriendsScreen({super.key});

  @override
  State<InviteFriendsScreen> createState() => _InviteFriendsScreenState();
}

class _InviteFriendsScreenState extends State<InviteFriendsScreen> {
  String inviteCode = 'Loading...';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    setState(() {
      _isLoading = true;
    });
    
    try {
      final code = await StorageHelper.getCode();
      if (code != null) {
        setState(() {
          inviteCode = code;
          _isLoading = false;
        });
      } else {
        setState(() {
          inviteCode = 'No code available';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        inviteCode = 'Error loading code';
        _isLoading = false;
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load invite code: ${e.toString()}')),
        );
      }
    }
  }

  // Copy invite code to clipboard
  void _copyInviteCode() {
    if (inviteCode != 'Loading...' && inviteCode != 'Error loading code' && inviteCode != 'No code available') {
      Clipboard.setData(ClipboardData(text: inviteCode));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invite code copied to clipboard!'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No valid invite code to copy'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  // Share invite code
  void _shareInviteCode() {
    if (inviteCode != 'Loading...' && inviteCode != 'Error loading code' && inviteCode != 'No code available') {
      final String shareText = 'Join me on Car Rental App! Use my invite code: $inviteCode and get special discounts on your first rental.';
      Share.share(shareText);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No valid invite code to share'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    final isSmallDevice = screenHeight < 700;
    
    // Adjust padding and sizing based on device size
    final horizontalPadding = screenWidth * 0.05; // 5% of screen width
    final verticalSpacing = isSmallDevice ? 16.0 : 24.0;
    final imageHeight = isSmallDevice ? screenHeight * 0.2 : screenHeight * 0.25;
            final paddingValue = screenWidth * 0.04;

    
    return Scaffold(
      backgroundColor: Colors.white,
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
          "Invite your friends",
          style: TextStyle(
            color: Colors.black,
            fontSize: screenWidth * 0.045,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                SizedBox(height: verticalSpacing),

                // Top Illustration
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/invite.png',
                    height: imageHeight,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                SizedBox(height: verticalSpacing),

                // Earn a free car text
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Earn a free car",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "Did you know you can earn up to AED 3000 by referring 10 friends in a month ? That's equal to a month subscription.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: isSmallDevice ? 30 : 45),

                // Invite code box
                Center(
                  child: DottedBorder(
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(12),
                    dashPattern: const [6, 3],
                    color: Colors.black,
                    strokeWidth: 1.2,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.06, 
                          vertical: isSmallDevice ? 12 : 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2D1DFF),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              inviteCode,
                              style: TextStyle(
                                fontSize: isSmallDevice ? 16 : 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                              ),
                            ),
                    ),
                  ),
                ),

                SizedBox(height: isSmallDevice ? 30 : 40),

                // Buttons - Responsive layout for different screen sizes
                screenWidth < 360
                    ? Column(
                        children: [
                          _buildCopyButton(context),
                          const SizedBox(height: 12),
                          _buildShareButton(context),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildCopyButton(context),
                          _buildShareButton(context),
                        ],
                      ),
                      
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCopyButton(BuildContext context) {
    return OutlinedButton(
      onPressed: _isLoading ? null : _copyInviteCode,
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: _isLoading ? Colors.grey : Colors.black87),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Text(
          "Copy invite code",
          style: TextStyle(color: _isLoading ? Colors.grey : Colors.black),
        ),
      ),
    );
  }

  Widget _buildShareButton(BuildContext context) {
    return ElevatedButton(
      onPressed: _isLoading ? null : _shareInviteCode,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF2D1DFF),
        disabledBackgroundColor: Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      child: const Text(
        "Share invite code",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}