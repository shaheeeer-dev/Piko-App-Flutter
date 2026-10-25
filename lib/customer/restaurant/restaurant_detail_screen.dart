import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:piko/customer/restaurant/menu_screen.dart';
import 'package:piko/shared/theme/app_colors.dart';
import 'package:piko/shared/widgets/piko_button.dart';

class RestaurantDetailScreen extends StatefulWidget {
  final String restaurantName;
  final String tagline;
  final String rating;
  final String reviewCount;
  final String distance;
  final String priceRange;
  final String address;
  final String readyTime;
  final String openHours;
  final String description;
  final String heroSvg;

  const RestaurantDetailScreen({
    super.key,
    this.restaurantName = 'June Coffee',
    this.tagline = 'A small space for really good coffee.',
    this.rating = '4.9',
    this.reviewCount = '128',
    this.distance = '0.4 km',
    this.priceRange = 'Rs. 300–900',
    this.address = '24 Main Boulevard, Gulberg, Lahore',
    this.readyTime = '10–15 minutes',
    this.openHours = 'Open until 8 PM',
    this.description =
        'Specialty coffee, warm pastries, and a slower start to your day. Freshly made, just around the corner.',
    this.heroSvg = 'assets/images/cafe_hero.svg',
  });

  @override
  State<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ivory,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(28, 12, 28, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Bar
              _buildTopBar(context),

              const SizedBox(height: 18),

              // Hero Image Card
              _buildHeroBanner(),

              const SizedBox(height: 20),

              // Open Status Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.chipBg,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  widget.openHours,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    color: AppColors.forest,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // Café Name
              Text(
                widget.restaurantName,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  color: AppColors.ink,
                  fontSize: 32,
                  height: 1.05,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -1.2,
                ),
              ),

              const SizedBox(height: 8),

              // Tagline
              Text(
                widget.tagline,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  color: AppColors.subtext,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),

              const SizedBox(height: 12),

              // Meta row (Rating, Distance, Price)
              Row(
                children: [
                  const Icon(
                    Icons.star_rounded,
                    color: Color(0xFFD4A017),
                    size: 17,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${widget.rating} (${widget.reviewCount})',
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      color: AppColors.ink,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      '•',
                      style: TextStyle(color: AppColors.muted, fontSize: 12),
                    ),
                  ),
                  Text(
                    widget.distance,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      color: AppColors.muted,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      '•',
                      style: TextStyle(color: AppColors.muted, fontSize: 12),
                    ),
                  ),
                  Text(
                    widget.priceRange,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      color: AppColors.muted,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 22),

              // Ready in 10-15 min Card
              _buildPickupCard(),

              const SizedBox(height: 14),

              // Location & Directions Card
              _buildLocationCard(),

              const SizedBox(height: 24),

              // Story section
              const Text(
                'Made with a little care',
                style: TextStyle(
                  fontFamily: 'Inter',
                  color: AppColors.ink,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.4,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                widget.description,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  color: AppColors.subtext,
                  fontSize: 13.5,
                  height: 1.45,
                  fontWeight: FontWeight.w400,
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(28, 8, 28, 16),
          child: PrimaryButton(
            text: 'Explore the menu',
            trailing: const Icon(
              Icons.arrow_forward_rounded,
              color: AppColors.lime,
              size: 20,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MenuScreen(
                    restaurantName: widget.restaurantName,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return SizedBox(
      height: 28,
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 16,
              color: AppColors.muted,
            ),
          ),
          const Expanded(
            child: Center(
              child: Text(
                'Café detail',
                style: TextStyle(
                  fontFamily: 'Inter',
                  color: AppColors.muted,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _isFavorite = !_isFavorite;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(seconds: 1),
                  content: Text(
                    _isFavorite
                        ? '${widget.restaurantName} saved to favorites'
                        : 'Removed from favorites',
                  ),
                ),
              );
            },
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: Icon(
              _isFavorite
                  ? Icons.bookmark_rounded
                  : Icons.bookmark_outline_rounded,
              size: 22,
              color: _isFavorite ? AppColors.forest : AppColors.muted,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroBanner() {
    return Container(
      width: double.infinity,
      height: 180,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: const Color(0xFFE8DFD0),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.line, width: 1.2),
      ),
      child: SvgPicture.asset(
        widget.heroSvg,
        fit: BoxFit.cover,
        placeholderBuilder: (context) => Container(
          color: const Color(0xFFE8DFD0),
          alignment: Alignment.center,
          child: const Icon(
            Icons.coffee_rounded,
            size: 48,
            color: AppColors.forest,
          ),
        ),
      ),
    );
  }

  Widget _buildPickupCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.line, width: 1.2),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFFEDF1E7),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.schedule_rounded,
              color: AppColors.forest,
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ready in ${widget.readyTime}',
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    color: AppColors.ink,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                const Text(
                  'Order now, pick up on your schedule.',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    color: AppColors.subtext,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.line, width: 1.2),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F0EC),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.location_on_outlined,
              color: AppColors.ink,
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.address,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    color: AppColors.ink,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                const Text(
                  'View directions ↗',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    color: AppColors.forest,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
