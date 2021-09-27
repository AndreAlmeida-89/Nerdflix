//
//  Header.swift
//  Nerdflix
//
//  Created by André Felipe de Sousa Almeida - AAD on 26/09/21.
//

import UIKit
import Kingfisher

@IBDesignable
class Header: UIView, LoadableView {
    var contentView: UIView?
    private var movie: Movie?
    @IBInspectable var title: String = ""
    
    @IBOutlet weak var lbHeader: UILabel!
    @IBOutlet weak var ivPoster: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbStars: UILabel!
    
    // MARK: Overrides
    override init(frame: CGRect) {
        super.init(frame: frame)
        defaultSetup()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        defaultSetup()
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
     
    func set(movie: Movie){
        self.movie = movie
        setupUI()
    }
    
    private func setupUI(){
        guard let movie = movie else { return }
        lbTitle.text = movie.title
        ivPoster.kf.setImage(with: movie.image)
        ivPoster.layer.cornerRadius = 5
        lbStars.text = movie.stars
        lbHeader.text = title
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let movie = movie else { return }
        print("filme escolhido: \(movie.title)")
    }
    
}
