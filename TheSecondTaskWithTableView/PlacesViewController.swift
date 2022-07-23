
import Foundation
import UIKit
import Alamofire

class PlacesViewController: UIViewController {
  private let tableView = UITableView()
  private let citieTitle: String
  private let id: Int
  private let imageUrl = "http://krokapp.by/api/get_points/11/"
  private let infoUrl = "http://krokapp.by/api/rest/points/"
  private var places: [Places] = [] {
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
        self.citieTitle = myTitle
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewAndNavBar()
        setUpTableVIew()
        getImagePlaces(url: imageUrl, id: id)
        getNamePlaces(url: infoUrl, id: id)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.tintColor = UIColor.orange
    }
    
    private func setUpViewAndNavBar() {
        view.backgroundColor = .white
        title = citieTitle
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
        AF.request(url).responseJSON { responce in
            guard let result = responce.data else { return }
            do {
                self.places = try JSONDecoder().decode([Places].self, from: result).filter({$0.city_id == id && $0.lang == 1 && $0.visible == true} )
            } catch  {
                print(error)
            }
        }
        
    }
    
    private func getNamePlaces(url: String, id: Int) {
        AF.request(url).responseJSON { responce in
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
        125
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let placesId = places[indexPath.row].city_id
        let creationDate = places[indexPath.row].creation_date
        let placesPhoto = places[indexPath.row].photo
        let namePlaces = namePlaces[indexPath.row].point_key_name
        let textPlaces = (places[indexPath.row].text.trimHTMLTags() ?? "<p>")
        let detailsVC = DetailsViewController(placesId: placesId, placesPhoto: placesPhoto, namePlaces: namePlaces, dataCreation: creationDate, infoPlaces: textPlaces)
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
}

extension String {
    public func trimHTMLTags() -> String? {
        guard let htmlStringData = self.data(using: String.Encoding.utf8) else {
            return nil
        }
        
        let options: [NSAttributedString.DocumentReadingOptionKey : Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        let attributedString = try? NSAttributedString(data: htmlStringData, options: options, documentAttributes: nil)
        return attributedString?.string
    }
}
