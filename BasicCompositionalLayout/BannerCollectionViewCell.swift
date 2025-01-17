//
//  BannerCollectionViewCell.swift
//  BasicCompositionalLayout
//
//  Created by 이수현 on 7/23/24.
//

import UIKit
import SnapKit
import Kingfisher

class BannerCollectionViewCell : UICollectionViewCell {
    static let id = "BannerCell"
    let titleLabel = UILabel()
    let backgroundImage = UIImageView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    

    
    private func setUI(){
        // SnapKit
        self.addSubview(backgroundImage)
        self.addSubview(titleLabel)
        
        // constraints 적용
        titleLabel.snp.makeConstraints{ make in
            make.center.equalToSuperview()
        }
        
        backgroundImage.snp.makeConstraints{ make in
//            make.leading.trailing.top.bottom.equalToSuperview()
            make.edges.equalToSuperview()
        }
    }
    
    // title, image set
    func config(title : String, imageUrl : String) {
        titleLabel.text = title
        
        // imageURL
        let url = URL(string: imageUrl)
        backgroundImage.kf.setImage(with: url)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

