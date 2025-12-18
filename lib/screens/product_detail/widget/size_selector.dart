import 'package:ecommerce_fyp/config/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SizeSelector extends StatelessWidget {
  final List<String> sizes;
  final String selectedSize;
  final Function(String) onSizeSelected;

  const SizeSelector({
    Key? key,
    required this.sizes,
    required this.selectedSize,
    required this.onSizeSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Size',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            TextButton(
              onPressed: () {
                // Show size guide dialog
                Get.dialog(
                  Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Size Guide',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () => Get.back(),
                              ),
                            ],
                          ),
                          const Divider(),
                          const SizedBox(height: 10),
                          Table(
                            border: TableBorder.all(
                              color: AppColors.border,
                              width: 1,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            children: const [
                              TableRow(
                                decoration: BoxDecoration(color: AppColors.cardBackground),
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Size', style: TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Chest (in)', style: TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Waist (in)', style: TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                              TableRow(children: [
                                Padding(padding: EdgeInsets.all(8.0), child: Text('S')),
                                Padding(padding: EdgeInsets.all(8.0), child: Text('36-38')),
                                Padding(padding: EdgeInsets.all(8.0), child: Text('30-32')),
                              ]),
                              TableRow(children: [
                                Padding(padding: EdgeInsets.all(8.0), child: Text('M')),
                                Padding(padding: EdgeInsets.all(8.0), child: Text('38-40')),
                                Padding(padding: EdgeInsets.all(8.0), child: Text('32-34')),
                              ]),
                              TableRow(children: [
                                Padding(padding: EdgeInsets.all(8.0), child: Text('L')),
                                Padding(padding: EdgeInsets.all(8.0), child: Text('40-42')),
                                Padding(padding: EdgeInsets.all(8.0), child: Text('34-36')),
                              ]),
                              TableRow(children: [
                                Padding(padding: EdgeInsets.all(8.0), child: Text('XL')),
                                Padding(padding: EdgeInsets.all(8.0), child: Text('42-44')),
                                Padding(padding: EdgeInsets.all(8.0), child: Text('36-38')),
                              ]),
                            ],
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            '* All measurements are in inches.',
                            style: TextStyle(
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              child: const Text(
                'Size Guide',
                style: TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: sizes.map((size) {
            final isSelected = selectedSize == size;
            return GestureDetector(
              onTap: () => onSizeSelected(size),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected ? AppColors.primary : AppColors.border,
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Center(
                  child: Text(
                    size,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
