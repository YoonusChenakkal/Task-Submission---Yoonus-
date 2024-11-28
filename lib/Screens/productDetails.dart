import 'package:flutter/material.dart';
import 'package:task1/Models/product.dart';
import 'package:sizer/sizer.dart';

class ProductDetailsPage extends StatelessWidget {
  final Products product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Product Details',
        style: TextStyle(fontSize: 18.sp),
      )),
      body: Padding(
        padding: EdgeInsets.all(3.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              product.partImage,
              height: 30.h,
              width: 100.w,
              fit: BoxFit.fitHeight,
            ),
            SizedBox(height: 2.h),

            Text(
              product.partsName ?? 'No Name',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 1.h),

            Text(
              'Price: ₹${product.price}',
              style: TextStyle(fontSize: 14.sp, color: Colors.green),
            ),
            SizedBox(height: 1.h),

            // Product Description
            Text(
              'Description: ${product.description}',
              style: TextStyle(fontSize: 12.sp),
            ),
            SizedBox(height: 2.h),

            if (product.isOffer && product.offerPrice != null)
              Text(
                'Offer Price: ₹${product.offerPrice}',
                style: TextStyle(fontSize: 14.sp, color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
