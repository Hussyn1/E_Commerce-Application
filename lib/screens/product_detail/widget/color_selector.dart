import 'package:ecommerce_fyp/config/theme/app_color.dart';
import 'package:flutter/material.dart';

class ColorSelector extends StatelessWidget {
  final List<Map<String, String>> colors;
  final String selectedColor;
  final Function(String) onColorSelected;

  const ColorSelector({
    Key? key,
    required this.colors,
    required this.selectedColor,
    required this.onColorSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Color',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: colors.map((colorData) {
            final colorName = colorData['name']!;
            final colorHex = colorData['hex']!;
            final isSelected = selectedColor == colorName;
            
            return GestureDetector(
              onTap: () => onColorSelected(colorName),
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? AppColors.primary : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Color(int.parse(colorHex)),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.border.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: isSelected
                      ? Icon(
                          Icons.check,
                          color: colorName == 'White' || colorName == 'Gray'
                              ? AppColors.primary
                              : Colors.white,
                          size: 20,
                        )
                      : null,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
