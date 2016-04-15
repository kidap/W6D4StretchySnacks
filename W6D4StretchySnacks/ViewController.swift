//
//  ViewController.swift
//  W6D4StretchySnacks
//
//  Created by Karlo Pagtakhan on 04/14/2016.
//  Copyright © 2016 AccessIT. All rights reserved.
//
//1090416028 Joe
import UIKit

class ViewController: UIViewController {
  var navBarViewHeight = NSLayoutConstraint()
  let navBarView = UIView(frame: CGRectZero)
  let tableViewController = UITableViewController(style: .Plain)
  let addButton = UIButton(frame: CGRectZero)
  let stackView = UIStackView()
  let titleLabel = UILabel()
  var snackCollection = [(name:String,imageView:UIImageView)]()
  var sourceArray = [String]()
  var autoLayoutEnabled = false
  var navBarHeight:CGFloat = 64
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    print("viewDidLoad")
    prepareView()
    addViews()
    if autoLayoutEnabled{
      prepareConstraints()
    } else {
      prepareFrames()
    }
  }
  
  //MARK: Preparation
  func prepareView(){
    view.backgroundColor = UIColor(colorLiteralRed: 0.867, green:0.867, blue:0.867, alpha:1)
    
    //Prepare View
    tableViewController.tableView.delegate = self
    tableViewController.tableView.dataSource = self
    tableViewController.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    
    addButton.setTitle("➕", forState: .Normal)
    addButton.tintColor = UIColor.blueColor()
    addButton.titleLabel?.textColor = UIColor.blueColor()
    addButton.addTarget(self, action: #selector(ViewController.addButtonClicked), forControlEvents: .TouchDown)
    
    titleLabel.text = "Snacks"
    titleLabel.textColor = UIColor.blackColor()
    
    stackView.axis = .Horizontal
    stackView.distribution = .FillEqually
//    stackView.hidden = true
    stackView.alpha = 0
    
  }
  func addViews(){
    // Add to the view
    self.view.addSubview(navBarView)
    self.view.addSubview(tableViewController.tableView)
    navBarView.addSubview(titleLabel)
    navBarView.addSubview(stackView)
    navBarView.addSubview(addButton)
    
    let imageView1 = UIImageView(image: UIImage(named: "ramen"))
    let imageView2 = UIImageView(image: UIImage(named: "oreos"))
    let imageView3 = UIImageView(image: UIImage(named: "pizza_pockets"))
    let imageView4 = UIImageView(image: UIImage(named: "pop_tarts"))
    let imageView5 = UIImageView(image: UIImage(named: "popsicle"))
    
    snackCollection = [ ("Ramen", imageView1),
                        ("Oreos", imageView2),
                        ("Pizza pockets", imageView3),
                        ("Pop tarts", imageView4),
                        ("Popsicle", imageView5) ]
    
    for (_,imageView) in snackCollection{
      imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ViewController.snackTapped(_:))))
      imageView.userInteractionEnabled = true
      stackView.addArrangedSubview(imageView)
    }
