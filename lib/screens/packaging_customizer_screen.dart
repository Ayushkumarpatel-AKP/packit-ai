import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/package_3d_viewer.dart';

class PackagingCustomizerScreen extends StatefulWidget {
  final VoidCallback onBack;
  final VoidCallback onGenerated;

  const PackagingCustomizerScreen({
    super.key,
    required this.onBack,
    required this.onGenerated,
  });

  @override
  State<PackagingCustomizerScreen> createState() =>
      _PackagingCustomizerScreenState();
}

class _PackagingCustomizerScreenState extends State<PackagingCustomizerScreen> {
  int _selectedTab = 0; // 0: Material, 1: Thickness, 2: Design, 3: Size
  String _selectedMaterial = 'metallized'; // 'standard', 'metallized', 'bio'
  double _filmThickness = 99.0;
  double _packSizeGrams = 50.0;
  final String _productName = 'Potato Chips';

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
          'Customize Your Packaging',
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () {
              setState(() {
                _selectedMaterial = 'metallized';
                _filmThickness = 99.0;
                _packSizeGrams = 50.0;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('🔄 Reset to optimal AI recommended values'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
          ),
        ],
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
                SnackBar(
                  content: Text(
                      '🎉 Custom packaging configured: ${_selectedMaterial.toUpperCase()} | ${_filmThickness.toInt()}µm | ${_packSizeGrams.toInt()}g'),
                  backgroundColor: const Color(0xFF10B981),
                ),
              );
              widget.onGenerated();
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
                  'Generate Custom Packaging',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 8),
                Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 18),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Category Tabs: [Material] [Thickness] [Design] [Size]
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: isDark
                        ? const Color(0xFF1E293B)
                        : const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      _buildTopTab(0, 'Material'),
                      _buildTopTab(1, 'Thickness'),
                      _buildTopTab(2, 'Design'),
                      _buildTopTab(3, 'Size'),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // Interactive 3D Mockup Canvas
              Package3DViewer(
                productName: _productName,
                materialType: _selectedMaterial,
                filmThickness: _filmThickness,
                packSizeGrams: _packSizeGrams,
              ),

              const SizedBox(height: 18),

              // Choose Packaging Material Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Choose Packaging Material',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: isDark ? Colors.white : const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // 3 Material Selector Cards
                    Row(
                      children: [
                        _buildMaterialOption(
                          id: 'standard',
                          title: 'PET + LDPE\n(Standard)',
                          icon: Icons.layers_clear_outlined,
                          accentColor: const Color(0xFF3B82F6),
                          isDark: isDark,
                        ),
                        const SizedBox(width: 10),
                        _buildMaterialOption(
                          id: 'metallized',
                          title: 'Metallized Film\n(High Barrier)',
                          icon: Icons.auto_awesome_rounded,
                          accentColor: const Color(0xFFF59E0B),
                          isDark: isDark,
                        ),
                        const SizedBox(width: 10),
                        _buildMaterialOption(
                          id: 'bio',
                          title: 'Biodegradable\n(Eco-Friendly)',
                          icon: Icons.eco_rounded,
                          accentColor: const Color(0xFF10B981),
                          isDark: isDark,
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Film Thickness Slider
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Film Thickness (µm)',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: isDark
                                ? Colors.white
                                : const Color(0xFF1E293B),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xFF1E293B)
                                : const Color(0xFFEEF2FF),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: const Color(0xFF818CF8)
                                    .withValues(alpha: 0.5)),
                          ),
                          child: Text(
                            '${_filmThickness.toInt()} µm',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF4F46E5),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: const Color(0xFF4F46E5),
                        inactiveTrackColor: isDark
                            ? const Color(0xFF334155)
                            : const Color(0xFFE2E8F0),
                        thumbColor: const Color(0xFF4F46E5),
                        overlayColor:
                            const Color(0xFF4F46E5).withValues(alpha: 0.2),
                      ),
                      child: Slider(
                        value: _filmThickness,
                        min: 30,
                        max: 150,
                        divisions: 24,
                        onChanged: (val) => setState(() => _filmThickness = val),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Pack Size Slider
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Pack Size (g)',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: isDark
                                ? Colors.white
                                : const Color(0xFF1E293B),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xFF1E293B)
                                : const Color(0xFFEEF2FF),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: const Color(0xFF818CF8)
                                    .withValues(alpha: 0.5)),
                          ),
                          child: Text(
                            '${_packSizeGrams.toInt()} g',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF4F46E5),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: const Color(0xFF4F46E5),
                        inactiveTrackColor: isDark
                            ? const Color(0xFF334155)
                            : const Color(0xFFE2E8F0),
                        thumbColor: const Color(0xFF4F46E5),
                        overlayColor:
                            const Color(0xFF4F46E5).withValues(alpha: 0.2),
                      ),
                      child: Slider(
                        value: _packSizeGrams,
                        min: 20,
                        max: 250,
                        divisions: 23,
                        onChanged: (val) => setState(() => _packSizeGrams = val),
                      ),
                    ),

                    const SizedBox(height: 14),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopTab(int index, String title) {
    final isSelected = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF4F46E5) : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
              color: isSelected ? Colors.white : const Color(0xFF64748B),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMaterialOption({
    required String id,
    required String title,
    required IconData icon,
    required Color accentColor,
    required bool isDark,
  }) {
    final isSelected = _selectedMaterial == id;

    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _selectedMaterial = id),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: 105,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFFEEF2FF)
                : (isDark ? const Color(0xFF1E293B) : Colors.white),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected
                  ? const Color(0xFF4F46E5)
                  : (isDark
                      ? const Color(0xFF334155)
                      : const Color(0xFFE2E8F0)),
              width: isSelected ? 2 : 1,
            ),
            boxShadow: [
              if (isSelected)
                BoxShadow(
                  color: const Color(0xFF4F46E5).withValues(alpha: 0.15),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: accentColor, size: 24),
              const SizedBox(height: 6),
              Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 10.5,
                  fontWeight:
                      isSelected ? FontWeight.w800 : FontWeight.w600,
                  color: isSelected
                      ? const Color(0xFF4F46E5)
                      : (isDark ? Colors.white : const Color(0xFF1E293B)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
