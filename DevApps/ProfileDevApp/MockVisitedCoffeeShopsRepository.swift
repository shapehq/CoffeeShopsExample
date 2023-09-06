import AnyAsync
import Observation
import ProfileFeatureDomain

@Observable
final class MockVisitedCoffeeShopsRepository: VisitedCoffeeShopsRepository {
    private(set) var visitedCoffeeShops: [MockVisitedCoffeeShop] = [
        MockVisitedCoffeeShop(
            title: "Prufrock Coffee",
            latitude: 51.52004066260156,
            longitude: -0.10943098689930579,
            rating: .five,
            note: "Excellent coffee. Common place to work from."
        ),
        MockVisitedCoffeeShop(
            title: "Rapha London",
            latitude: 51.51092038993181,
            longitude: -0.13664944343263805,
            rating: .two,
            note: "Great for cycling enthusiasts!"
        ),
        MockVisitedCoffeeShop(
            title: "Black Sheep Coffee",
            latitude: 51.49314528412428,
            longitude: -0.1489984399878538,
            rating: .three,
            note: nil
        ),
        MockVisitedCoffeeShop(
            title: "Back in Black",
            latitude: 48.85726817723269,
            longitude: 2.368860624963221,
            rating: .four,
            note: nil
        )
    ]

    func deleteVisitedCoffeeShop(_ coffeeShop: MockVisitedCoffeeShop) {
        visitedCoffeeShops.removeAll { $0 == coffeeShop }
    }
}
