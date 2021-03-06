
import Foundation
import UIKit
import PINRemoteImage

public class UpcomingEventCell: UICollectionViewCell {
    
    public static let cellID = "UpcomingEventCellID"
    
    public var eventImageTopAnchor: NSLayoutConstraint?
    
    override public var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.2, animations: {
                self.transform = self.isHighlighted ? CGAffineTransform(scaleX: 0.9, y: 0.9) : CGAffineTransform.identity
                self.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    override public var isSelected: Bool {
        didSet {
            UIView.animate(withDuration: 0.2, animations: {
                self.transform = self.isSelected ? CGAffineTransform(scaleX: 0.9, y: 0.9) : CGAffineTransform.identity
                self.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    public let eventImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.brandBackground
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 4.0
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    public lazy var favouriteButton: UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.setImage(UIImage(named: "ic_favourite_inactive"), for: UIControl.State.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    public let eventNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.brandBlack
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    public let eventDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.brandBlack
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public let priceView: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.brandPrimary, for: UIControl.State.normal)
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 5.0
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.medium)
        button.contentEdgeInsets = UIEdgeInsets(top: 8.0, left: 5.0, bottom: 8.0, right: 5.0)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.configureView()
    }
    
    private func configureView() {
        self.addSubview(eventImageView)
        self.addSubview(eventNameLabel)
        self.addSubview(eventDateLabel)
        self.addSubview(favouriteButton)
        self.addSubview(priceView)
        
        eventImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        eventImageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.eventImageTopAnchor = eventImageView.topAnchor.constraint(equalTo: self.topAnchor)
        self.eventImageTopAnchor?.isActive = true
        eventImageView.heightAnchor.constraint(equalToConstant: 162.0).isActive = true
        
        favouriteButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15.0).isActive = true
        favouriteButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 15.0).isActive = true
        favouriteButton.heightAnchor.constraint(equalToConstant: 35.0).isActive = true
        favouriteButton.widthAnchor.constraint(equalToConstant: 35.0).isActive = true
        
        eventNameLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        eventNameLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        eventNameLabel.topAnchor.constraint(equalTo: eventImageView.bottomAnchor, constant: 12).isActive = true
        eventNameLabel.heightAnchor.constraint(equalToConstant: 16.0).isActive = true
        
        eventDateLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        eventDateLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        eventDateLabel.topAnchor.constraint(equalTo: eventNameLabel.bottomAnchor, constant: 8).isActive = true
        eventDateLabel.heightAnchor.constraint(equalToConstant: 14.0).isActive = true
        
        priceView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15.0).isActive = true
        priceView.bottomAnchor.constraint(equalTo: eventImageView.bottomAnchor, constant: -15.0).isActive = true
        priceView.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
