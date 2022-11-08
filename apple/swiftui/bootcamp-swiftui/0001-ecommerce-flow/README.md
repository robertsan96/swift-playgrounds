#  0001 - Ecommerce Flow

## Description

Build an online shopping platform flow for iOS and macOS using SwiftUI.

## Tasks

 - [ ] Login into a User Account or create a new account
     - [ ] User Registration (social auth)
     - [ ] User Account View
         - [ ] My orders
             - [ ] Show an order history (searchable, filterable, sortable based on date)
         - [ ] Notification settings: marketing & delivery
     - [ ] Logout
 - [ ] Display a list of products from memory or mock api (with infinity scroll). Each product card must have:
     - [ ] Product image
     - [ ] Product price & discounts
     - [ ] Toggle favorites button
     - [ ] Variation labels (ex: Gold MacBook, Silver MacBook, Space Grey MacBook)
     - [ ] Toggle cart entry button
     - [ ] Product rating
     - [ ] Stock information (low stock if under 15, show number of products left if under 5, in stock for +15)
     - [ ] Delivery information (if product available in a local pickup location, should be available today. Otherwise, estimate)
 - [ ] Search, filter and sort products
     - [ ] Search products by keyword
     - [ ] Filtering options should show based on the current list (do not show filters if there could be shown zero products)
     - [ ] Sort products: most popular, price asc/desc, reviews asc/desc, discount asc, latest products
 - [ ] Store products as favorites (via UserDefaults)
 - [ ] Product Detail View
     - [ ] Show more photos / videos in a carousel
     - [ ] Ability to share the product
     - [ ] Show all details available on the product card
     - [ ] Show variations
     - [ ] Delivery estimation for local pickup point & last address added in user account
     - [ ] Add to cart
     - [ ] Toggle favorites button
     - [ ] Related products based on the product tags
     - [ ] Product Description (Markdown)
     - [ ] Product Specifications
     - [ ] Reviews
         - [ ] Show number of votes for each star
         - [ ] Product rating
         - [ ] Show customer reviews
         - [ ] Add a review
             - [ ] Add photos of the product
             - [ ] Review title, description, number of stars
     - [ ] Product questions
         - [ ] Ability to add a product question
         - [ ] Add answers for existing questions
 - [ ] Add a product to the cart
 - [ ] Make an order from the cart
     - [ ] Show products in cart
     - [ ] Address
         - [ ] Select a local pickup point from the map
             - [ ] If the product is available at the local pickup point, inform the user that the product can be picked up right now
         - [ ] Delivery by courier
             - [ ] Select an existing address on the user account
             - [ ] Add a new delivery address
     - [ ] User Account Creation if not logged in
     - [ ] Payment
         - [ ] Show product-price summary
         - [ ] Show a delivery summary
         - [ ] Integrate paypal and simulate a transaction
             - [ ] Succesfull & Failed transactions
         - [ ] Apple Pay
         - [ ] Pay on delivery
 - [ ] Notifications
     - [ ] User should be able to receive notifications regarding product delivery
     - [ ] Marketing Notifications
