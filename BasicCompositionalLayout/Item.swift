//
//  Item.swift
//  BasicCompositionalLayout
//
//  Created by 이수현 on 7/23/24.
//

import Foundation


// 섹션과 아이템 정의
// 컬렉션 뷰의 섹션으로 들어가기 위해선 Hashable 프로토콜을 채택해야 함
struct Section : Hashable {
    let id : String
}

enum Item : Hashable {
    case banner(HomeItem)
    case normalCarousel(HomeItem)
    case listCarousel(HomeItem)
}

struct HomeItem : Hashable {
    let title : String
    let subTitle : String?
    let imageUrl : String
    
    init(title: String, subTitle: String? = "", imageUrl: String) {
        self.title = title
        self.subTitle = subTitle
        self.imageUrl = imageUrl
    }
}
