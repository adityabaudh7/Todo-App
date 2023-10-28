import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SimmerScreen extends StatelessWidget {
  const SimmerScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    height: 120,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                              );
  }
}
