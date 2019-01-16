import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var filteredRestaurants = [Restaurant]()
    
    private let restaurants = [
        Restaurant(name: "Red Stallion", type: .restaurant),
        Restaurant(name: "Karp's Davisville Pub", type: .bar),
        Restaurant(name: "Oven Brothers", type: .restaurant),
        Restaurant(name: "Burger King", type: .fastfood),
        Restaurant(name: "Dunkin' Donuts", type: .fastfood),
        Restaurant(name: "Reese's Tavern", type: .restaurant),
        Restaurant(name: "E's Irish Pub", type: .bar),
        Restaurant(name: "Kenney's Madison Tavern", type: .restaurant),
        Restaurant(name: "Five Guys", type: .fastfood),
        Restaurant(name: "Mission BBQ", type: .restaurant),
        Restaurant(name: "Roman Delight", type: .restaurant),
        Restaurant(name: "Harrigan's Pub", type: .bar),
        Restaurant(name: "China Work", type: .restaurant),
        Restaurant(name: "Blue Eye Hookah Bar", type: .bar),
        Restaurant(name: "Tako Bell", type: .fastfood)
    ]
    
    // the results will be displayed in main vc, additional vc is not required
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false}
        return text.isEmpty
    }
    
    private var isFiltering: Bool {
        
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        
        return searchController.isActive && (!searchBarIsEmpty || searchBarScopeIsFiltering)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false // allows to interract with the search results
        searchController.searchBar.placeholder = "Search here..."
        navigationItem.searchController = searchController // creates search bar in navigation bar
        definesPresentationContext = true // ? let vc go in case of transition to another vc
        
        // setup the Scope Bar
        searchController.searchBar.scopeButtonTitles = ["All", "Restaurant", "Fast Food", "Bar"]
        searchController.searchBar.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailSegue" {
            if let destination = segue.destination as? DetailViewController {
                if let index = sender as? IndexPath {
                    if isFiltering {
                        destination.restaurant = filteredRestaurants[index.row]
                    } else {
                        destination.restaurant = restaurants[index.row]
                    }
                }
            }
        }
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}

extension MainViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
    
    private func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredRestaurants = restaurants.filter({ (restaurant: Restaurant) -> Bool in
            
             // answering - do we have scope defined?
            let doesTypeMatch = (scope == "All") || (restaurant.type.rawValue == scope)
            
            if searchBarIsEmpty {
                return doesTypeMatch // ?? what does this do?
            }
    
            return doesTypeMatch && restaurant.name.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredRestaurants.count
        } else {
            return restaurants.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        var restaurant: Restaurant
        if isFiltering {
            restaurant = filteredRestaurants[indexPath.row]
        } else {
            restaurant = restaurants[indexPath.row]
        }
        cell.textLabel?.text = restaurant.name
        cell.detailTextLabel?.text = restaurant.type.rawValue
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "DetailSegue", sender: indexPath)
    }
}



