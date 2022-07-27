
import Foundation

import UIKit

class SecondCustomCell: UITableViewCell {
    
    var placeImage = UIImageView()
    private let namePlace = UILabel()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with Places: Places) {
        placeImage.loadImageFromURL(urlString: Places.logo)
        namePlace.text = Places.name
    }
    

    private func setUpLayout() {
        contentView.addSubview(namePlace)
        contentView.addSubview(placeImage)
        contentView.backgroundColor = .white
        namePlace.translatesAutoresizingMaskIntoConstraints = false
        placeImage.translatesAutoresizingMaskIntoConstraints = false
        namePlace.font = UIFont.systemFont(ofSize: 17, weight: .light)
        namePlace.textColor = .black
        namePlace.numberOfLines = 0
        namePlace.textAlignment = .left
        NSLayoutConstraint.activate([
            placeImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            placeImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            placeImage.heightAnchor.constraint(equalToConstant: 90),
            placeImage.widthAnchor.constraint(equalToConstant: 90),
            
            namePlace.leadingAnchor.constraint(equalTo: placeImage.trailingAnchor, constant: 15),
            namePlace.centerYAnchor.constraint(equalTo: placeImage.centerYAnchor),
            namePlace.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        placeImage.image = nil
        namePlace.text = nil
    }
    
}

