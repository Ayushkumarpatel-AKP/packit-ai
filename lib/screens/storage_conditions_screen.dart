import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/food_item.dart';

class StorageConditionsScreen extends StatefulWidget {
  final Map<String, dynamic> productData;
  final VoidCallback onBack;
  final Function(Map<String, dynamic> completeData) onGetRecommendation;

  const StorageConditionsScreen({
    super.key,
    required this.productData,
    required this.onBack,
    required this.onGetRecommendation,
  });

  @override
  State<StorageConditionsScreen> createState() =>
      _StorageConditionsScreenState();
}

class _StorageConditionsScreenState extends State<StorageConditionsScreen> {
  int _desiredShelfLife = 6;
  String _shelfLifeUnit = 'Months';
  double _storageTemp = 25.0;
  String _tempUnit = '°C';
  double _relativeHumidity = 60.0;
  StorageType _selectedStorageType = StorageType.ambient;
  TransportCondition _selectedTransport = TransportCondition.normal;
  final TextEditingController _specialReqController =
      TextEditingController(text: 'Eco-friendly, export quality');

  @override
  void dispose() {
    _specialReqController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final productName = widget.productData['name'] ?? 'Potato Chips';

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: widget.onBack,
        ),
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFEEF2FF),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.cookie_outlined,
                  size: 16, color: Color(0xFF4F46E5)),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  'Product: $productName',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF4F46E5),
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
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
              flex: 2,
              child: OutlinedButton(
                onPressed: widget.onBack,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  side: BorderSide(
                    color: isDark
                        ? const Color(0xFF475569)
                        : const Color(0xFFCBD5E1),
                  ),
                ),
                child: const Text(
                  'Back',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 4,
              child: Container(
                height: 50,
                decoration: AppTheme.gradientButtonDecoration(),
                child: ElevatedButton(
                  onPressed: () {
                    widget.onGetRecommendation({
                      ...widget.productData,
                      'desiredShelfLife': _desiredShelfLife,
                      'shelfLifeUnit': _shelfLifeUnit,
                      'storageTemp': _storageTemp,
                      'tempUnit': _tempUnit,
                      'humidity': _relativeHumidity,
                      'storageType': _selectedStorageType,
                      'transportCondition': _selectedTransport,
                      'specialRequirement': _specialReqController.text,
                    });
                  },
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
                        'Get Recommendation',
                        style: TextStyle(
                          fontSize: 13.5,
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
              // Shelf Life Selector (Compact & Zero Overflow)
              _buildCompactParameterCard(
                title: 'Desired Shelf Life',
                icon: Icons.calendar_month_rounded,
                accentColor: const Color(0xFF4F46E5),
                isDark: isDark,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildStepperBtn(
                      icon: Icons.remove,
                      onTap: () {
                        if (_desiredShelfLife > 1) {
                          setState(() => _desiredShelfLife--);
                        }
                      },
                      isDark: isDark,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        '$_desiredShelfLife',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF4F46E5),
                        ),
                      ),
                    ),
                    _buildStepperBtn(
                      icon: Icons.add,
                      onTap: () => setState(() => _desiredShelfLife++),
                      isDark: isDark,
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF0F172A) : const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButton<String>(
                        value: _shelfLifeUnit,
                        underline: const SizedBox(),
                        isDense: true,
                        items: ['Days', 'Months', 'Years'].map((u) {
                          return DropdownMenuItem(
                            value: u,
                            child: Text(u, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                          );
                        }).toList(),
                        onChanged: (v) => setState(() => _shelfLifeUnit = v!),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Storage Temperature
              _buildCompactParameterCard(
                title: 'Storage Temperature',
                icon: Icons.thermostat_rounded,
                accentColor: const Color(0xFFF59E0B),
                isDark: isDark,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildStepperBtn(
                      icon: Icons.remove,
                      onTap: () => setState(() => _storageTemp = (_storageTemp - 1).clamp(-20, 60)),
                      isDark: isDark,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        '${_storageTemp.toInt()}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFFF59E0B),
                        ),
                      ),
                    ),
                    _buildStepperBtn(
                      icon: Icons.add,
                      onTap: () => setState(() => _storageTemp = (_storageTemp + 1).clamp(-20, 60)),
                      isDark: isDark,
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF0F172A) : const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButton<String>(
                        value: _tempUnit,
                        underline: const SizedBox(),
                        isDense: true,
                        items: ['°C', '°F'].map((u) {
                          return DropdownMenuItem(
                            value: u,
                            child: Text(u, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                          );
                        }).toList(),
                        onChanged: (v) => setState(() => _tempUnit = v!),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Relative Humidity
              _buildCompactParameterCard(
                title: 'Relative Humidity',
                icon: Icons.water_drop_rounded,
                accentColor: const Color(0xFF06B6D4),
                isDark: isDark,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildStepperBtn(
                      icon: Icons.remove,
                      onTap: () => setState(() => _relativeHumidity = (_relativeHumidity - 5).clamp(10, 100)),
                      isDark: isDark,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        '${_relativeHumidity.toInt()}%',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF06B6D4),
                        ),
                      ),
                    ),
                    _buildStepperBtn(
                      icon: Icons.add,
                      onTap: () => setState(() => _relativeHumidity = (_relativeHumidity + 5).clamp(10, 100)),
                      isDark: isDark,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // Storage Type Segmented Selectors
              Text(
                'Storage Type',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: isDark ? Colors.white : const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _buildSegmentCard(
                    title: 'Ambient',
                    icon: Icons.wb_sunny_outlined,
                    isSelected: _selectedStorageType == StorageType.ambient,
                    onTap: () => setState(
                        () => _selectedStorageType = StorageType.ambient),
                  ),
                  const SizedBox(width: 8),
                  _buildSegmentCard(
                    title: 'Chilled',
                    icon: Icons.ac_unit_outlined,
                    isSelected: _selectedStorageType == StorageType.chilled,
                    onTap: () => setState(
                        () => _selectedStorageType = StorageType.chilled),
                  ),
                  const SizedBox(width: 8),
                  _buildSegmentCard(
                    title: 'Frozen',
                    icon: Icons.severe_cold_outlined,
                    isSelected: _selectedStorageType == StorageType.frozen,
                    onTap: () => setState(
                        () => _selectedStorageType = StorageType.frozen),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              // Transportation Conditions
              Text(
                'Transportation Conditions',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: isDark ? Colors.white : const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: TransportCondition.values.map((cond) {
                  final isSelected = _selectedTransport == cond;
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      child: InkWell(
                        onTap: () => setState(() => _selectedTransport = cond),
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF4F46E5)
                                : (isDark
                                    ? const Color(0xFF1E293B)
                                    : Colors.white),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFF4F46E5)
                                  : (isDark
                                      ? const Color(0xFF334155)
                                      : const Color(0xFFE2E8F0)),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                cond.icon,
                                size: 18,
                                color: isSelected
                                    ? Colors.white
                                    : const Color(0xFF64748B),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                cond.label,
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 9.5,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.w600,
                                  color: isSelected
                                      ? Colors.white
                                      : (isDark
                                          ? Colors.white70
                                          : const Color(0xFF334155)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 18),

              // Special Requirements Field
              Text(
                'Any Special Requirement? (Optional)',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: isDark ? Colors.white : const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: _specialReqController,
                decoration: const InputDecoration(
                  hintText: 'e.g. eco-friendly, low cost, export quality...',
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCompactParameterCard({
    required String title,
    required IconData icon,
    required Color accentColor,
    required Widget trailing,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: accentColor, size: 16),
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  color: isDark ? Colors.white : const Color(0xFF1E293B),
                ),
              ),
            ],
          ),
          trailing,
        ],
      ),
    );
  }

  Widget _buildStepperBtn({
    required IconData icon,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF0F172A) : const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: isDark ? const Color(0xFF334155) : const Color(0xFFCBD5E1)),
        ),
        child: Icon(icon, size: 14, color: isDark ? Colors.white : const Color(0xFF1E293B)),
      ),
    );
  }

  Widget _buildSegmentCard({
    required String title,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFF4F46E5)
                : (isDark ? const Color(0xFF1E293B) : Colors.white),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected
                  ? const Color(0xFF4F46E5)
                  : (isDark
                      ? const Color(0xFF334155)
                      : const Color(0xFFE2E8F0)),
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.white : const Color(0xFF64748B),
                size: 18,
              ),
              const SizedBox(height: 3),
              Text(
                title,
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight:
                      isSelected ? FontWeight.bold : FontWeight.w600,
                  color: isSelected
                      ? Colors.white
                      : (isDark ? Colors.white70 : const Color(0xFF334155)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
