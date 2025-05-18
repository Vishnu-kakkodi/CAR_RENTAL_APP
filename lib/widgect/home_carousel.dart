import 'package:flutter/material.dart';

class HomeCarousel extends StatefulWidget {
  final double height;
  final List<String> imageAssets;
  final Duration autoPlayDuration;

  const HomeCarousel({
    Key? key,
    required this.height,
    required this.imageAssets,
    this.autoPlayDuration = const Duration(seconds: 3),
  }) : super(key: key);

  @override
  State<HomeCarousel> createState() => _HomeCarouselState();
}

class _HomeCarouselState extends State<HomeCarousel> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    
    // Auto-play functionality
    if (widget.autoPlayDuration.inMilliseconds > 0) {
      Future.delayed(const Duration(milliseconds: 300), () {
        _autoPlayCarousel();
      });
    }
  }

  void _autoPlayCarousel() {
    Future.delayed(widget.autoPlayDuration, () {
      if (_pageController.hasClients) {
        if (_currentPage < widget.imageAssets.length - 1) {
          _pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn,
          );
        } else {
          _pageController.animateToPage(
            0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn,
          );
        }
        _autoPlayCarousel();
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.imageAssets.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return Image.asset(
                  widget.imageAssets[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: List.generate(
            widget.imageAssets.length,
            (index) => Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Container(
                height: 6,
                width: index == _currentPage ? 50 : 8,
                decoration: BoxDecoration(
                  color: const Color(0XFF120698),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
