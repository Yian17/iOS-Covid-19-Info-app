//
//  StatisticCollectionViewCell.swift
//  Canada Covid-19 Info
//
//  Created by allets on 2020-11-18.
//

import UIKit
import SnapKit

class StatisticCollectionViewCell: UICollectionViewCell {
    
    let confirmedLabel: UILabel = UILabel()
    let deathsLabel: UILabel = UILabel()
    let recoveredLabel: UILabel = UILabel()
    let dateLabel: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
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
//        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(confirmedLabel)
        stackView.addArrangedSubview(deathsLabel)
        stackView.addArrangedSubview(recoveredLabel)

//        stackView.addArrangedSubview(recoveredLabel)
//        stackView.addArrangedSubview(dateLabel)
        deathsLabel.font = UIFont.systemFont(ofSize: 14.0)
        deathsLabel.numberOfLines = 0
        recoveredLabel.font = UIFont.systemFont(ofSize: 14.0)
        recoveredLabel.numberOfLines = 0
        confirmedLabel.font = UIFont.systemFont(ofSize: 14.0)
        confirmedLabel.numberOfLines = 0
        
        contentView.addSubview(stackView)
        
        stackView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(15)
//            make.left.equalTo(dateLabel.snp.right).offset(100)
            make.bottom.equalTo(contentView).offset(-15)
            make.right.equalTo(contentView).offset(-25)
        }
        contentView.addSubview(dateLabel)
        dateLabel.font = UIFont.boldSystemFont(ofSize: 15.0)
        dateLabel.numberOfLines = 0
        dateLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.left.equalTo(contentView).offset(20)
        }
        
    }
    
    func configure(model: StatisticModel) {
//        confirmedLabel.text = "Confirmed: " + String(model.confirmed)
        confirmedLabel.attributedText = attributedStatsText(boldText: "Confirmed: ", normalText: String(model.confirmed))
        deathsLabel.attributedText = attributedStatsText(boldText: "Deaths: ", normalText: String(model.deaths))
        recoveredLabel.attributedText = attributedStatsText(boldText: "Recovered: ", normalText: String(model.recovered))
        let dateSubString = model.date[0..<10]
        dateLabel.text = dateSubString
    }
    
    func attributedStatsText(boldText: String, normalText:String) -> NSMutableAttributedString {
        
        let boldText = boldText
        let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)]
        let attributedString = NSMutableAttributedString(string:boldText, attributes:attrs)

        let normalText = String(normalText)
        let normalString = NSMutableAttributedString(string:normalText)

        attributedString.append(normalString)
        return attributedString
    }
    
}
