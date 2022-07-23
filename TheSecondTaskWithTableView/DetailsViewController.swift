

import UIKit

class DetailsViewController: UIViewController {
    private let placeImage = UIImageView()
    private let placeTextLabel = UILabel()
    private let placeId: Int
    private let placePhoto: String
    private let namePlaces: String
    private let dataCreationPlaceLabel = UILabel()
    private let dataCreation: String
    private let infoPlaces: String
    private let myTextView = UITextView()
    private let playButton = UIButton()
    private lazy var changePosition = false
    
    init(placesId: Int, placesPhoto: String, namePlaces: String, dataCreation: String, infoPlaces: String) {
        self.placeId = placesId
        self.placePhoto = placesPhoto
        self.namePlaces = namePlaces
        self.dataCreation = dataCreation
        self.infoPlaces = infoPlaces
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        startInstallations()
    }
    
    private func startInstallations() {
        setUpAddsSubviewsAndMasks()
        setUpAddsSubviewsAndMasks()
        setUpPlaceImageView()
        setUpPlaceTextLabel()
        setUpDataCreationPlaceLabel()
        setUpMyTextView()
        setUpPlayButton()
    }
    
    private func setUpAddsSubviewsAndMasks() {
        [placeImage, placeTextLabel, playButton, myTextView, dataCreationPlaceLabel].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setUpPlaceImageView() {
        placeImage.loadImageFromURL(urlString: placePhoto)
        NSLayoutConstraint.activate([
            placeImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            placeImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            placeImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 95),
            placeImage.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    private func setUpPlaceTextLabel() {
        placeTextLabel.text = namePlaces
        placeTextLabel.textAlignment = .center
        placeTextLabel.textColor = .black
        placeTextLabel.numberOfLines = 0
        placeTextLabel.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        NSLayoutConstraint.activate([
            placeTextLabel.topAnchor.constraint(equalTo: placeImage.bottomAnchor, constant: 25),
            placeTextLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            placeTextLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            placeTextLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func setUpPlayButton() {
        playButton.tintColor = .systemOrange
        playButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
        playButton.addTarget(self, action: #selector(changeImageButton), for: .touchUpInside)
        NSLayoutConstraint.activate([
            playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playButton.topAnchor.constraint(equalTo: placeTextLabel.bottomAnchor, constant: 5),
            playButton.heightAnchor.constraint(equalToConstant: 40),
            playButton.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc func changeImageButton() {
        changePosition.toggle()
        changePosition == false ? playButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)  : playButton.setBackgroundImage(UIImage(systemName: "stop.fill"), for: .normal)
    }
    
    private func setUpMyTextView() {
        myTextView.text = infoPlaces
        myTextView.textAlignment = .center
        myTextView.font = UIFont.systemFont(ofSize: 20, weight: .light)
        NSLayoutConstraint.activate([
            myTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            myTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            myTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -115),
            myTextView.topAnchor.constraint(equalTo: placeTextLabel.bottomAnchor, constant: 45)
        ])
    }
    
    private func setUpDataCreationPlaceLabel() {
        dataCreationPlaceLabel.text = "Дата публікацыі: \(dataCreation)"
        dataCreationPlaceLabel.font = UIFont.systemFont(ofSize: 15, weight: .light)
        dataCreationPlaceLabel.textColor = .black
        NSLayoutConstraint.activate([
            dataCreationPlaceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            dataCreationPlaceLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -90)
        ])
    }
    
}
