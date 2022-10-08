//
//  FeedViewControllerCell.swift
//  TheDay
//
//  Created by 이석원 on 2022/10/08.
//

import UIKit
import SnapKit
import Kingfisher

class FeedViewControllerCell : UICollectionViewCell {
    
    private lazy var titleLabel : UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 20.0, weight: .bold)
        label.textColor = .white
    
       return label
    }()
    
    private lazy var descriptionLabel : UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .bold)
        label.textColor = .white
    
       return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12.0
        imageView.backgroundColor = .gray
        
        return imageView
    }()
    
    func setup(feed: Feed) {
        setupSubViews()
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 10
        
        titleLabel.text = feed.title
        descriptionLabel.text = feed.description
        
        if let imageURL = URL(string: feed.imageURL) {
            imageView.kf.setImage(with: imageURL)
        }
    }
}

//layout 설정
private extension FeedViewControllerCell {
    func setupSubViews() {
        [imageView, titleLabel, descriptionLabel]
            .forEach { addSubview($0) }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24.0)
            $0.trailing.equalToSuperview().inset(24.0)
            $0.top.equalToSuperview().inset(24.0)
        }
   
        descriptionLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24.0)
            $0.trailing.equalToSuperview().inset(24.0)
            $0.bottom.equalToSuperview().inset(24.0)
        }
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
}




