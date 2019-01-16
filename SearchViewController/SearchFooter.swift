import UIKit

class SearchFooter: UIView {
    
    let label = UILabel()
    
    // using init because there is no viewDidLoad
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }
    
    override func draw(_ rect: CGRect) {
        label.frame = bounds
    }
    
    private func configureView() {
        
        backgroundColor = .gray
        alpha = 0
        
        label.textAlignment = .center
        label.textColor = .white
        
        addSubview(label)
    }
    
    private func hideFooter() {
        alpha = 0
    }
    
    private func showFooter() {
        alpha = 1
    }

}

// MARK: - Public API
extension SearchFooter {
    
    func setNotFiltering() {
        
        label.text = ""
        hideFooter()
    }
    
    func setIsFilteringToShow(filteredItemCount: Int, of totalItemCount: Int) {
        
        switch filteredItemCount {
        case totalItemCount: setNotFiltering()
        case 0: label.text = "No Items match your query"
        default: label.text = "Filtering \(filteredItemCount) from \(totalItemCount)"
        }
        showFooter()
    }
}
