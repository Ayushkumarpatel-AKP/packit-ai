import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/simulation_chart.dart';

class CostSustainabilityScreen extends StatefulWidget {
  final VoidCallback onBack;

  const CostSustainabilityScreen({super.key, required this.onBack});

  @override
  State<CostSustainabilityScreen> createState() =>
      _CostSustainabilityScreenState();
}

class _CostSustainabilityScreenState extends State<CostSustainabilityScreen> {
  int _selectedOption = 1; // 0: Option 1, 1: Option 2 (Recommended), 2: Option 3

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: widget.onBack,
        ),
        title: const Text(
          'Cost & Sustainability Analysis',
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
        decoration: BoxDecoration(
          color: isDark ? AppTheme.surfaceDark : Colors.white,
          border: Border(
            top: BorderSide(
              color:
                  isDark ? AppTheme.cardBorderDark : AppTheme.cardBorderLight,
            ),
          ),
        ),
        child: Container(
          width: double.infinity,
          height: 54,
          decoration: AppTheme.gradientButtonDecoration(),
          child: ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                      '✅ Cost-Benefit & ESG Analysis exported to Procurement Dashboard!'),
                  backgroundColor: Color(0xFF10B981),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Select & Send to Procurement',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 8),
                Icon(Icons.check_circle_outline_rounded,
                    color: Colors.white, size: 18),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 3 Column Comparison Cards Row
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Option 1: Standard PET + LDPE
                  Expanded(
                    child: _buildOptionColumn(
                      index: 0,
                      title: 'Option 1',
                      subtitle: 'Standard\nPET + LDPE',
                      cost: '₹1.20',
                      shelfLife: '4 Months',
                      protectionScore: 70,
                      sustainabilityScore: 60,
                      badge: 'Recyclable',
                      badgeColor: const Color(0xFF3B82F6),
                      isSelected: _selectedOption == 0,
                      isDark: isDark,
                      imageUrl:
                          'https://images.unsplash.com/photo-1566478989037-eec170784d0b?w=200&auto=format&fit=crop&q=80',
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Option 2: Recommended Metallized PET (Hero)
                  Expanded(
                    child: _buildOptionColumn(
                      index: 1,
                      title: 'Option 2',
                      subtitle: 'Recommended\nMetallized PET',
                      cost: '₹1.80',
                      shelfLife: '6 Months',
                      protectionScore: 95,
                      sustainabilityScore: 60,
                      badge: 'Recyclable',
                      badgeColor: const Color(0xFF10B981),
                      isRecommended: true,
                      isSelected: _selectedOption == 1,
                      isDark: isDark,
                      imageUrl:
                          'https://images.unsplash.com/photo-1566478989037-eec170784d0b?w=200&auto=format&fit=crop&q=80',
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Option 3: Eco-Friendly Biodegradable
                  Expanded(
                    child: _buildOptionColumn(
                      index: 2,
                      title: 'Option 3',
                      subtitle: 'Eco-Friendly\nBiodegradable',
                      cost: '₹2.10',
                      shelfLife: '5 Months',
                      protectionScore: 80,
                      sustainabilityScore: 75,
                      badge: 'Compostable',
                      badgeColor: const Color(0xFF059669),
                      isSelected: _selectedOption == 2,
                      isDark: isDark,
                      imageUrl:
                          'https://images.unsplash.com/photo-1566478989037-eec170784d0b?w=200&auto=format&fit=crop&q=80',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              // Cost vs Shelf Life vs Sustainability Bar Chart
              const CostSustainabilityBarChart(),

              const SizedBox(height: 16),

              // Executive ROI Summary Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1E293B) : Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: isDark
                        ? const Color(0xFF334155)
                        : const Color(0xFFE2E8F0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: const Color(0xFF10B981)
                                .withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.auto_graph_rounded,
                            color: Color(0xFF10B981),
                            size: 18,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'AI Recommendation Insights',
                          style: TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      '• Option 2 (Metallized PET) delivers +50% longer shelf life for only ₹0.60 extra cost per unit.\n• Reduces supply chain spoilage loss by 28% while maintaining standard recyclability classification.',
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.4,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionColumn({
    required int index,
    required String title,
    required String subtitle,
    required String cost,
    required String shelfLife,
    required int protectionScore,
    required int sustainabilityScore,
    required String badge,
    required Color badgeColor,
    bool isRecommended = false,
    required bool isSelected,
    required bool isDark,
    required String imageUrl,
  }) {
    return GestureDetector(
      onTap: () => setState(() => _selectedOption = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark ? const Color(0xFF1E1B4B) : const Color(0xFFEEF2FF))
              : (isDark ? const Color(0xFF1E293B) : Colors.white),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isRecommended
                ? const Color(0xFF10B981)
                : (isSelected
                    ? const Color(0xFF4F46E5)
                    : (isDark
                        ? const Color(0xFF334155)
                        : const Color(0xFFE2E8F0))),
            width: isSelected || isRecommended ? 2 : 1,
          ),
          boxShadow: [
            if (isRecommended || isSelected)
              BoxShadow(
                color: (isRecommended
                        ? const Color(0xFF10B981)
                        : const Color(0xFF4F46E5))
                    .withValues(alpha: 0.15),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
          ],
        ),
        child: Column(
          children: [
            // Top Badge
            if (isRecommended)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                margin: const EdgeInsets.only(bottom: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'RECOMMENDED',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 7.5,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            Text(
              title,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : const Color(0xFF0F172A),
              ),
            ),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(
                fontSize: 9.5,
                color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 6),

            // Packet Graphic Thumbnail
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imageUrl,
                width: 48,
                height: 52,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.fastfood, size: 36, color: Color(0xFFD97706)),
              ),
            ),

            const SizedBox(height: 8),

            // Cost per Pack
            Text(
              cost,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w900,
                color: Color(0xFF4F46E5),
              ),
            ),
            const Text(
              'per pack',
              style: TextStyle(fontSize: 8.5, color: Color(0xFF64748B)),
            ),

            const SizedBox(height: 6),
            const Divider(height: 10),

            // Shelf Life
            const Text('Shelf Life',
                style: TextStyle(fontSize: 8.5, color: Color(0xFF64748B))),
            Text(
              shelfLife,
              style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 6),

            // Protection Score
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Prot.', style: TextStyle(fontSize: 8.5)),
                Text('$protectionScore',
                    style: TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.bold,
                        color: protectionScore >= 90
                            ? const Color(0xFF10B981)
                            : const Color(0xFFF59E0B))),
              ],
            ),

            // Sustainability Score
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Sust.', style: TextStyle(fontSize: 8.5)),
                Text('$sustainabilityScore',
                    style: TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.bold,
                        color: sustainabilityScore >= 70
                            ? const Color(0xFF10B981)
                            : const Color(0xFF3B82F6))),
              ],
            ),

            const SizedBox(height: 8),

            // Badge (Recyclable / Compostable)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              decoration: BoxDecoration(
                color: badgeColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.recycling_rounded, size: 10, color: badgeColor),
                  const SizedBox(width: 3),
                  Text(
                    badge,
                    style: TextStyle(
                      fontSize: 8.5,
                      fontWeight: FontWeight.bold,
                      color: badgeColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
