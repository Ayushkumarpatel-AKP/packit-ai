import 'package:flutter/material.dart';
import '../data/sample_data.dart';

class HomeDashboardScreen extends StatelessWidget {
  final VoidCallback onToggleTheme;
  final Function(int) onNavigateTab;
  final Function(String route, {dynamic arguments}) onNavigate;

  const HomeDashboardScreen({
    super.key,
    required this.onToggleTheme,
    required this.onNavigateTab,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF10B981), Color(0xFF4F46E5)],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.eco_rounded,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'PackIT AI',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color:
                              isDark ? Colors.white : const Color(0xFF0F172A),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: onToggleTheme,
                        icon: Icon(
                          isDark
                              ? Icons.light_mode_outlined
                              : Icons.dark_mode_outlined,
                          color: isDark
                              ? const Color(0xFFFBBF24)
                              : const Color(0xFF475569),
                        ),
                      ),
                      Stack(
                        children: [
                          IconButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      '🔔 3 Packaging Audits completed successfully!'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.notifications_outlined,
                              color: isDark
                                  ? Colors.white
                                  : const Color(0xFF475569),
                            ),
                          ),
                          Positioned(
                            top: 10,
                            right: 12,
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Color(0xFFEF4444),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 18),

              // AI Expert Prompt / Search Card
              InkWell(
                onTap: () => onNavigate('ai_chat'),
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: isDark
                          ? [
                              const Color(0xFF1E1B4B),
                              const Color(0xFF312E81),
                            ]
                          : [
                              const Color(0xFFEEF2FF),
                              const Color(0xFFE0E7FF),
                            ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFF818CF8).withValues(alpha: 0.4),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: const Color(0xFF4F46E5),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(
                          Icons.auto_awesome_rounded,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Ask our AI Packaging Expert...',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: isDark
                                    ? Colors.white
                                    : const Color(0xFF1E1B4B),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '"Suggest packaging for my mango chips for 6 months shelf life"',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 11.5,
                                fontStyle: FontStyle.italic,
                                color: isDark
                                    ? const Color(0xFFC7D2FE)
                                    : const Color(0xFF4338CA),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 14,
                        color: Color(0xFF4F46E5),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 22),

              // 2x3 Grid of 6 Modules
              GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.82,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildModuleCard(
                    context: context,
                    icon: Icons.inventory_2_outlined,
                    label: 'Packaging\nRecommendation',
                    badgeColor: const Color(0xFF3B82F6),
                    onTap: () => onNavigate('product_input'),
                  ),
                  _buildModuleCard(
                    context: context,
                    icon: Icons.hourglass_top_rounded,
                    label: 'Shelf Life\nPrediction',
                    badgeColor: const Color(0xFF8B5CF6),
                    onTap: () => onNavigate('shelf_life'),
                  ),
                  _buildModuleCard(
                    context: context,
                    icon: Icons.flip_camera_android_rounded,
                    label: 'Packaging\nSimulator (Digital Twin)',
                    badgeColor: const Color(0xFF10B981),
                    onTap: () => onNavigate('digital_twin'),
                  ),
                  _buildModuleCard(
                    context: context,
                    icon: Icons.qr_code_scanner_rounded,
                    label: 'Camera Scan\nIdentify Packaging',
                    badgeColor: const Color(0xFFEF4444),
                    onTap: () => onNavigate('packaging_auditor'),
                  ),
                  _buildModuleCard(
                    context: context,
                    icon: Icons.currency_rupee_rounded,
                    label: 'Cost & Sustainability\nOptimizer',
                    badgeColor: const Color(0xFF06B6D4),
                    onTap: () => onNavigate('cost_sustainability'),
                  ),
                  _buildModuleCard(
                    context: context,
                    icon: Icons.storefront_rounded,
                    label: 'Supplier &\nMarketplace',
                    badgeColor: const Color(0xFFF97316),
                    onTap: () => onNavigate('suppliers'),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Popular Products Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Popular Products',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: isDark ? Colors.white : const Color(0xFF0F172A),
                    ),
                  ),
                  TextButton(
                    onPressed: () => onNavigate('product_input'),
                    child: const Text(
                      'View All',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF4F46E5),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              SizedBox(
                height: 105,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  clipBehavior: Clip.none,
                  children: [
                    _buildProductPill(
                      context: context,
                      name: 'Chips',
                      icon: Icons.cookie_outlined,
                      imageUrl:
                          'https://images.unsplash.com/photo-1566478989037-eec170784d0b?w=200&auto=format&fit=crop&q=80',
                      onTap: () => onNavigate(
                        'recommendation_result',
                        arguments: SampleData.products[0],
                      ),
                    ),
                    _buildProductPill(
                      context: context,
                      name: 'Milk',
                      icon: Icons.local_drink_outlined,
                      imageUrl:
                          'https://images.unsplash.com/photo-1550583724-b2692b85b150?w=200&auto=format&fit=crop&q=80',
                      onTap: () => onNavigate(
                        'recommendation_result',
                        arguments: SampleData.products[2],
                      ),
                    ),
                    _buildProductPill(
                      context: context,
                      name: 'Fruits',
                      icon: Icons.apple_outlined,
                      imageUrl:
                          'https://images.unsplash.com/photo-1619566636858-adf3ef46400b?w=200&auto=format&fit=crop&q=80',
                      onTap: () => onNavigate(
                        'recommendation_result',
                        arguments: SampleData.products[1],
                      ),
                    ),
                    _buildProductPill(
                      context: context,
                      name: 'Vegetables',
                      icon: Icons.eco_outlined,
                      imageUrl:
                          'https://images.unsplash.com/photo-1592924357228-91a4daadcfea?w=200&auto=format&fit=crop&q=80',
                      onTap: () => onNavigate(
                        'recommendation_result',
                        arguments: SampleData.products[3],
                      ),
                    ),
                    _buildProductPill(
                      context: context,
                      name: 'Meat',
                      icon: Icons.restaurant_outlined,
                      imageUrl:
                          'https://images.unsplash.com/photo-1603048588665-791ca8aea617?w=200&auto=format&fit=crop&q=80',
                      onTap: () => onNavigate(
                        'recommendation_result',
                        arguments: SampleData.products[4],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Quick Action Card: Launch 3D Customizer USP
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: const Color(0xFF6366F1).withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: const Color(0xFF818CF8),
                          width: 1,
                        ),
                      ),
                      child: const Icon(
                        Icons.view_in_ar_rounded,
                        color: Color(0xFF818CF8),
                        size: 26,
                      ),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '3D Packaging Customizer',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Interactive 360° Material & Thickness Simulator',
                            style: TextStyle(
                              color: Color(0xFF94A3B8),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => onNavigate('customizer_3d'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4F46E5),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Launch',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModuleCard({
    required BuildContext context,
    required IconData icon,
    required String label,
    required Color badgeColor,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E293B) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withValues(alpha: 0.2)
                  : const Color(0x06000000),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: badgeColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: badgeColor, size: 22),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 10.5,
                fontWeight: FontWeight.w700,
                height: 1.15,
                color: isDark ? Colors.white : const Color(0xFF1E293B),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductPill({
    required BuildContext context,
    required String name,
    required IconData icon,
    required String imageUrl,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 74,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E293B) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                imageUrl,
                width: 44,
                height: 44,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 44,
                  height: 44,
                  color: const Color(0xFFEEF2FF),
                  child: Icon(icon, color: const Color(0xFF4F46E5), size: 22),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.white : const Color(0xFF1E293B),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
