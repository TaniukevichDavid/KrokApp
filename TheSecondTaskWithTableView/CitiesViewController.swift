

import UIKit
import Alamofire

class CitiesViewController: UIViewController {
    
    let tableView = UITableView()
    
    let url = "https://krokapp.by/api/get_cities/11/"
    
    var cities: [Cities] = [] {
        didSet {
            DispatchQueue.main.async {
                if self.cities.count > 0{
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableVIew()
        getgetData(url: url)
        configureNavigationBar(largeTitleColor: .black, backgoundColor: .white, title: "Гарады", preferredLargeTitle: true)
        
    }
    
    private func setUpTableVIew() {
        view.addSubview(tableView)
        view.backgroundColor = .systemBackground
        tableView.backgroundColor = .systemBackground
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
        Alamofire.request(url).responseJSON { responce in
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
        150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = cities[indexPath.row].name
        let cityId = cities[indexPath.row].id
        let infoVC = PlacesViewController(myTitle: city, id: cityId)
        self.navigationController?.pushViewController(infoVC, animated: true)
    }
    
}



