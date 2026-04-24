import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/swipe_provider.dart';
import '../../../../shared_widgets/glass_container.dart';
import '../../../../theme.dart';

class DiscoveryFilterBottomSheet extends ConsumerStatefulWidget {
  const DiscoveryFilterBottomSheet({super.key});

  @override
  ConsumerState<DiscoveryFilterBottomSheet> createState() => _DiscoveryFilterBottomSheetState();
}

class _DiscoveryFilterBottomSheetState extends ConsumerState<DiscoveryFilterBottomSheet> {
  late double _minAge;
  late double _maxAge;
  late double _maxDistance;
  late bool _useInterests;
  final List<String> _cities = [
    'Toàn quốc',
  ];

  final TextEditingController _minAgeController = TextEditingController();
  final TextEditingController _maxAgeController = TextEditingController();
  final TextEditingController _maxDistanceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final currentFilter = ref.read(swipeProvider).filter;
    _minAge = currentFilter.minAge;
    _maxAge = currentFilter.maxAge;
    _maxDistance = currentFilter.maxDistance;
    _useInterests = currentFilter.useInterests;
    
    _minAgeController.text = _minAge.toInt().toString();
    _maxAgeController.text = _maxAge.toInt().toString();
    _maxDistanceController.text = _maxDistance.toInt().toString();
  }
  
  @override
  void dispose() {
    _minAgeController.dispose();
    _maxAgeController.dispose();
    _maxDistanceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.95),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Bộ lọc tìm kiếm', style: AppTextStyles.titleLarge),
              TextButton(
                onPressed: () {
                  setState(() {
                    _minAge = 18;
                    _maxAge = 100;
                    _maxDistance = 20000;
                    _useInterests = false;
                    _minAgeController.text = '18';
                    _maxAgeController.text = '100';
                    _maxDistanceController.text = '20000';
                  });
                },
                child: const Text('Đặt lại'),
              ),
            ],
          ),
          const SizedBox(height: 30),
          

          
          // Age Range
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Khoảng tuổi:', style: AppTextStyles.titleLarge),
              Row(
                children: [
                  SizedBox(
                    width: 60,
                    child: TextField(
                      controller: _minAgeController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      onChanged: (val) {
                        double? parsed = double.tryParse(val);
                        if (parsed != null && parsed >= 18 && parsed <= _maxAge) {
                          setState(() => _minAge = parsed);
                        }
                      },
                    ),
                  ),
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Text('-')),
                  SizedBox(
                    width: 60,
                    child: TextField(
                      controller: _maxAgeController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      onChanged: (val) {
                        double? parsed = double.tryParse(val);
                        if (parsed != null && parsed >= _minAge && parsed <= 100) {
                          setState(() => _maxAge = parsed);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          RangeSlider(
            values: RangeValues(_minAge, _maxAge),
            min: 18,
            max: 100,
            divisions: 82,
            activeColor: AppColors.primary,
            onChanged: (values) {
              setState(() {
                _minAge = values.start;
                _maxAge = values.end;
                _minAgeController.text = _minAge.toInt().toString();
                _maxAgeController.text = _maxAge.toInt().toString();
              });
            },
          ),
          
          const SizedBox(height: 24),
          
          // Distance
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Khoảng cách (km):', style: AppTextStyles.titleLarge),
              SizedBox(
                width: 80,
                child: TextField(
                  controller: _maxDistanceController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onChanged: (val) {
                    double? parsed = double.tryParse(val);
                    if (parsed != null && parsed >= 1 && parsed <= 20000) {
                      setState(() => _maxDistance = parsed);
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Slider(
            value: _maxDistance,
            min: 1,
            max: 20000,
            divisions: 200,
            activeColor: AppColors.primary,
            onChanged: (value) {
              setState(() {
                _maxDistance = value;
                _maxDistanceController.text = _maxDistance.toInt().toString();
              });
            },
          ),
          
          const SizedBox(height: 24),
          
          // Interests Toggle
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Ưu tiên sở thích chung', style: AppTextStyles.titleLarge),
                  Text('Chỉ hiển thị người có cùng sở thích', style: AppTextStyles.bodyMedium),
                ],
              ),
              Switch(
                value: _useInterests,
                activeColor: AppColors.primary,
                onChanged: (value) {
                  setState(() {
                    _useInterests = value;
                  });
                },
              ),
            ],
          ),
          
          const SizedBox(height: 40),
          
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
              onPressed: () {
                final newFilter = DiscoveryFilter(
                  minAge: _minAge,
                  maxAge: _maxAge,
                  maxDistance: _maxDistance,
                  useInterests: _useInterests,
                );
                ref.read(swipeProvider.notifier).updateFilters(newFilter);
                Navigator.pop(context);
              },
              child: const Text('ÁP DỤNG', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
