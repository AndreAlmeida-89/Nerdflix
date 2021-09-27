//
//  ActorCollectionViewCell.swift
//  Nerdflix
//
//  Created by André Felipe de Sousa Almeida - AAD on 26/09/21.
//

import UIKit
import Kingfisher

class ActorCollectionViewCell: UICollectionViewCell {
    static let identifier = "ActorCollectionViewCell"
    @IBOutlet weak var ivActor: UIImageView!
    @IBOutlet weak var lbActorName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setupUI(with actor: Actor){
        ivActor.kf.setImage(with: actor.image)
        lbActorName.text = actor.name
        ivActor.layer.cornerRadius = 50
    }

}
