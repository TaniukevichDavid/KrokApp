

import UIKit
import Alamofire

class CitiesViewController: UIViewController {
    private let tableView = UITableView()
    private let url = "https://krokapp.by/api/get_cities/11/"
    private var cities: [Cities] = [] {
        didSet {
            DispatchQueue.main.async {
                    self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewAndNavBar()
        setUpTableVIew()
        getgetData(url: url)
    }
    
    private func setUpViewAndNavBar() {
        view.backgroundColor = .white
        self.navigationController?.navigationBar.prefersLargeTitles = true
        title = "Гарады"
    }
    
    private func setUpTableVIew() {
        view.addSubview(tableView)
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FirstCustomCell.self, forCellReuseIdentifier: "FirstCustomCell")
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func getgetData(url: String) {
        AF.request(url).responseJSON { responce in
            guard let result = responce.data else { return }
            do {
                self.cities = try JSONDecoder().decode([Cities].self, from: result)
                    .filter({$0.lang == 1 && $0.visible == true})
            } catch  {
                print(error.localizedDescription)
            }
        }
    }
    
}

extension CitiesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell  = tableView.dequeueReusableCell(withIdentifier: "FirstCustomCell", for: indexPath) as? FirstCustomCell else { return UITableViewCell()}
        
        let city = cities[indexPath.row]
        cell.configure(with: city)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        125
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cityTitle = cities[indexPath.row].name
        let cityId = cities[indexPath.row].id
        let placesVC = PlacesViewController(myTitle: cityTitle, id: cityId)
        self.navigationController?.pushViewController(placesVC, animated: true)
    }
    
}
