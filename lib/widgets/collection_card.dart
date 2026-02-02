import 'package:flutter/material.dart';

import '../models/collection.dart';

class CollectionCard extends StatefulWidget {
  final Collection collection;
  final bool isExpanded;
  final VoidCallback onTap;

  const CollectionCard({
    super.key,
    required this.collection,
    required this.isExpanded,
    required this.onTap,
  });

  @override
  State<CollectionCard> createState() => _CollectionCardState();
}

class _CollectionCardState extends State<CollectionCard> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    setState(() {});
  }

  int _getVisibleImageCount(double screenWidth, double imageSide,
      double imageSpacing, double horizontalPadding) {
    if (!_scrollController.hasClients) {
      return 4;
    }

    double scrollOffset = _scrollController.position.pixels;
    double itemWidth = imageSide + imageSpacing;
    double viewportWidth = screenWidth - 2 * horizontalPadding;

    double viewportItemCount = viewportWidth / itemWidth;
    int initialFullyVisible = viewportItemCount.floor();

    double thresholdForNextImage =
        itemWidth * (initialFullyVisible + 1 - viewportItemCount);

    int fullyVisibleCount = initialFullyVisible +
        ((scrollOffset + thresholdForNextImage) / itemWidth).floor();

    return fullyVisibleCount;
  }

  int _getRemainingCount(double screenWidth, double imageSide,
      double imageSpacing, double horizontalPadding) {
    int visibleCount = _getVisibleImageCount(
        screenWidth, imageSide, imageSpacing, horizontalPadding);
    int totalImages = widget.collection.productImages.length;
    int remaining = totalImages - visibleCount;
    return remaining > 0 ? remaining : 0;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final horizontalPadding = screenWidth * 0.04;
    final cardMargin = screenWidth * 0.04;
    final imageSide = screenWidth * 0.17;
    final imageSpacing = screenWidth * 0.03;
    final fontSize = screenWidth * 0.039;
    final badgeFontSize = screenWidth * 0.029;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: cardMargin, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(5),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Card header
          InkWell(
            onTap: widget.onTap,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding, vertical: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.collection.title,
                    style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  Icon(
                    widget.isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colors.black87,
                  ),
                ],
              ),
            ),
          ),

          // Expandable content
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Padding(
              padding: EdgeInsets.only(
                  left: horizontalPadding,
                  right: horizontalPadding,
                  bottom: 18),
              child: Stack(
                children: [
                  // Scrollable images
                  SizedBox(
                    height: imageSide,
                    child: ListView.builder(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.collection.productImages.length,
                      itemBuilder: (context, i) {
                        return Padding(
                          padding: EdgeInsets.only(
                              right:
                                  i < widget.collection.productImages.length - 1
                                      ? imageSpacing
                                      : 0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              widget.collection.productImages[i],
                              width: imageSide,
                              height: imageSide,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: imageSide,
                                  height: imageSide,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(Icons.image,
                                      color: Colors.grey),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // +N badge - dynamic based on visible images
                  if (_getRemainingCount(screenWidth, imageSide, imageSpacing,
                          horizontalPadding) >
                      0)
                    Positioned(
                      right: -8,
                      top: 0,
                      bottom: 0,
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.025,
                            vertical: screenWidth * 0.015,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(192),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '+${_getRemainingCount(screenWidth, imageSide, imageSpacing, horizontalPadding)}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: badgeFontSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            crossFadeState: widget.isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
            sizeCurve: Curves.easeInOut,
          ),
        ],
      ),
    );
  }
}
