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
  var snackCollection = [(name:String,imageView:UIImageView)]()
  var sourceArray = [String]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    prepareView()
    addViews()
    prepareConstraints()
  }
  //MARK: Preparation
  func prepareView(){
    view.backgroundColor = UIColor(colorLiteralRed: 0.867, green:0.867, blue:0.867, alpha:1)
    
    //Prepare View
    tableViewController.tableView.delegate = self
    tableViewController.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    
    addButton.setTitle("➕", forState: .Normal)
    addButton.tintColor = UIColor.blueColor()
    addButton.titleLabel?.textColor = UIColor.blueColor()
    addButton.addTarget(self, action: #selector(ViewController.addButtonClicked), forControlEvents: .TouchDown)
    
    stackView.axis = .Horizontal
    stackView.distribution = .FillEqually
    stackView.hidden = true

  }
  func addViews(){
    // Add to the view
    self.view.addSubview(navBarView)
    self.view.addSubview(tableViewController.tableView)
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
    print(stackView.subviews.count)
  }
  func prepareConstraints(){
    // Enable Auto Layout
    view.translatesAutoresizingMaskIntoConstraints = false
    navBarView.translatesAutoresizingMaskIntoConstraints = false
    tableViewController.tableView.translatesAutoresizingMaskIntoConstraints = false
    addButton.translatesAutoresizingMaskIntoConstraints = false
    stackView.translatesAutoresizingMaskIntoConstraints = false
    
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
    
    
    stackView.leadingAnchor.constraintEqualToAnchor(navBarView.leadingAnchor, constant: 5).active = true
    stackView.trailingAnchor.constraintEqualToAnchor(navBarView.trailingAnchor, constant: -5).active = true
    stackView.bottomAnchor.constraintEqualToAnchor(navBarView.bottomAnchor, constant: -5).active = true
    stackView.heightAnchor.constraintEqualToConstant(100).active = true
  }
  
  //MARK: Actions
  func addButtonClicked(){
    if addButton.selected{
      print("Button clicked")
      navBarViewHeight.active = false
      navBarViewHeight = navBarView.heightAnchor.constraintEqualToConstant(64)
      navBarViewHeight.active = true
      addButton.selected = false
      addButton.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
      stackView.hidden = true
    } else{
      print("Button clicked")
      navBarViewHeight.active = false
      navBarViewHeight = navBarView.heightAnchor.constraintEqualToConstant(150)
      navBarViewHeight.active = true
      addButton.selected = true
      addButton.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI_4))
      stackView.hidden = false
    }
    view.layoutIfNeeded()
  }
  func snackTapped(sender:AnyObject){
    if let recognizer = sender as? UITapGestureRecognizer{
      let result = snackCollection.filter{$0.imageView == recognizer.view}
      sourceArray.append(result.first!.name)
      print(result.first!.name)
      tableViewController.tableView.reloadData()
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