//    stackView.userInteractionEnabled = true
    print(stackView.subviews.count)
  }
  func prepareConstraints(){
    // Enable Auto Layout
    view.translatesAutoresizingMaskIntoConstraints = false
    navBarView.translatesAutoresizingMaskIntoConstraints = false
    tableViewController.tableView.translatesAutoresizingMaskIntoConstraints = false
    addButton.translatesAutoresizingMaskIntoConstraints = false
    stackView.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    
    //Add constraints
    navBarView.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor).active = true
    navBarView.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor).active = true
    navBarView.topAnchor.constraintEqualToAnchor(view.topAnchor).active = true
    navBarViewHeight = navBarView.heightAnchor.constraintEqualToConstant(66)
    navBarViewHeight.active = true
    
    tableViewController.tableView.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor).active = true
    tableViewController.tableView.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor).active = true
    tableViewController.tableView.topAnchor.constraintEqualToAnchor(navBarView.bottomAnchor).active = true
    tableViewController.tableView.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor).active = true
    
    addButton.topAnchor.constraintEqualToAnchor(navBarView.topAnchor, constant: 5).active = true
    addButton.trailingAnchor.constraintEqualToAnchor(navBarView.trailingAnchor, constant: -5).active = true
    addButton.heightAnchor.constraintEqualToConstant(56).active = true
    addButton.widthAnchor.constraintEqualToConstant(56).active = true
    
    titleLabel.topAnchor.constraintEqualToAnchor(topLayoutGuide.bottomAnchor, constant: 5).active = true
    titleLabel.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor, constant: 0).active = true
    
    stackView.leadingAnchor.constraintEqualToAnchor(navBarView.leadingAnchor, constant: 5).active = true
    stackView.trailingAnchor.constraintEqualToAnchor(navBarView.trailingAnchor, constant: -5).active = true
    stackView.bottomAnchor.constraintEqualToAnchor(navBarView.bottomAnchor, constant: -5).active = true
    stackView.heightAnchor.constraintEqualToConstant(100).active = true
  }
  func prepareFrames(){
    navBarView.frame = CGRect(x: 0,
                              y: 0,
                              width: view.frame.width,
                              height: navBarHeight)
    tableViewController.tableView.frame = CGRect(x: 0,
                                                 y: navBarView.frame.maxY,
                                                 width: view.frame.height,
                                                 height: (view.frame.height - navBarView.frame.height))
    titleLabel.frame.origin.y = navBarView.frame.origin.y + 25
    titleLabel.sizeToFit()
    titleLabel.center.x = navBarView.center.x
    stackView.frame = CGRect(x: 0,
                             y: 80 ,
                             width: navBarView.frame.width,
                             height: 100)
    addButton.frame =  CGRect(x: view.frame.width - 5 - 64,
                              y: navBarView.frame.height - 64,
                              width: 64,
                              height: 64)
  }
  
  //MARK: Actions
  func addButtonClicked(){
    print("Button clicked")
    if autoLayoutEnabled{
      if addButton.selected{
        navBarViewHeight.active = false
        navBarViewHeight = navBarView.heightAnchor.constraintEqualToConstant(64)
        navBarViewHeight.active = true
        addButton.selected = false
        addButton.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
        stackView.hidden = true
      } else{
        navBarViewHeight.active = false
        navBarViewHeight = navBarView.heightAnchor.constraintEqualToConstant(150)
        navBarViewHeight.active = true
        addButton.selected = true
        addButton.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI_4))
        stackView.hidden = false
      }
      view.layoutIfNeeded()
    } else{
      if addButton.selected{
        addButton.selected = false
        addButton.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
        collapseNavBar()
      } else{
        addButton.selected = true
        addButton.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI_4))
        expandNavBar()
      }
      view.layoutIfNeeded()    }
  }
  func snackTapped(sender:AnyObject){
    if let recognizer = sender as? UITapGestureRecognizer{
      let result = snackCollection.filter{$0.imageView == recognizer.view}
      sourceArray.append(result.first!.name)
      print(result.first!.name)
      tableViewController.tableView.reloadData()
    }
  }

  func collapseNavBar(){
    UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [], animations: {
      self.tableViewController.tableView.frame.offsetInPlace(dx: 0, dy: -150)
      self.navBarView.frame.size.height -= 150
      self.stackView.frame.offsetInPlace(dx: 0, dy: -5)
      self.titleLabel.frame.offsetInPlace(dx: 0, dy: -5)
      self.stackView.alpha = 0
    }) { (status) in
    }
  }
  func expandNavBar(){
    print(navBarView.frame)
    print(stackView.frame)
    UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 10, options: [], animations: {
      self.tableViewController.tableView.frame.offsetInPlace(dx: 0, dy: 150)
      self.stackView.frame.offsetInPlace(dx: 0, dy: 5)
      self.titleLabel.frame.offsetInPlace(dx: 0, dy: 5)
      self.navBarView.frame.size.height += 150
      self.stackView.alpha = 1
    }) { (status) in
    }
    
  }
}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return sourceArray.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
    cell.textLabel?.text = sourceArray[indexPath.row]
    return cell
  }
  
}

