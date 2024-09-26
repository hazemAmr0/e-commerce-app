import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/consts/seccess_alertdialog.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/providers/cart_provider.dart';
import 'package:e_commerce_app/providers/favorite_provider.dart';
import 'package:e_commerce_app/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shimmer/shimmer.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({Key? key, this.productId}) : super(key: key);
  final String? productId;

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool _showAllComments = false;
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    final getCurrProduct = productProvider.productsById(widget.productId!);
    final favoriteProvider = Provider.of<FavoriteProvider>(context);

    return Scaffold(
      body: getCurrProduct == null
          ? const SizedBox.shrink()
          : Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildProductImage(getCurrProduct),
                      const SizedBox(height: 16.0),
                      _buildProductTitle(getCurrProduct),
                      const SizedBox(height: 8.0),
                      _buildPriceAndFavoriteButton(
                          getCurrProduct, favoriteProvider),
                      const SizedBox(height: 16.0),
                      _buildProductCategory(getCurrProduct),
                      const SizedBox(height: 8.0),
                      _buildProductDescription(getCurrProduct),
                      const SizedBox(height: 25.0),
                      const Divider(),
                      _buildCommentsSection(productProvider, getCurrProduct),
                      const SizedBox(height: 16.0),
                      _buildAddCommentField(productProvider),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildProductImage(ProductModel product) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40.0),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Hero(
            tag: product.productId!,
            child: CachedNetworkImage(
              imageUrl: product.productImage!,
              placeholder: (context, url) => Container(
                height: 400,
                width: double.infinity,
                color: Colors.grey,
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductTitle(ProductModel product) {
    return Text(
      product.productTitle!,
      style: const TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildPriceAndFavoriteButton(
    ProductModel product, FavoriteProvider favoriteProvider) {
  final cartProvider = Provider.of<CartProvider>(context, listen: false);

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        '${product.productPrice!} EGP',
        style: const TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: Colors.red,
        ),
      ),
      Row(
        children: [
          // Add to Cart Button
          IconButton(
            onPressed: () {
             if (cartProvider.isProductInCart(
                              productId: product.productId!)) {
                            cartProvider.removeFromCartFirebase(
                              cartId: cartProvider
                                  .getCart[product.productId]!.cartId,
                              quantity: cartProvider
                                  .getCart[product.productId]!.quantity
                                  .toString(),
                              productId: product.productId!,
                            );
                            showSuccessDialog(
                                context, 'Product removed from cart');
                          } else {
                            cartProvider.addToCartFirebase(
                              context: context,
                              productId: product.productId!,
                              quantity: '1',
                            );
                            showSuccessDialog(context, 'Product added to cart');
                          }

            },
            icon: cartProvider.isProductInCart(
                                productId: product.productId!)
                            ? const Icon(IconlyBold.bag2,
                                color: Colors.green)
                            : const Icon(Icons.add_shopping_cart,
                                color: Colors.blue),

            color: Colors.blue,
          ),
          // Favorite Button
          IconButton(
            onPressed: () {
              if (favoriteProvider.isProductFavorite(productId: product.productId!)) {
                favoriteProvider.removeFromFavoriteFirebase(
                  favoriteId: favoriteProvider.getFavorites[product.productId]!.favoriteId,
                  productId: product.productId!,
                );
              } else {
                favoriteProvider.addToFavoriteFirebase(
                  context: context,
                  productId: product.productId!,
                );
              }
            },
            icon: favoriteProvider.isProductFavorite(productId: product.productId!)
                ? const Icon(IconlyBold.heart, color: Colors.red)
                : const Icon(IconlyLight.heart),
          ),
        ],
      ),
    ],  
  );
    }

  Widget _buildProductCategory(ProductModel product) {
    return Text(
      product.productCategory!,
      style: const TextStyle(
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildProductDescription(ProductModel product) {
    return Text(
      product.productDescription!,
      style: const TextStyle(fontSize: 16.0),
    );
  }

  Widget _buildCommentsSection(
      ProductProvider productProvider, ProductModel product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Comments',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8.0),
        StreamBuilder<QuerySnapshot>(
          stream: productProvider.getComments(widget.productId!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return _buildShimmerLoading();
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text('No comments yet'));
            }

            final comments = snapshot.data!.docs;
            final limitedComments =
                _showAllComments ? comments : comments.take(3).toList();

            return Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: limitedComments.length,
                  itemBuilder: (context, index) {
                    final comment = limitedComments[index];
                    final userId = comment['userId'];
                    final timestamp = comment['timestamp'] as Timestamp;

                    return _buildComment(
                        productProvider, userId, comment, timestamp);
                  },
                ),
                if (comments.length > 3)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _showAllComments = !_showAllComments;
                      });
                    },
                    child: Text(_showAllComments
                        ? 'Show less'
                        : 'See all comments (${comments.length - 3})'),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildComment(ProductProvider productProvider, String userId,
      DocumentSnapshot comment, Timestamp timestamp) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: productProvider.getUserDetails(userId),
      builder: (context, userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.waiting) {
          return _buildShimmerLoading();
        }

        if (!userSnapshot.hasData) {
          return const ListTile(
            leading: Icon(Icons.error),
            title: Text('Error loading user details'),
          );
        }

        final user = userSnapshot.data!;
        final userName = user['username'] ?? 'Unknown User';
        final userComment = comment['commentText'];
        final userImage = user['image'] ?? '';
        timestamp.toDate().toString();
       

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20.0,
                backgroundImage: NetworkImage(userImage),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(userName),
                    const SizedBox(height: 4.0),
                    Text(
                      userComment,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[500],
                      ),
                      softWrap: true,
                    ),
                  ],
                ),
              ),
             
            ],
          ),
        );
      },
    );
  }

  Widget _buildShimmerLoading() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3, // Number of shimmer placeholders
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: CircleAvatar(
                  radius: 20.0,
                  backgroundColor: Colors.grey,
                ),
              ),
              const SizedBox(width: 8.0),
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 100,
                      height: 10,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Container(
                      width: 200,
                      height: 10,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAddCommentField(ProductProvider productProvider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Icon(Icons.comment),
        SizedBox(
          height: 60,
          width: MediaQuery.of(context).size.width * 0.8,
          child: TextField(
            controller: _commentController,
            decoration: InputDecoration(
              suffix: IconButton(
                onPressed: () async {
                  if (_commentController.text.isNotEmpty) {
                    await productProvider.addComment(
                        widget.productId!, _commentController.text);
                    _commentController.clear();
                  } else {
                    print('Comment text is empty');
                  }
                },
                icon: const Icon(
                  Icons.send,
                  color: Colors.blue,
                ),
              ),
              labelText: 'Add a comment',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: Colors.grey),
              ),
            ),
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}
