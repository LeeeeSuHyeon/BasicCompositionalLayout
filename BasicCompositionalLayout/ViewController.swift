//
//  ViewController.swift
//  BasicCompositionalLayout
//
//  Created by 이수현 on 7/23/24.
//

import UIKit

class ViewController: UIViewController {
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    private var dataSource : UICollectionViewDiffableDataSource<Section, Item>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 셀 구현
        collectionView.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: BannerCollectionViewCell.id)
        collectionView.setCollectionViewLayout(createLayout(), animated: true)
        
        setDataSource()  // 데이터 소스 설정
        setSnapShot()    // snapShot 설정
    }
    
    private func setDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.id, for: indexPath) as? BannerCollectionViewCell 
            else { return UICollectionViewCell() }
            
//            cell.config(title: <#T##String#>, imageUrl: <#T##String#>)
            return cell
        })
    }
    
    private func setSnapShot(){
        var snapShot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapShot.appendSections([Section(id: "Banner")])
        
        let bannerItem = [
            Item.banner(HomeItem(title: "교촌 치킨", imageUrl: "https://cdn.mkhealth.co.kr/news/photo/202402/67298_72713_3150.png")),
            Item.banner(HomeItem(title: "bbq 치킨", imageUrl: "https://cdn.mkhealth.co.kr/news/photo/202402/67298_72713_3150.png")),
            Item.banner(HomeItem(title: "bhc 치킨", imageUrl: "https://cdn.mkhealth.co.kr/news/photo/202402/67298_72713_3150.png"))
        ]
        
        snapShot.appendItems(bannerItem, toSection: Section(id: "Banner"))
        dataSource?.apply(snapShot)
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        // index에 따라 다른 레이아웃을 리턴할 수 있음
        return UICollectionViewCompositionalLayout(sectionProvider: { [weak self] sectionIndex, environment in
            return self?.createBannerSection()
        })
    }
    
    private func createBannerSection() -> NSCollectionLayoutSection {
        // item
        // 해당 아이템 사이즈 정의
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)) // group 사이즈의 전체 영역을 사용하겠다
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(200)) // .absolute : 절대값
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item]) // 수평 스크롤 가능(horizontal)
        
        
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging // 스크롤
        return section
    }


}




// 컬렉션 뷰 cell UI - 등록
// 레이아웃 구현 - 3가지
// dataSource -> cellProvider
// snapshot -> datasource.apply(snaphot)
