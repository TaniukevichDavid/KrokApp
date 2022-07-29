import UIKit

class FirstCustomCell: UITableViewCell {
    private var cityImage = UIImageView()
    private let nameСity = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with Cities: Cities) {
        nameСity.text = Cities.name
        cityImage.loadImageFromURL(urlString: Cities.logo)
    }
    
    private func setUpLayout() {
        contentView.addSubview(nameСity)
        contentView.addSubview(cityImage)
        nameСity.translatesAutoresizingMaskIntoConstraints = false
        cityImage.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .white
        nameСity.textAlignment = .center
        nameСity.textColor = .black
        nameСity.font = UIFont.systemFont(ofSize: 23, weight: .light)
        NSLayoutConstraint.activate([
            cityImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            cityImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cityImage.heightAnchor.constraint(equalToConstant: 90),
            cityImage.widthAnchor.constraint(equalToConstant: 90),
            
            nameСity.leadingAnchor.constraint(equalTo: cityImage.trailingAnchor, constant: 15),
            nameСity.centerYAnchor.constraint(equalTo: cityImage.centerYAnchor)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cityImage.image = nil
        nameСity.text = nil
    }
    
}
