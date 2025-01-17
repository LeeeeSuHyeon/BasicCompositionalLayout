//
//  ViewController.swift
//  BasicCompositionalLayout
//
//  Created by 이수현 on 7/23/24.
//

import UIKit

class ViewController: UIViewController {
    let imageUrl = "https://cdn.mkhealth.co.kr/news/photo/202402/67298_72713_3150.png"
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    private var dataSource : UICollectionViewDiffableDataSource<Section, Item>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()     // collectionView UI 설정
        
        // 셀 구현
        collectionView.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: BannerCollectionViewCell.id)
        collectionView.register(NormalCarouselCollectionViewCell.self, forCellWithReuseIdentifier: NormalCarouselCollectionViewCell.id)
        collectionView.register(ListCarouselCollectionViewCell.self, forCellWithReuseIdentifier: ListCarouselCollectionViewCell.id)
        collectionView.setCollectionViewLayout(createLayout(), animated: true)
        
        setDataSource()  // 데이터 소스 설정
        setSnapShot()    // snapShot 설정
    }
    
    private func setUI(){
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            
            switch itemIdentifier {
                
            case .banner(let item):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.id, for: indexPath) as? BannerCollectionViewCell
                else { return UICollectionViewCell() }
                
                cell.config(title: item.title, imageUrl: item.imageUrl)
                
                return cell
                
            case .normalCarousel(let item):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NormalCarouselCollectionViewCell.id, for: indexPath) as? NormalCarouselCollectionViewCell
                else {return UICollectionViewCell()}
                
                cell.config(imageUrl: item.imageUrl, title: item.title, subTitle: item.subTitle)
                return cell
                
            case .listCarousel(let item):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCarouselCollectionViewCell.id, for: indexPath) as? ListCarouselCollectionViewCell
                else { return UICollectionViewCell()}
                
                cell.config(imageUrl: item.imageUrl, title: item.title, subTitle: item.subTitle)
                return cell
            }

        })
    }
    
    private func setSnapShot(){
        var snapShot = NSDiffableDataSourceSnapshot<Section, Item>()
        
        // Banner
        snapShot.appendSections([Section(id: "Banner")])
        
        let bannerItem = [
            Item.banner(HomeItem(title: "교촌 치킨", imageUrl: imageUrl)),
            Item.banner(HomeItem(title: "bbq 치킨", imageUrl: imageUrl)),
            Item.banner(HomeItem(title: "bhc 치킨", imageUrl: imageUrl))
        ]
        
        snapShot.appendItems(bannerItem, toSection: Section(id: "Banner"))
        
        
        // NormalCarousel
        let normalCarousel = Section(id: "NormalCarousel")
        snapShot.appendSections([normalCarousel])
        
        let normalCarouselItem = [
            Item.normalCarousel(HomeItem(title: "title1", subTitle: "subtitle1", imageUrl: imageUrl)),
            Item.normalCarousel(HomeItem(title: "title2", subTitle: "subtitle2", imageUrl: imageUrl)),
            Item.normalCarousel(HomeItem(title: "title3", subTitle: "subtitle3", imageUrl: imageUrl)),
            Item.normalCarousel(HomeItem(title: "title4", subTitle: "subtitle4", imageUrl: imageUrl)),
            Item.normalCarousel(HomeItem(title: "title5", subTitle: "subtitle5", imageUrl: imageUrl)),
            Item.normalCarousel(HomeItem(title: "title6", subTitle: "subtitle6", imageUrl: imageUrl))
        ]
        snapShot.appendItems(normalCarouselItem, toSection: normalCarousel)
        
        // ListCarousel
        let listCarousel = Section(id: "ListCarousel")
        snapShot.appendSections([listCarousel])
        
        let listCarouselItem = [
            Item.listCarousel(HomeItem(title: "title1", subTitle: "subtitle1", imageUrl: imageUrl)),
            Item.listCarousel(HomeItem(title: "title2", subTitle: "subtitle2", imageUrl: imageUrl)),
            Item.listCarousel(HomeItem(title: "title3", subTitle: "subtitle3", imageUrl: imageUrl)),
            Item.listCarousel(HomeItem(title: "title4", subTitle: "subtitle4", imageUrl: imageUrl)),
            Item.listCarousel(HomeItem(title: "title5", subTitle: "subtitle5", imageUrl: imageUrl)),
            Item.listCarousel(HomeItem(title: "title6", subTitle: "subtitle6", imageUrl: imageUrl))
        ]
        snapShot.appendItems(listCarouselItem, toSection: listCarousel)
        
        dataSource?.apply(snapShot)
        
        
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        // config 생성 (레이아웃 간 패딩 추가)
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        
        // index에 따라 다른 레이아웃을 리턴할 수 있음
        return UICollectionViewCompositionalLayout(sectionProvider: { sectionIndex, environment in
            
            switch sectionIndex {
            // banner
            case 0 :
                return self.createBannerSection()
                
            // normalCarousel
            case 1 :
                return self.createNormalCarousel()
            
            // SubCarousel
            case 2 :
                return self.createListCarousel()
                
            default :
                return self.createBannerSection()
            }
            
        }, configuration: config)
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
    
    private func createNormalCarousel() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 15)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7), heightDimension: .absolute(120))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)   // 섹션의 패딩 설정
        return section
    }
    
    private func createListCarousel() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 0, bottom: 0, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(250))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 3)    // 3개 이후부터는 옆으로 이동
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }


}




// 컬렉션 뷰 cell UI - 등록
// 레이아웃 구현 - 3가지
// dataSource -> cellProvider
// snapshot -> datasource.apply(snaphot)
