//
//  CollectionHeaderReusableView.swift
//  DouyuZB
//
//  Created by dingjunchuxing on 2019/3/13.
//  Copyright © 2019 swifelearn. All rights reserved.
//

import UIKit

class CollectionHeaderReusableView: UICollectionReusableView {

    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet weak var headerName: UILabel!
   
    var group : AnchorGroup? {
        didSet {
            headerName.text = group?.tag_name
            icon.image = UIImage(named: group?.icon_url ?? "home_header_normal")
        }
    }
    
}
