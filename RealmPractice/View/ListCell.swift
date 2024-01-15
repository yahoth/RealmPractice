//
//  ListCell.swift
//  RealmPractice
//
//  Created by TAEHYOUNG KIM on 1/13/24.
//

import UIKit

import SnapKit

class ListCell: UITableViewCell {

    let startPlaceLabel = UILabel()
    let endPlaceLabel = UILabel()
    let createDate = UILabel()

    var labels: [UILabel] {
        [createDate, startPlaceLabel, endPlaceLabel]
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        labels.forEach(set(_:))
        labels.forEach(contentView.addSubview(_:))
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(_ label: UILabel) {
        label.textColor = .label
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20, weight: .bold)
    }

    func setConstraints() {
        createDate.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView).inset(16)
        }

        startPlaceLabel.snp.makeConstraints { make in
            make.top.equalTo(createDate.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(contentView).inset(16)
        }

        endPlaceLabel.snp.makeConstraints { make in
            make.top.equalTo(startPlaceLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(contentView).inset(20)
            make.bottom.equalTo(contentView).inset(16)
        }
    }

    func configure(item: TrackingData) {
        createDate.text = item.startDate.formattedString(.full)
        startPlaceLabel.text = item.startLocation
        endPlaceLabel.text = item.endLocation
    }
}
