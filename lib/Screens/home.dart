import 'package:flutter/material.dart';
import 'package:task1/Models/categories.dart';
import 'package:task1/Models/product.dart';
import 'package:task1/Screens/productDetails.dart';
import 'package:task1/Screens/profile.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Categories>> categories;
  late Future<List<Products>> products;

  @override
  void initState() {
    super.initState();
    categories = fetchCategories();
    products = fetchProducts();
  }

  // Fetch Products from API
  Future<List<Products>> fetchProducts() async {
    final response = await http.get(Uri.parse(
        'https://prethewram.pythonanywhere.com/api/parts_categories/'));
    if (response.statusCode == 200) {
      return productsFromJson(response.body);
    } else {
      throw Exception('Failed to load products');
    }
  }

  // Fetch Categories from API
  Future<List<Categories>> fetchCategories() async {
    final response = await http.get(
        Uri.parse('https://prethewram.pythonanywhere.com/api/Top_categories/'));
    if (response.statusCode == 200) {
      return categoriesFromJson(response.body);
    } else {
      throw Exception('Failed to load categories');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: 100.h,
          width: 100.w,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Icon and Navigation
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.all(3.w),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProfilePage(),
                            ),
                          ),
                          child: CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 9.w,
                            child: Icon(
                              Icons.person_2_outlined,
                              size: 27.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const Text(
                          'Profile',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  )
                ],
              ),

              // Categories Section
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Categories',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),

              // Fetch and Display Categories
              FutureBuilder<List<Categories>>(
                future: categories, // Use the Future from `initState`
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator(
                      color: Colors.white,
                    ));
                  } else if (snapshot.hasError) {
                    return Center(
                      child: ElevatedButton(
                        onPressed: () {
                          // Retry the operation by calling setState to reload the future
                          setState(() {
                            categories =
                                fetchCategories(); // Re-fetch the categories
                          });
                        },
                        style: ButtonStyle(
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          backgroundColor: WidgetStateProperty.all(
                              const Color.fromARGB(255, 105, 105, 105)),
                        ),
                        child: const Text(
                          'Retry',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No Categories Available'));
                  } else {
                    final categoryList = snapshot.data!;
                    return SizedBox(
                      height: 10.h, // Adjustable height for category list
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categoryList.length,
                        itemBuilder: (context, index) {
                          final category = categoryList[index];
                          return Card(
                            color: const Color.fromARGB(167, 255, 255, 255),
                            margin: EdgeInsets.symmetric(horizontal: 2.w),
                            child: Padding(
                              padding: EdgeInsets.all(2.w),
                              child: Column(
                                children: [
                                  Icon(Icons.category, size: 24.sp),
                                  SizedBox(height: 1.h),
                                  Text(category.catName,
                                      style: TextStyle(fontSize: 12.sp)),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),

              // Products Section
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Products',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),

              // Fetch and Display Products
              Expanded(
                child: FutureBuilder<List<Products>>(
                  future: products, // Use the Future from `initState`
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                        child: ElevatedButton(
                          onPressed: () {
                            // Retry the operation by calling setState to reload the future
                            setState(() {
                              products =
                                  fetchProducts(); // Re-fetch the products
                            });
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 139, 139, 139)),
                          ),
                          child: const Text(
                            'Retry',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No Products Available'));
                    } else {
                      final productList = snapshot.data!;
                      return ListView.builder(
                        itemCount: productList.length,
                        itemBuilder: (context, index) {
                          final product = productList[index];
                          return Card(
                            color: const Color.fromARGB(224, 253, 253, 253),
                            margin: EdgeInsets.symmetric(
                                vertical: 1.h, horizontal: 3.w),
                            child: ListTile(
                              leading: Image.network(
                                product.partImage,
                                width: 20.w,
                                fit: BoxFit.fitHeight,
                              ),
                              title: Text(product.partsName ?? 'No Name'),
                              subtitle: Text('\₹ ${product.price}'),
                              trailing: Icon(Icons.arrow_forward),
                              onTap: () {
                                // Navigate to ProductDetailsPage when tapped
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductDetailsPage(
                                      product: product,
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
