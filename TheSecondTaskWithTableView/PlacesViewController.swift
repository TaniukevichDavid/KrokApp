
import Foundation
import UIKit
import Alamofire

class PlacesViewController: UIViewController {
    let tableView = UITableView()
    let myTitle: String
    let id: Int
    let imageUrl = "http://krokapp.by/api/get_points/11/"
    let infoUrl = "http://krokapp.by/api/rest/points/"
    var places: [Places] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var namePlaces: [NamePlaces] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    init(myTitle: String, id: Int) {
        self.myTitle = myTitle
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .orange
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        view.backgroundColor = .white
        setUpTableVIew()
        configureNavigationBar(largeTitleColor: .black, backgoundColor: .white, title: myTitle, preferredLargeTitle: true)
        getImagePlaces(url: imageUrl, id: id)
        getNamePlaces(url: infoUrl, id: id)
    }
    
    
    private func setUpTableVIew() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SecondCustomCell.self, forCellReuseIdentifier: "SecondCustomCell")
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func getImagePlaces(url: String, id: Int) {
        Alamofire.request(url).responseJSON { responce in
            guard let result = responce.data else { return }
            do {
                self.places = try JSONDecoder().decode([Places].self, from: result).filter({$0.city_id == id && $0.lang == 1} )
                print(self.places)
            } catch  {
                print(error)
            }
        }
        
    }
    
    private func getNamePlaces(url: String, id: Int) {
        Alamofire.request(url).responseJSON { responce in
            guard let result = responce.data else { return }
            do {
                self.namePlaces = try JSONDecoder().decode([NamePlaces].self, from: result).filter({$0.city.id == id})
            } catch  {
                print(error)
            }
        }
        
    }
    
    
}


extension PlacesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell  = tableView.dequeueReusableCell(withIdentifier: "SecondCustomCell", for: indexPath) as? SecondCustomCell else { return UITableViewCell()}
        
        let place = places[indexPath.row]
        let namePlaces = namePlaces[indexPath.row]
        cell.configure(with: place)
        cell.configure(with: namePlaces)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
    
    
}

extension String {
    init?(htmlEncodedString: String) {
        guard let data = htmlEncodedString.data(using: .utf8) else { return nil }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else { return nil }
        
        self.init(attributedString.string)
    }
}



