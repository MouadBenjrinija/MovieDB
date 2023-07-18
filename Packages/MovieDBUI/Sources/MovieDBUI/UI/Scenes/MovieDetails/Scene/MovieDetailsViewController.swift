//
//  MovieDetailsViewController.swift
//  MovieDB
//
//  Created by Mouad Bj on 16/3/2023.
//

import UIKit
import MovieDBCore

class MovieDetailsViewController: UIViewController, NibLoadable {

  var viewModel: MovieDetailsViewModel!
  
  @IBOutlet weak var poster: UIImageView!

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var genresLabel: UILabel!
  @IBOutlet weak var descLabel: UILabel!
  
  @IBOutlet weak var mainView: UIView!
  @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
  
  var bag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    viewModel.loadDetails()
  }
  
  func setup() {
    viewModel.posterURL.sink { [weak self] in
      self?.poster.load(url: $0, placeholder: nil)
    }.store(in: &bag)
    
    viewModel.title.sink { [weak self] in
      self?.titleLabel.text = $0
    }.store(in: &bag)
    
    viewModel.description.sink { [weak self] in
      self?.descLabel.text = $0
    }.store(in: &bag)
    
    viewModel.genres.sink { [weak self] in
      self?.genresLabel.text = $0
    }.store(in: &bag)
    
    viewModel.isLoading.sink { [weak self] in
      self?.showLoading($0)
    }.store(in: &bag)
    
    navigationController?.setNavigationBarHidden(true, animated: false)
  }
  
  @IBAction func onBackTap(_ sender: Any) {
    viewModel.onBackPressed()
  }
  
  @IBAction func onShowTrailerTap(_ sender: Any) {
    viewModel.showTrailer()
  }
  
  private func showLoading(_ show: Bool) {
    if show {
      loadingIndicator.startAnimating()
    } else {
      loadingIndicator.startAnimating()
    }
    mainView.isHidden = show
  }
  
  deinit {
    print("MovieDetailsVC cleared")
  }
}
