//
//  NewsViewCellTableViewCell.swift
//  Canada Covid-19 Info
//
//  Created by allets on 2020-11-29.
//

import UIKit
import SnapKit
import SDWebImage

class NewsViewCell: UITableViewCell {
    
    private let descriptionLabel = UILabel()
    private let titleLabel = UILabel()
    private let newsImageView: UIImageView = UIImageView()
    private let dateLabel = UILabel()
    private let placeholder = "https://www.japantimes.co.jp/news/2020/12/02/world/science-health-world/us-nasal-spray-coronavirus/"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        commonInit()
    }
    
    func commonInit() {
        
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.leading
        stackView.spacing = 6
        
        stackView.addArrangedSubview(newsImageView)
        newsImageView.snp.makeConstraints { (make) in
            make.width.equalTo(UIScreen.main.bounds.width)
            make.height.equalTo(UIScreen.main.bounds.width * 0.6)
        }
        newsImageView.contentMode = .scaleToFill
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(descriptionLabel)
        
        contentView.addSubview(stackView)
        
        stackView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(10)
            make.bottom.equalTo(contentView).offset(-10)
            make.left.equalTo(contentView).offset(10)
            make.right.equalTo(contentView).offset(-10)
        }
        
        
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.boldSystemFont(ofSize: 15.0)
        
        dateLabel.numberOfLines = 0
        dateLabel.font = UIFont.boldSystemFont(ofSize: 13.0)
        dateLabel.textColor = .darkGray
        
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIFont.systemFont(ofSize: 13)
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(newsModel: News) {
        self.descriptionLabel.text = newsModel.description
        self.titleLabel.text = newsModel.title
        self.dateLabel.text = newsModel.published[0..<10]
        print("======title", newsModel.title)
        print("======url", newsModel.image)
        if newsModel.image != "None" {
            newsImageView.sd_setImage(with: URL(string: newsModel.image), placeholderImage: nil)
//            newsImageView.snp.makeConstraints { (make) in
//                make.width.equalTo(UIScreen.main.bounds.width)
//                make.height.equalTo(UIScreen.main.bounds.width * 0.6)
//            }
        } else {
            newsImageView.sd_setImage(with: URL(string: "https://cdn.japantimes.2xx.jp/wp-content/uploads/2020/12/np_file_54548-scaled-870x489.jpeg"), placeholderImage: nil)
            
        }
        
//        if newsImageView == nil {
//            print("===================")
//            print(titleLabel)
//        }
    }

}
