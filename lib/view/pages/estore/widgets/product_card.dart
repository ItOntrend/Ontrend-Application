import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
  });

  final Map<String, dynamic> product;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.network(
                product['imageUrl'],
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product['name'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product['price'],
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.green[800],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      child: Row(
                        children: [
                          Icon(Icons.star, color: Colors.white, size: 14),
                          SizedBox(width: 2),
                          Text(
                            "${product['rating']}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.orange,
                //primary: Colors.white,
                minimumSize: Size(double.infinity, 36),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
              ),
              onPressed: () {
                // Add to cart logic
                print('Add to cart');
              },
              child: Text('Add'),
            ),
          ),
        ],
      ),
    );
  }
}
