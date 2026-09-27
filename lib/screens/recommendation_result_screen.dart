import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/food_item.dart';
import '../widgets/layer_stack_widget.dart';

class RecommendationResultScreen extends StatefulWidget {
  final FoodProduct product;
  final VoidCallback onBack;
  final VoidCallback onViewSimulation;
  final VoidCallback onCustomizePackaging;

  const RecommendationResultScreen({
    super.key,
    required this.product,
    required this.onBack,
    required this.onViewSimulation,
    required this.onCustomizePackaging,
  });

  @override
  State<RecommendationResultScreen> createState() =>
      _RecommendationResultScreenState();
}

class _RecommendationResultScreenState
    extends State<RecommendationResultScreen> {
  int _selectedOptionIndex = 1; // 0: Standard, 1: Recommended, 2: Eco-Friendly

  // 3 Distinct Packaging Structure Options
  final List<Map<String, dynamic>> _packagingOptions = [
    {
      'title': 'Option 1',
      'subtitle': 'Standard PET+LDPE',
      'cost': '₹1.20',
      'shelfLife': '4 Months',
      'protection': '70%',
      'matchScore': 78,
      'badge': 'Recyclable',
      'badgeColor': Color(0xFF3B82F6),
      'otr': '< 45 cc/m²/day',
      'wvtr': '< 3.5 g/m²/day',
      'thickness': '70 µm (Total)',
      'sealability': 'Good',
      'mechanical': 'Medium',
      'layers': [
        PackagingLayer(
          name: 'PET (12 µm)',
          thicknessMicrons: 12,
          role: 'Print & Gloss Layer',
          layerColor: Color(0xFFF59E0B),
          materialDescription: 'Standard Polyester print film',
        ),
        PackagingLayer(
          name: 'LDPE (58 µm)',
          thicknessMicrons: 58,
          role: 'Sealant Layer',
          layerColor: Color(0xFF38BDF8),
          materialDescription: 'Low-density polyethylene sealing',
        ),
      ],
    },
    {
      'title': 'Option 2',
      'subtitle': 'Recommended (MET)',
      'cost': '₹1.80',
      'shelfLife': '6 Months',
      'protection': '95%',
      'matchScore': 95,
      'badge': 'Best Match',
      'badgeColor': Color(0xFF10B981),
      'isRecommended': true,
      'otr': '< 1.0 cc/m²/day',
      'wvtr': '< 0.5 g/m²/day',
      'thickness': '99 µm (Total)',
      'sealability': 'Excellent',
      'mechanical': 'High Barrier',
      'layers': [
        PackagingLayer(
          name: 'PET (12 µm)',
          thicknessMicrons: 12,
          role: 'Print & Gloss Layer',
          layerColor: Color(0xFFF59E0B),
          materialDescription: 'Polyethylene Terephthalate - High clarity & gloss',
        ),
        PackagingLayer(
          name: 'Metallized PET (12 µm)',
          thicknessMicrons: 12,
          role: 'Ultra Barrier Layer',
          layerColor: Color(0xFFE0E7FF),
          materialDescription: 'Met-PET - Zero oxygen & light transmission',
        ),
        PackagingLayer(
          name: 'LDPE (75 µm)',
          thicknessMicrons: 75,
          role: 'Sealant Layer',
          layerColor: Color(0xFF38BDF8),
          materialDescription: 'Low-Density Polyethylene - Hermetic sealing',
        ),
      ],
    },
    {
      'title': 'Option 3',
      'subtitle': 'Eco-Bio PLA',
      'cost': '₹2.10',
      'shelfLife': '5 Months',
      'protection': '80%',
      'matchScore': 86,
      'badge': 'Compostable',
      'badgeColor': Color(0xFF059669),
      'otr': '< 15 cc/m²/day',
      'wvtr': '< 2.0 g/m²/day',
      'thickness': '85 µm (Total)',
      'sealability': 'Bio-Sealed',
      'mechanical': 'Tear Resistant',
      'layers': [
        PackagingLayer(
          name: 'Cellulose Bio-Film (20 µm)',
          thicknessMicrons: 20,
          role: 'Print Layer',
          layerColor: Color(0xFFD4A373),
          materialDescription: 'FSC Certified NatureFlex™ bio-cellulose',
        ),
        PackagingLayer(
          name: 'Bio-PBS Barrier (15 µm)',
          thicknessMicrons: 15,
          role: 'Renewable Barrier',
          layerColor: Color(0xFFCCD5AE),
          materialDescription: 'Polybutylene succinate bio-barrier',
        ),
        PackagingLayer(
          name: 'PLA Sealant (50 µm)',
          thicknessMicrons: 50,
          role: 'Compostable Seal',
          layerColor: Color(0xFF10B981),
          materialDescription: '100% Home & Industrial Compostable',
        ),
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final activeOption = _packagingOptions[_selectedOptionIndex];
    final layers = activeOption['layers'] as List<PackagingLayer>;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: widget.onBack,
        ),
        title: Text(
          'AI Packaging Recommendation\nfor ${widget.product.name}',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 14,
            height: 1.2,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('📤 Packaging Specification Report exported as PDF!'),
                ),
              );
            },
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
        decoration: BoxDecoration(
          color: isDark ? AppTheme.surfaceDark : Colors.white,
          border: Border(
            top: BorderSide(
              color:
                  isDark ? AppTheme.cardBorderDark : AppTheme.cardBorderLight,
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: OutlinedButton(
                onPressed: widget.onViewSimulation,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  side: const BorderSide(color: Color(0xFF4F46E5), width: 1.5),
                ),
                child: const Text(
                  'Simulation',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF4F46E5),
                    fontSize: 13,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 2,
              child: Container(
                height: 50,
                decoration: AppTheme.gradientButtonDecoration(),
                child: ElevatedButton(
                  onPressed: widget.onCustomizePackaging,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Customize Packaging',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(Icons.arrow_forward_rounded,
                          color: Colors.white, size: 16),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 3 Selectable Option Cards (Option 1 Standard, Option 2 Recommended, Option 3 Eco-Friendly)
              Text(
                'AI Formulated Packaging Options',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: isDark ? Colors.white : const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 8),

              Row(
                children: List.generate(3, (index) {
                  final opt = _packagingOptions[index];
                  final isSelected = _selectedOptionIndex == index;
                  final isRec = opt['isRecommended'] == true;

                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      child: InkWell(
                        onTap: () => setState(() => _selectedOptionIndex = index),
                        borderRadius: BorderRadius.circular(14),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? (isDark ? const Color(0xFF1E1B4B) : const Color(0xFFEEF2FF))
                                : (isDark ? const Color(0xFF1E293B) : Colors.white),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFF4F46E5)
                                  : (isRec
                                      ? const Color(0xFF10B981)
                                      : (isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0))),
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              if (isRec)
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                                  margin: const EdgeInsets.only(bottom: 2),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF10B981),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: const Text(
                                    '95% MATCH',
                                    style: TextStyle(color: Colors.white, fontSize: 7, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              Text(
                                opt['title'] as String,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? Colors.white : const Color(0xFF0F172A),
                                ),
                              ),
                              Text(
                                opt['cost'] as String,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFF4F46E5),
                                ),
                              ),
                              Text(
                                opt['shelfLife'] as String,
                                style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),

              const SizedBox(height: 14),

              // Hero Visual Card with Dynamic Option Specs
              Container(
                height: 175,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF1E293B)
                      : const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isDark
                        ? const Color(0xFF334155)
                        : const Color(0xFFE2E8F0),
                  ),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          widget.product.imageUrl,
                          width: 130,
                          height: 145,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.fastfood,
                                  size: 64, color: Color(0xFFD97706)),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: activeOption['badgeColor'] as Color,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: (activeOption['badgeColor'] as Color)
                                  .withValues(alpha: 0.35),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Text(
                          '${activeOption['badge']} (${activeOption['matchScore']}%)',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // Dynamic 3D Layer Stack
              LayerStackWidget(layers: layers),

              const SizedBox(height: 14),

              // Key Specifications Section
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
                    Text(
                      '${activeOption['title']} Specifications',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color:
                            isDark ? Colors.white : const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildSpecRow('OTR (Oxygen Transmission)', activeOption['otr'] as String, isDark),
                    _buildSpecRow('WVTR (Water Vapor Transmission)', activeOption['wvtr'] as String, isDark),
                    _buildSpecRow('Film Thickness', activeOption['thickness'] as String, isDark),
                    _buildSpecRow('Sealability Rating', activeOption['sealability'] as String, isDark),
                    _buildSpecRow('Mechanical Strength', activeOption['mechanical'] as String, isDark),
                    _buildSpecRow('Predicted Shelf Life', activeOption['shelfLife'] as String, isDark, isLast: true),
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

  Widget _buildSpecRow(String label, String value, bool isDark,
      {bool isLast = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isDark
                    ? const Color(0xFF94A3B8)
                    : const Color(0xFF64748B),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white : const Color(0xFF0F172A),
            ),
          ),
        ],
      ),
    );
  }
}
