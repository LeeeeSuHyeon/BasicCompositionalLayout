//
//  NormalCarouselCollectionViewCell.swift
//  BasicCompositionalLayout
//
//  Created by 이수현 on 7/25/24.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher

class NormalCarouselCollectionViewCell : UICollectionViewCell {
    static let id = "NormalCarouselCell"
    
    private let mainImageView = UIImageView()
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    private func setUI(){
        self.addSubview(mainImageView)
        self.addSubview(titleLabel)
        self.addSubview(subTitleLabel)
        
        mainImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(80)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(mainImageView.snp.bottom).offset(8)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
    }
    
    func config(imageUrl : String, title : String, subTitle : String?){
        mainImageView.kf.setImage(with: URL(string: imageUrl))
        titleLabel.text = title
        subTitleLabel.text = subTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
