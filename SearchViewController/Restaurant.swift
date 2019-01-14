import Foundation

struct Restaurant {
    let name: String
    let type: RestaurantType
}

enum RestaurantType: String {
    case restaurant = "Restaurant"
    case fastfood = "Fast Food"
    case bar = "Bar"
}
