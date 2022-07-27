

import UIKit
import AVFoundation


class DetailsViewController: UIViewController {
    private let placeImage = UIImageView()
    private let placeTextLabel = UILabel()
    private let placeId: Int
    private let placePhoto: String
    private let namePlaces: String
    private let dataCreationPlaceLabel = UILabel()
    private let dataCreation: String
    private let soundOfPlace: String
    private let infoPlaces: String
    private let myTextView = UITextView()
    private let playButton = UIButton()
    private lazy var changePosition = false
    var player = AVPlayer()
    
    init(placesId: Int, placesPhoto: String, dataCreation: String, infoPlaces: String, namePlaces: String, soundOfPlace: String) {
        self.placeId = placesId
        self.placePhoto = placesPhoto
        self.namePlaces = namePlaces
        self.dataCreation = dataCreation
        self.infoPlaces = infoPlaces
        self.soundOfPlace = soundOfPlace
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        startInstallations()
        setUVoiceActing()
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
        [placeTextLabel, playButton, placeImage, myTextView, dataCreationPlaceLabel].forEach {
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
        if soundOfPlace != "" {
            playButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
            playButton.addTarget(self, action: #selector(changeImageButton), for: .touchUpInside)
        }
        NSLayoutConstraint.activate([
            playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playButton.topAnchor.constraint(equalTo: placeTextLabel.bottomAnchor, constant: 5),
            playButton.heightAnchor.constraint(equalToConstant: 40),
            playButton.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc func changeImageButton() {
        setUVoiceActing()
        changePosition.toggle()
        changePosition == false ? playButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)  : playButton.setBackgroundImage(UIImage(systemName: "stop.fill"), for: .normal)
        changePosition == false ? player.pause() : player.play()
        
    }
    
    private func setUVoiceActing() {
        if soundOfPlace != "" {
            do {
                try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            } catch {
                print ("AVAudioSessionCategoryPlayback not work" )
            }
            guard let url = URL (string: soundOfPlace) else { return }
            let playerItem:AVPlayerItem = AVPlayerItem(url: url)
            player = AVPlayer (playerItem: playerItem)
        }
    }
    
    private func setUpMyTextView() {
        myTextView.text = infoPlaces
        myTextView.isEditable = false
        myTextView.textAlignment = .center
        myTextView.backgroundColor = .white
        myTextView.textColor = .black
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
