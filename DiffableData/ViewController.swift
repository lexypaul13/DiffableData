//
//  ViewController.swift
//  DiffableData
//
//  Created by Alex Paul on 3/4/23.
//

import UIKit


enum Section {
    case main
    case secondary
}

class ViewController: UIViewController, UICollectionViewDelegate {
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier:ItemCollectionViewCell.reuseIdentifier)
        collectionView.register(
            TitleCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: TitleCollectionReusableView.reuseIdentifier
        )
        collectionView.delegate = self
        collectionView.backgroundColor = .gray
        return collectionView
    }()
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
    var items = [
        Item(id: 1, title: "Item 1", images: UIImage(named: "1")!),
        Item(id: 2, title: "Item 2", images: UIImage(named: "2")!),
        Item(id: 3, title: "Item 3", images: UIImage(named: "3")!),
        Item(id: 4, title: "Item 4", images: UIImage(named: "4")!),
        Item(id: 5, title: "Item 5", images: UIImage(named: "5")!),
        Item(id: 6, title: "Item 6", images: UIImage(named: "6")!),
        Item(id: 7, title: "Item 7", images: UIImage(named: "7")!),
        Item(id: 8, title: "Item 8", images: UIImage(named: "8")!),
        Item(id: 9, title: "Item 9", images: UIImage(named: "9")!)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
        
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) { collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.reuseIdentifier, for: indexPath) as! ItemCollectionViewCell
            let itemForRow = self.items[indexPath.item]
            cell.configure(with: itemForRow)
            return cell
        }
        
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: TitleCollectionReusableView.reuseIdentifier,
                for: indexPath
            ) as! TitleCollectionReusableView
            return headerView
        }
        
        // Apply the initial snapshot to the data source
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalWidth(0.6))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)

            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.6))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
            group.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
            group.interItemSpacing = .fixed(8)

        
        // Create and configure the section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        section.interGroupSpacing = 8
        
        
        //Header
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(60) // Adjust the height as needed
        )
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        header.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        section.boundarySupplementaryItems = [header]
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    // Handle item selection
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Update the data model
        
        // Apply the updated snapshot to the data source
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 60) // Adjust the height as needed
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: TitleCollectionReusableView.reuseIdentifier,
                for: indexPath
            ) as? TitleCollectionReusableView else {
                fatalError("Invalid view type")
            }
            return headerView
            
        default:
            assertionFailure("Unexpected element kind")
            return UICollectionReusableView()
        }
    }
}
