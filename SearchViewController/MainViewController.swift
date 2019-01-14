import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let restaurants = [
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
    let searchController = UISearchController(searchResultsController: nil)

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
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailSegue" {
            if let destination = segue.destination as? DetailViewController {
                if let index = sender as? IndexPath {
                    destination.restaurant = restaurants[index.row]
                }
            }
        }
    }
    
    
}

extension MainViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = restaurants[indexPath.row].name
        cell.detailTextLabel?.text = restaurants[indexPath.row].type.rawValue
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "DetailSegue", sender: indexPath)
    }
    
    
}



