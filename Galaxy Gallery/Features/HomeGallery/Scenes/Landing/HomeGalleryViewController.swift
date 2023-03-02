//
//  HomeGalleryViewController.swift
//  Galaxy Gallery
//
//  Created by Vignesh A on 01/03/23.
//

import UIKit
import SDWebImage

class HomeGalleryViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var astroImageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    let viewModel: HomeGalleryViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInterface()
        setupBindings()
    }
    
    init(viewModel: HomeGalleryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "HomeGalleryViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupInterface() {
        activityIndicator.startAnimating()
        self.viewModel.viewLoad()
    }
    
    func setupBindings() {
        viewModel.astronomyPicture += PropertyObserver(uniqueTarget: self, callback: { [weak self] result in
            guard let self = self, let data = result else { return }           
            self.updateUI(data: data)           
        })
        
        viewModel.error += PropertyObserver(uniqueTarget: self, callback: { [weak self] _ in
            guard let self = self, let data = ASGalleryDataStore.shared.getStoredAPODData() else { return }
            self.updateUI(data: data)
        })
    }
    
    func updateUI(data: ASGalleryEntity) {
        self.titleLabel.text = data.title
        self.descriptionLabel.text = data.explanation
        guard let url = URL(string: data.hdurl) else { return }
        self.astroImageView.sd_setImage(with: url, completed: nil)
        let titleHeight = Utilities.heightForView(text: data.title, width: self.titleLabel.frame.width)
        let descriptionHeight = Utilities.heightForView(text: data.explanation, width: self.titleLabel.frame.width)
        self.scrollView.contentSize = CGSize(width: self.scrollView.frame.size.width, height: titleHeight + descriptionHeight + 300)
        self.activityIndicator.stopAnimating()
    }
    
}
